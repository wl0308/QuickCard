//
//  AttendanceRecordsViewController.m
//  QuickCard
//
//  Created by Destiny on 15/10/15.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "AttendanceRecordsViewController.h"
#import "StaffAttendanceViewController.h"
#import "AFNetworking.h"


@interface AttendanceRecordsViewController ()

@property (nonatomic, strong) CalendarView * customCalendarView;
@property (nonatomic, strong) NSCalendar * gregorian;
@property (nonatomic, assign) NSInteger currentYear;

@property (nonatomic, strong) UILabel *lblMyAttendance;

@end

@implementation AttendanceRecordsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.hidden = NO;
    
    
    /**
     自定义导航栏左侧按钮
     */
    [self.navigationItem setHidesBackButton:YES];  //隐藏默认按钮
    
    UIButton *goBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    goBackBtn.frame = CGRectMake(0, 0 , 28, 28);
    [goBackBtn setBackgroundImage:[UIImage imageNamed:@"btn_return"] forState:UIControlStateNormal];
    
    [goBackBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:goBackBtn];
    
    self.navigationItem.leftBarButtonItem = back;
    
    
    /**
     我的考勤
     */
    _lblMyAttendance = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W * 0.5 - 45, 8, 90, 30)];
    
    _lblMyAttendance.text = @"我的考勤";
    _lblMyAttendance.textAlignment = NSTextAlignmentCenter;
    _lblMyAttendance.font = [UIFont systemFontOfSize:16];
    _lblMyAttendance.textColor = [UIColor whiteColor];
    
    _lblMyAttendance.layer.borderWidth = 1;
    _lblMyAttendance.layer.borderColor = [[UIColor whiteColor]CGColor];
    _lblMyAttendance.layer.cornerRadius = SCREEN_W * 0.04;
    
    _lblMyAttendance.hidden = YES;
    
    [self.navigationController.navigationBar addSubview:_lblMyAttendance];
    
    
    
    
    /**
     日历
     */
    _gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    _customCalendarView = [[CalendarView alloc]initWithFrame:CGRectMake(0, NAVSIZE_H + 30, SCREEN_W, SCREEN_W * 0.9)];
    
    [_customCalendarView setBackgroundColor:[UIColor clearColor]];
    
    _customCalendarView.delegate = self;
    _customCalendarView.datasource = self;
    
    _customCalendarView.calendarDate = [NSDate date]; //获取当前时间日期
    
    _customCalendarView.nextMonthAnimation = UIViewAnimationOptionTransitionFlipFromRight;
    _customCalendarView.prevMonthAnimation = UIViewAnimationOptionTransitionFlipFromLeft;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view addSubview:_customCalendarView];
        _customCalendarView.center = CGPointMake(self.view.center.x, _customCalendarView.center.y);
    });
    
    //获取当前年份
    NSDateComponents * yearComponent = [_gregorian components:NSCalendarUnitYear fromDate:[NSDate date]];
    _currentYear = yearComponent.year;
    
   
    //添加提示的图片
    UIImageView *enterpriseImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, NAVSIZE_H + 40 + SCREEN_W, SCREEN_W-20, SCREEN_W * 0.2)];
    
    enterpriseImg.image = [UIImage imageNamed:@"enterprise_customers_bg"];
    
    [self.view addSubview:enterpriseImg];
}


-(void)viewWillAppear:(BOOL)animated {
    
    /**
     我的考勤和下属考勤
     */
    UIButton *myAttendance = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W * 0.5 - 75, 8, 80, 30)];
    
    [myAttendance  setImage:[UIImage imageNamed:@"myAttendanceNormal"] forState:UIControlStateNormal];
    
    myAttendance.userInteractionEnabled = NO;
    myAttendance.hidden = YES;
    
    [self.navigationController.navigationBar addSubview:myAttendance ];
    
    UIButton *staffAttendance = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W * 0.5 - 6, 8, 80, 30)];
    
    [staffAttendance setImage:[UIImage imageNamed:@"staffAttendanceNormal"] forState:UIControlStateNormal];
    
    [staffAttendance addTarget:self action:@selector(goTo) forControlEvents:UIControlEventTouchUpInside];
    
    staffAttendance.hidden = YES;
    
    [self.navigationController.navigationBar addSubview:staffAttendance];
    
    /**
     从本地获取数据
     */
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *user_number = [userDefaults objectForKey:@"user_number"];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [[AFJSONResponseSerializer alloc]init];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary]; //需要传入的Request数据
    [dict setValue:user_number forKey:@"user_number"];
    
    [manager POST:users_select parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *resultDict = (NSDictionary *)responseObject; //获取传回的数据
        
        NSArray *dataArr = [resultDict valueForKey:@"data"];
        
        NSDictionary *dataDict = [dataArr firstObject];
        
        if (dataDict != nil) {
            
            _lblMyAttendance.hidden = YES;
            myAttendance.hidden = NO;
            staffAttendance.hidden = NO;
            
        }else {
            
            _lblMyAttendance.hidden = NO;
            myAttendance.hidden = YES;
            staffAttendance.hidden = YES;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"错误信息：%@",error);
        
    }];
    
}

/**
 *  返回按钮的点击事件
 */
- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBar.hidden = YES;
}


/**
 *  下属考勤按钮的点击事件
 */
- (void)goTo
{
    /**
     跳转到下属考勤
     */
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"WorkSpace" bundle:nil];
    
    StaffAttendanceViewController *saVC = [storyboard instantiateViewControllerWithIdentifier:@"StaffAttendanceVC"];
    
    saVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:saVC animated:YES];
    self.hidesBottomBarWhenPushed = YES;
}


#pragma mark - CalendarDelegate protocol conformance

- (void)dayChangedToDate:(NSDate *)selectedDate
{
    
}

#pragma mark - CalendarDataSource protocol conformance

- (BOOL)isDataForDate:(NSDate *)date
{
    if([date compare:[NSDate date]] == NSOrderedAscending)
        return YES;
    return NO;
}

- (BOOL)canSwipeToDate:(NSDate *)date
{
    NSDateComponents *yearComponent = [_gregorian components:NSCalendarUnitYear fromDate:date];
    
    //显示当年和下一年日历
    return (yearComponent.year == _currentYear || yearComponent.year == _currentYear +1);
}


@end
