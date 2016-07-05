//
//  CalendarView.m
//  QuickCard
//
//  Created by Destiny on 15/10/19.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "CalendarView.h"
#import "AFNetworking.h"

@interface CalendarView()

//日历
@property (nonatomic, strong) NSCalendar *gregorian;

//day button的高度
@property (nonatomic,assign) NSInteger dayWidth;

//日期的处理
@property (nonatomic, assign) NSCalendarUnit dayInfoUnits;

@property (nonatomic, assign) NSInteger shakes;
@property (nonatomic, assign) NSInteger shakeDirection;


//手势识别
@property (nonatomic, strong) UISwipeGestureRecognizer * swipeleft;
@property (nonatomic, strong) UISwipeGestureRecognizer * swipeRight;

@end

@implementation CalendarView

#pragma mark - Init

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _dayWidth = frame.size.width/7;
        _originX = 0;
        _originY = _dayWidth;
        
        _gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        _calendarDate = [NSDate date];
        _dayInfoUnits = NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
        
        
        _nextMonthAnimation = UIViewAnimationOptionTransitionCrossDissolve;
        _prevMonthAnimation = UIViewAnimationOptionTransitionCrossDissolve;
        
        //动画效果
        _swipeleft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(showNextMonth)];
        _swipeleft.direction = UISwipeGestureRecognizerDirectionLeft;
        [self addGestureRecognizer:_swipeleft];
        _swipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(showPreviousMonth)];
        _swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:_swipeRight];
        
    }
    return self;
}

#pragma mark - Public methods

/**
 *  下个月日历的按钮
 */
- (void)showNextMonth
{
    NSDateComponents *components = [_gregorian components:_dayInfoUnits fromDate:_calendarDate];
    components.day = 1;
    components.month ++;
    NSDate *nextMonthDate = [_gregorian dateFromComponents:components];
    
    if ([self canSwipeToDate:nextMonthDate])
    {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        _calendarDate = nextMonthDate;
        components = [_gregorian components:_dayInfoUnits fromDate:_calendarDate];
        [self performViewAnimation:_nextMonthAnimation];
    }
    else
    {
        [self performViewNoSwipeAnimation];
    }
}

/**
 *  上个月日历的按钮
 */
- (void)showPreviousMonth
{
    NSDateComponents *components = [_gregorian components:_dayInfoUnits fromDate:_calendarDate];
    components.day = 1;
    components.month --;
    NSDate * prevMonthDate = [_gregorian dateFromComponents:components];
    
    if ([self canSwipeToDate:prevMonthDate])
    {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        _calendarDate = prevMonthDate;
        components = [_gregorian components:_dayInfoUnits fromDate:_calendarDate];
        
        [self performViewAnimation:_prevMonthAnimation];
    }
    else
    {
        [self performViewNoSwipeAnimation];
    }
}

#pragma mark - Various methods

-(BOOL)canSwipeToDate:(NSDate *)date
{
    if (_datasource == nil) {
        return YES;
    }
    return [_datasource canSwipeToDate:date];
}

/**
 *  view的动画
 */
-(void)performViewAnimation:(UIViewAnimationOptions)animation
{
    
    [UIView transitionWithView:self
                      duration:0.5f
                       options:animation
                    animations:^ { [self setNeedsDisplay]; }
                    completion:nil];
}

-(void)performViewNoSwipeAnimation
{
    _shakeDirection = 1;
    _shakes = 0;
    [self shakeView:self];
}

//view的抖动
-(void)shakeView:(UIView *)theOneYouWannaShake
{
    [UIView animateWithDuration:0.05 animations:^
     {
         theOneYouWannaShake.transform = CGAffineTransformMakeTranslation(5*_shakeDirection, 0);
         
     } completion:^(BOOL finished)
     {
         if(_shakes >= 4)
         {
             theOneYouWannaShake.transform = CGAffineTransformIdentity;
             return;
         }
         _shakes++;
         _shakeDirection = _shakeDirection * -1;
         [self shakeView:theOneYouWannaShake];
     }];
}

#pragma mark - Button creation and configuration

//day的button定义
- (UIButton *)dayButtonWithFrame:(CGRect)frame
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    return button;
}

//day的button的内容和格式
-(void)configureDayButton:(UIButton *)button withDate:(NSDate*)date
{
    NSDateComponents *components = [_gregorian components:_dayInfoUnits fromDate:date];
    
    [button setTitle:[NSString stringWithFormat:@"%ld",(long)components.day] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    
    //设置图片和文字的位置
    button.titleEdgeInsets = UIEdgeInsetsMake(-_dayWidth * 0.37,_dayWidth * 0.28, 0, 0);
    button.imageEdgeInsets = UIEdgeInsetsMake(_dayWidth * 0.47, -_dayWidth * 0.15, 0, 0);
    
    //从数据库获取用户打卡信息
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [[AFJSONResponseSerializer alloc]init];
    
    //需要传入的Request数据
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:[NSString stringWithFormat:@"%ld-%ld-%ld",(long)components.year,(long)components.month,(long)components.day] forKey:@"clo_date"];
    [dict setValue:[NSString stringWithFormat:@"%d",1] forKey:@"user_id"];
    
    [manager POST:clock_showMy parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //获取传回的数据
        NSDictionary *resultDict = (NSDictionary *)responseObject;
        NSString *state = [resultDict valueForKey:@"data"];
        [button setImage:[UIImage imageNamed:state] forState:UIControlStateNormal];
        
        NSString *date;
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        date = [formatter stringFromDate:[NSDate date]];
        
        NSString *date2 = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)components.year,(long)components.month,(long)components.day];
        
        int result = [self compareDate:date withDate:date2];
        if(result == 1)
        {
            [button setImage:nil forState:UIControlStateNormal];
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"错误信息：%@",error);
        
    }];
    
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.enabled = NO;
    
}

//2个日期比较前后
- (int)compareDate:(NSString *)date1 withDate:(NSString *)date2
{
    int ci;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *dt1 = [[NSDate alloc]init];
    NSDate *dt2 = [[NSDate alloc]init];
    dt1 = [formatter dateFromString:date1];
    dt2 = [formatter dateFromString:date2];
    NSComparisonResult result = [dt1 compare:dt2];
    switch (result) {
        //date2比date1大
        case NSOrderedAscending:
            ci = 1;
            break;
        //date2比date1小
        case NSOrderedDescending:
            ci = -1;
            break;
        //date2=date1
        case NSOrderedSame:
            ci = 0;
            break;
            
        default:
            break;
    }
    return ci;
}

#pragma mark - Drawing methods

- (void)drawRect:(CGRect)rect
{
    //设置背景
    UIImageView *bgImg = [[UIImageView alloc]initWithFrame:CGRectMake(0,_dayWidth * 0.21 + 5, self.bounds.size.width,self.bounds.size.width - _dayWidth * 0.21 - 5)];
    bgImg.image = [UIImage imageNamed:@"calendar"];
    [self addSubview:bgImg];
    
    
    NSDateComponents *components = [_gregorian components:_dayInfoUnits fromDate:_calendarDate];
    
    components.day = 1;
    NSDate *firstDayOfMonth = [_gregorian dateFromComponents:components];
    NSDateComponents *comps = [_gregorian components:NSCalendarUnitWeekday fromDate:firstDayOfMonth];
    
    NSInteger weekdayBeginning = [comps weekday];
    weekdayBeginning -= 1;
    if(weekdayBeginning < 0)
        weekdayBeginning += 7;
    
    NSRange days = [_gregorian rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:_calendarDate];
    
    NSInteger monthLenth = days.length;
    NSInteger remainingDays = (monthLenth + weekdayBeginning) % 7;
    
    NSInteger maxY = _originY + _dayWidth * (NSInteger)(1+(monthLenth+weekdayBeginning)/7) + ((remainingDays != 0) ? _dayWidth:0);
    
    if(_delegate != nil && [_delegate respondsToSelector:@selector(setHeightNeeded:)])
        [_delegate setHeightNeeded:maxY];
    
    //自定义的上个月日历的按钮
    UIButton *buttonPrev = [[UIButton alloc]initWithFrame:CGRectMake(_dayWidth * 2.24, 0, _dayWidth * 0.56, _dayWidth * 0.56)];
    [buttonPrev setImage:[UIImage imageNamed:@"btn_left"] forState:UIControlStateNormal];
    [buttonPrev addTarget:self action:@selector(showPreviousMonth) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:buttonPrev];
    
    
    //自定义的上个月日历的按钮
    UIButton * buttonNext = [[UIButton alloc] initWithFrame:CGRectMake(_dayWidth * 4.2, 0, _dayWidth * 0.56, _dayWidth * 0.56)];
    [buttonNext setImage:[UIImage imageNamed:@"btn_right"] forState:UIControlStateNormal];
    [buttonNext addTarget:self action:@selector(showNextMonth) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:buttonNext];
    
    //获取年月日期
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy-MM"];
    NSString *dateStr = [[format stringFromDate:_calendarDate] uppercaseString];
    
    UILabel *titleText = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, self.bounds.size.width, _dayWidth * 0.21)];
    titleText.font = [UIFont systemFontOfSize:12];
    titleText.textAlignment = NSTextAlignmentCenter;
    titleText.text = dateStr;
    [titleText setTextColor:[UIColor blackColor]];
    
    [self addSubview:titleText];
    
    
    //当前月
    for(NSInteger i = 0; i < monthLenth; i++)
    {
        components.day = i + 1;
        
        NSInteger offsetX = (_dayWidth * ((i + weekdayBeginning)%7));
        NSInteger offsetY = (_dayWidth * ((i + weekdayBeginning)/7));
        
        UIButton *button = [self dayButtonWithFrame:CGRectMake(_originX+offsetX +2, _dayWidth+offsetY+12, _dayWidth, _dayWidth - 15)];
        
        [self configureDayButton:button withDate:[_gregorian dateFromComponents:components]];
        
        [self addSubview:button];
    }
}

@end
