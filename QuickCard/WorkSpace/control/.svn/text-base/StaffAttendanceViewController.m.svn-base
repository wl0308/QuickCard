//
//  StaffAttendanceViewController.m
//  QuickCard
//
//  Created by Destiny on 15/10/19.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "StaffAttendanceViewController.h"
#import "DropDownView.h"
#import "AFNetworking.h"
#import "StaffAttendance.h"
#import "StaffAttendanceCell.h"

@interface StaffAttendanceViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain)NSMutableArray *staffArr;

@property (nonatomic, strong) NSString *todayDate;

@property (nonatomic,strong) UIView *fieldWorkView;

@end

@implementation StaffAttendanceViewController

- (NSMutableArray *)staffArr
{
    if(_staffArr == nil)
    {
        
        /**
         从本地获取数据
         */
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        NSString *user_number = [userDefaults objectForKey:@"user_number"];
        
        _staffArr = [NSMutableArray array];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
        manager.responseSerializer = [[AFJSONResponseSerializer alloc]init];
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:user_number forKey:@"user_number"];
        [dict setValue:self.todayDate forKey:@"clo_date"];
        
        [manager POST:clock_show parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dict= (NSDictionary *)responseObject;
            NSArray *dataArr = [dict valueForKey:@"data"];
            for(NSDictionary *dict in dataArr)
            {
                StaffAttendance *staffAttendance = [StaffAttendance StaffAttendanceWithDictionary:dict];
                [_staffArr addObject:staffAttendance];
            }
            [self.tableView reloadData];
        } failure:^(AFHTTPRequestOperation * operation, NSError *error ) {
            NSLog(@"错误%@",error);
        }];
    }
    return _staffArr;
}

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
     下拉列表
     */
    DropDownView *dd = [[DropDownView alloc]initWithFrame:CGRectMake(SCREEN_W * 0.5 - 60, 80, 120, 20)];
    
    //当前日期
    NSString *date;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    date = [formatter stringFromDate:[NSDate date]];
    
    dd.textField.text = date;
    self.todayDate = date;
    self.todayDate = @"2015-10-12";
    
    dd.textField.textAlignment = NSTextAlignmentCenter;
    
    NSMutableArray *arr = [NSMutableArray array];
    
    NSInteger length =(unsigned long)[[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]].length;
    
    for(int i = 1; i <= length;i++)
    {
        NSString *date2;
        NSDateFormatter *formatter2 = [[NSDateFormatter alloc]init];
        [formatter2 setDateFormat:@"yyyy-MM"];
        date2 = [formatter2 stringFromDate:[NSDate date]];
        NSMutableString *str = [NSMutableString string];
        [str appendFormat:@"%@-%02d",date2,i];
        [arr addObject:str];
    }
    dd.tableArray = arr;
    [self.view addSubview:dd];
    
    //监听通知，收到通知调用textChange方法
    [[NSNotificationCenter  defaultCenter] addObserver:self selector:@selector(textChange:) name:@"textField" object:nil];
    
    dd.textField.delegate =self;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
}



- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.staffArr.count;
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"staffAttendaceID";
    StaffAttendanceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    StaffAttendance *staffAttendance = [self.staffArr objectAtIndex:indexPath.row];
   
    
    if(staffAttendance.fie_destination == nil)
    {
        [cell.user_fieldwork setImage:nil forState:UIControlStateNormal];
        
    }
    else{
        
        [cell.user_fieldwork setImage:[UIImage imageNamed:@"legwork"] forState:UIControlStateNormal];
        
        cell.user_fieldwork.titleLabel.text = [NSString stringWithFormat:@"%lu",indexPath.row];
        
        [cell.user_fieldwork addTarget:self action:@selector(waiqin:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    cell.user_name.text = staffAttendance.user_name; //姓名
    
    cell.user_clo_time1.text = staffAttendance.user_time1; //上班时间
    int result1 = [self compareDate:staffAttendance.user_time1 withDate:@"9:00:00"];
    if(result1 != -1)
    {
        cell.user_clo_time1.textColor = [UIColor blueColor];
    }else{
        cell.user_clo_time1.textColor = [UIColor redColor];
    }
    
    cell.user_clo_time2.text = staffAttendance.user_time2; //下班时间
    int result2 = [self compareDate:staffAttendance.user_time2 withDate:@"17:00:00"];
    if(result2 != 1)
    {
        cell.user_clo_time2.textColor = [UIColor blueColor];
    }else{
        cell.user_clo_time2.textColor = [UIColor redColor];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return NO;
}


//2个时间比较前后
- (int)compareDate:(NSString *)date1 withDate:(NSString *)date2
{
    int ci;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm:ss"];
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


/**
 *  移除通知
 */
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)textChange:(NSNotification *)notification
{
    /**
     从本地获取数据
     */
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *user_number = [userDefaults objectForKey:@"user_number"];
    
    _staffArr = [NSMutableArray array];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:user_number forKey:@"user_number"];
    [dict setValue:notification.object forKey:@"clo_date"];
    manager.responseSerializer = [[AFJSONResponseSerializer alloc]init];
    [manager POST:clock_show parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict= (NSDictionary *)responseObject;
        NSArray *dataArr = [dict valueForKey:@"data"];
        for(NSDictionary *dict in dataArr)
        {
            StaffAttendance *staffAttendance = [StaffAttendance StaffAttendanceWithDictionary:dict];
            [_staffArr addObject:staffAttendance];
        }
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation * operation, NSError *error ) {
        NSLog(@"错误%@",error);
    }];
}

-(void)viewWillAppear:(BOOL)animated {
    
    //remove掉上个视图navgationBar上的button控件
    for (UIView *views in self.navigationController.navigationBar.subviews) {
        if ([views isKindOfClass:[UIButton class]]) {
            [views removeFromSuperview];
        }
    }
}

/**
 *  返回按钮的点击事件
 */
- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBar.hidden = NO;
}

/**
 *  外勤对应的点击事件
 */
- (void)waiqin:(UIButton *)btn
{
    _tableView.hidden = YES;
    
    NSString *a = btn.titleLabel.text;
    int row = [a intValue];
    
    StaffAttendance *staffAttendance = [self.staffArr objectAtIndex:row];
    
    
    /**
     外勤信息
     */
    _fieldWorkView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_W * 0.1, SCREEN_H * 0.4, SCREEN_W * 0.8, SCREEN_W * 0.4)];
    //fieldWorkView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_fieldWorkView];
    float width = _fieldWorkView.bounds.size.width;
    float height = _fieldWorkView.bounds.size.height;
    
    UIImageView *bgimg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, height                                                                                                                                                        )];
    [bgimg setImage:[UIImage imageNamed:@"nav_bg"]];
    
     [_fieldWorkView addSubview:bgimg];
    
    //外勤人员
    UILabel *lblName = [[UILabel alloc]initWithFrame:CGRectMake(width * 0.15, height * 0.15, width * 0.4, height * 0.15)];
    
    lblName.text = staffAttendance.user_name;
    lblName.font = [UIFont systemFontOfSize:16];
    lblName.textColor = [UIColor whiteColor];
    
    [_fieldWorkView addSubview:lblName];
    
    //外勤开始时间
    UILabel *lblStart = [[UILabel alloc]initWithFrame:CGRectMake(width * 0.15, height * 0.35, width * 0.6, height * 0.15)];
   
    lblStart.text = staffAttendance.fie_time1;
    lblStart.font = [UIFont systemFontOfSize:16];
    lblStart.textColor = [UIColor whiteColor];
    
    [_fieldWorkView addSubview:lblStart];
    
    
    //外勤结束时间
    UILabel *lblEnd = [[UILabel alloc]initWithFrame:CGRectMake(width * 0.15, height * 0.55, width * 0.6, height * 0.15)];
    
    lblEnd.text = staffAttendance.fie_time2;
    lblEnd.font = [UIFont systemFontOfSize:16];
    lblEnd.textColor = [UIColor whiteColor];
    
    [_fieldWorkView addSubview:lblEnd];
    
    //外勤原由
    UILabel *lblReason = [[UILabel alloc]initWithFrame:CGRectMake(width * 0.15, height * 0.75, width * 0.6, height * 0.15)];
    
    lblReason.text = staffAttendance.fie_destination;
    lblReason.font = [UIFont systemFontOfSize:16];
    lblReason.textColor = [UIColor whiteColor];
    
    [_fieldWorkView addSubview:lblReason];
    
    //返回按钮
    UIButton *btnback = [[UIButton alloc]initWithFrame:CGRectMake(width *0.9, width * 0.025, width * 0.08, width * 0.08)];
    [btnback setImage:[UIImage imageNamed:@"btn_delete"] forState:UIControlStateNormal];
    
    [btnback addTarget:self action:@selector(btndelete) forControlEvents:UIControlEventTouchUpInside];
    
    [_fieldWorkView addSubview:btnback];
    
}

/**
 *  btnback对应的点击事件
 */
- (void)btndelete
{
    _tableView.hidden = NO;
    [_fieldWorkView removeFromSuperview];
}
@end
