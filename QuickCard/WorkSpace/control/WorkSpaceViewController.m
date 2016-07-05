//
//  WorkSpaceViewController.m
//  QuickCard
//
//  Created by Destiny on 15/10/14.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "WorkSpaceViewController.h"
#import "AFNetworking.h"
#import "AttendanceRecordsViewController.h"
#import "FieldViewController.h"
#import "TakeOffViewController.h"
#import "ApprovalVC.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>


#define APIKey @"3ad064b72d79b572906297322905273c"

@interface WorkSpaceViewController ()


@property(nonatomic,strong) UIImageView *userImg; //用户头像
@property(nonatomic,strong) UILabel *userState;  //打卡状态
@property(nonatomic,strong) UIButton *btnClockOn;  //上班打卡
@property(nonatomic,strong) UIButton *btnClockOut; //下班打卡
@property(nonatomic,strong) UIImageView *circleClockOn; //上班打卡动画
@property(nonatomic,strong) UIImageView *circleClockOut; //下班打卡动画

@property(nonatomic,strong) AMapLocationManager *locationManager;

@end

@implementation WorkSpaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [AMapLocationServices sharedServices].apiKey = APIKey;
    
    self.locationManager = [[AMapLocationManager alloc]init];
    
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    
    self.navigationController.navigationBar.hidden = YES;
    
    /**
     导航栏添加背景图片
     */
    float systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    UIImage *bgImg = [UIImage imageNamed:@"nav_bg"];
    if (systemVersion >= 5.0) {
        [self.navigationController.navigationBar setBackgroundImage:bgImg forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        [self.navigationController.navigationBar insertSubview:[[UIImageView alloc]initWithImage:bgImg] atIndex:1];
    }
    
    
    /**
     自定义的背景
     */
    UIImageView *backgroundimg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H * 0.6)];
    
    [backgroundimg setImage:[UIImage imageNamed:@"workspace_bg"]];
    
    [self.view addSubview:backgroundimg];
    
    
    /**
     从本地获取用户信息
     */
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    NSString *user_id = [user objectForKey:@"user_id"];
    
    NSString *user_name = [user objectForKey:@"user_name"];
    
    NSString *user_grade = [user objectForKey:@"user_grade"];
    
    
    /**
     自定义的用户头像
     */
    _userImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_W * 0.42, 30, SCREEN_W * 0.16, SCREEN_W * 0.16)];
    
    NSString *documentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filePath = [[NSString alloc]initWithFormat:@"%@%@",documentsPath,@"/image.png"];
    
    [_userImg setImage:[UIImage  imageWithData:[NSData dataWithContentsOfFile:filePath]]];
    
    if([NSData dataWithContentsOfFile:filePath] == nil)
    {
        [_userImg setImage:[UIImage imageNamed:@"per_head_default.png"]];
    }
    
    _userImg.layer.masksToBounds = YES;
    
    _userImg.layer.cornerRadius = SCREEN_W * 0.08; //将头像设置为圆形
    
    [self.view  addSubview:_userImg];
    
    
    /**
     自定义的用户名
     */
    UILabel *userName = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W *0.42, SCREEN_W * 0.16 + 40, SCREEN_W * 0.16, SCREEN_W * 0.04)];
    
    [userName setTextColor:[UIColor whiteColor]];
    
    userName.font = [UIFont systemFontOfSize:14]; //设置字体大小
    
    userName.textAlignment = NSTextAlignmentCenter; //设置title的字体居中
    
    [userName setText:user_name];
    
    [self.view addSubview:userName];
    
    
    /**
     自定义的职位
     */
    UILabel *userPosition = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W * 0.32 - 5, SCREEN_W * 0.2 + 50, SCREEN_W * 0.18, SCREEN_W * 0.04)];
    
    [userPosition setTextColor:[UIColor whiteColor]];
    
    userPosition.font = [UIFont systemFontOfSize:13]; //设置字体大小
    
    userPosition.textAlignment = NSTextAlignmentRight; //设置title的字体居右
    
    [userPosition setText:user_grade];
    
    [self.view addSubview:userPosition];
    
    
    /**
     分割线
     */
    UIView *partitionView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_W * 0.5, SCREEN_W *0.2 + 50, 1, SCREEN_W * 0.04)];
    
    [partitionView setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:partitionView];
    
    
    /**
     打卡状态
     */
    _userState = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W * 0.5 + 6, SCREEN_W *0.2 + 50, SCREEN_W * 0.16, SCREEN_W * 0.04)];
    
    [_userState setTextColor:[UIColor whiteColor]];
    
    _userState.font = [UIFont systemFontOfSize:13]; //设置字体大小
    
    _userState.textAlignment = NSTextAlignmentLeft; //设置title的字体居左
    
    [_userState setText:@"未打卡"];
    
    [self.view addSubview:_userState];
    
    
    /**
     自定义的上班打卡按钮
     */
    _circleClockOn = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_W * 0.1, SCREEN_H * 0.3, SCREEN_W * 0.3, SCREEN_W * 0.3)];
    
    [_circleClockOn setImage:[UIImage imageNamed:@"circle"]];
    
    _btnClockOn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W * 0.1, SCREEN_H * 0.3, SCREEN_W * 0.3, SCREEN_W * 0.3)];
    
    _btnClockOn.imageEdgeInsets =
    UIEdgeInsetsMake(SCREEN_W * 0.04, SCREEN_W * 0.11, SCREEN_W * 0.11, SCREEN_W * 0.1); //设置image在button上的位置
    
    _btnClockOn.titleLabel.font = [UIFont systemFontOfSize:15]; //设置字体大小
    
    _btnClockOn.titleLabel.textAlignment = NSTextAlignmentCenter; //设置title的字体居中
    
    [_btnClockOn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal]; //设置title在一般情况下为白色字体
    
    _btnClockOn.titleEdgeInsets =
    UIEdgeInsetsMake(SCREEN_W * 0.11, -30, 0, 0); //设置title在button上的位置
    
    [_btnClockOn setImage:[UIImage imageNamed:@"icon_grey.png"] forState:UIControlStateNormal]; //设置image在一般情况下的图片
    
    [_userState setText:@"未打卡"];
    
    [_btnClockOn setTitle:@"上班打卡" forState:UIControlStateNormal]; //设置button的title
    
    //从数据库获取今日是否已打卡
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [[AFJSONResponseSerializer alloc]init];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary]; //需要传入的Request数据
    
    [dict setValue:@"上班打卡" forKey:@"clo_type"];
    
    [dict setValue:[NSString stringWithFormat:@"%@",user_id] forKey:@"user_id"];
    
    [manager POST:clock_select parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *resultDict = (NSDictionary *)responseObject; //获取传回的数据
        
        NSArray *dataArr = [resultDict valueForKey:@"data"];
        
        NSDictionary *dataDict = [dataArr firstObject];
        
        if (dataDict != nil) {
            
            NSString *date = [dataDict valueForKey:@"clo_time"]; //获取打卡的时间
            
            [_btnClockOn setTitle:date forState:UIControlStateNormal]; //将时间显示在button上
            
            [_circleClockOn setImage:[UIImage imageNamed:@"circle_animation_red_79"]];
            
            [_btnClockOn setImage:[UIImage imageNamed:@"icon_red.png"] forState:UIControlStateNormal];
            
            [_userState setText:@"已打卡"];
            
            _btnClockOn.userInteractionEnabled= NO; //设置按钮不可点击
            
        }else {
            
            [_btnClockOn setImage:[UIImage imageNamed:@"icon_grey.png"] forState:UIControlStateNormal]; //设置image在一般情况下的图片
            
            [_userState setText:@"未打卡"];
            
            [_btnClockOn setTitle:@"上班打卡" forState:UIControlStateNormal]; //设置button的title
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"错误信息：%@",error);
        
    }];
    
    [_btnClockOn addTarget:self action:@selector(move) forControlEvents:UIControlEventTouchUpInside]; //创建button的点击事件
    
    [self.view addSubview:_circleClockOn];
    [self.view addSubview:_btnClockOn];
    
    
    /**
     自定义的下班打卡的按钮
     */
    _circleClockOut = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_W * 0.6, SCREEN_H * 0.3, SCREEN_W * 0.3, SCREEN_W * 0.3)];
    
    [_circleClockOut setImage:[UIImage imageNamed:@"circle"]];
    
    _btnClockOut = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W * 0.6, SCREEN_H * 0.3, SCREEN_W * 0.3, SCREEN_W * 0.3)];
    
    _btnClockOut.imageEdgeInsets =
    UIEdgeInsetsMake(SCREEN_W * 0.04, SCREEN_W * 0.11, SCREEN_W * 0.11, SCREEN_W * 0.1); //设置image在button上的位置
    
    _btnClockOut.titleLabel.font = [UIFont systemFontOfSize:15]; //设置字体大小
    
    _btnClockOut.titleLabel.textAlignment = NSTextAlignmentCenter; //设置title的字体居中
    
    [_btnClockOut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal]; //设置title在一般情况下为白色字体
    
    _btnClockOut.titleEdgeInsets =
    UIEdgeInsetsMake(SCREEN_W * 0.11, -30, 0, 0); //设置title在button上的位置
    
    [_btnClockOut setImage:[UIImage imageNamed:@"icon_grey2.png"] forState:UIControlStateNormal]; //设置image在一般情况下的图片
    
    [_btnClockOut setTitle:@"下班打卡" forState:UIControlStateNormal]; //设置button的title
    
    
    //从数据库获取今日是否已打卡
    AFHTTPRequestOperationManager *manager2 = [AFHTTPRequestOperationManager manager];
    
    manager2.responseSerializer = [[AFJSONResponseSerializer alloc]init];
    
    NSMutableDictionary *dict2 = [NSMutableDictionary dictionary]; //需要传入的Request数据
    [dict2 setValue:@"下班打卡" forKey:@"clo_type"];
    [dict2 setValue:[NSString stringWithFormat:@"%@",user_id] forKey:@"user_id"];
    
    [manager POST:clock_select parameters:dict2 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *resultDict2 = (NSDictionary *)responseObject; //获取传回的数据
        
        NSArray *dataArr2 = [resultDict2 valueForKey:@"data"];
        
        NSDictionary *dataDict2 = [dataArr2 firstObject];
        
        if (dataDict2 != nil) {
            
            NSString *date2 = [dataDict2 valueForKey:@"clo_time"]; //获取打卡的时间
            
            [_btnClockOut setTitle:date2 forState:UIControlStateNormal]; //将时间显示在button上
            
            [_circleClockOut setImage:[UIImage imageNamed:@"circle_animation_green_79"]];
            
            
            [_btnClockOut setImage:[UIImage imageNamed:@"icon_green2"] forState:UIControlStateNormal];
            
            _btnClockOut.userInteractionEnabled= NO; //设置按钮不可点击
            
        }else {
            
            [_btnClockOut setImage:[UIImage imageNamed:@"icon_grey2.png"] forState:UIControlStateNormal]; //设置image在一般情况下的图片
            
            [_btnClockOut setTitle:@"下班打卡" forState:UIControlStateNormal]; //设置button的title
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"错误信息：%@",error);
        
    }];
    
    [_btnClockOut addTarget:self action:@selector(move2) forControlEvents:UIControlEventTouchUpInside]; //创建button的点击事件
    
    [self.view addSubview:_circleClockOut];
    [self.view addSubview:_btnClockOut];

    
    /**
     横的分割线
     */
    UIView *horizontalView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_H * 0.72, SCREEN_W, 1)];
    
    UIColor *mycolor = [UIColor colorWithWhite:0.8 alpha:0.50]; //自定义color（浅灰色）
    
    horizontalView.backgroundColor = mycolor;
    
    [self.view addSubview:horizontalView];
    
    
    /**
     垂直的分割线
     */
    UIView *strokeView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_W * 0.5, SCREEN_H * 0.6, 1, SCREEN_H * 0.24)];
    
    strokeView.backgroundColor = mycolor;
    
    [self.view addSubview:strokeView];
    
    
    /**
     自定义的考勤记录按钮
     */
    UIButton *btn_kaoqinjilu = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W * 0.2, SCREEN_H * 0.6, SCREEN_W * 0.16, SCREEN_W * 0.16)];
    
    [btn_kaoqinjilu setImage:[UIImage imageNamed:@"btn_kaoqinjilu"] forState:UIControlStateNormal];
    
    [btn_kaoqinjilu addTarget:self action:@selector(click_kaoqinjilu) forControlEvents:UIControlEventTouchUpInside]; //创建button的点击事件
    
    [self.view addSubview:btn_kaoqinjilu];
    
    
    /**
     自定义的外勤按钮
     */
    UIButton *btn_waiqin = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W * 0.64, SCREEN_H * 0.6, SCREEN_W * 0.16, SCREEN_W * 0.16)];
    
    [btn_waiqin setImage:[UIImage imageNamed:@"btn_waiqin"] forState:UIControlStateNormal];
    
    [btn_waiqin setImage:[UIImage imageNamed:@"btn_waiqin"] forState:UIControlStateHighlighted];
    
    [btn_waiqin addTarget:self action:@selector(click_waiqin) forControlEvents:UIControlEventTouchUpInside]; //创建button的点击事件
    
    [self.view addSubview:btn_waiqin];
    
    
    /**
     自定义的请假按钮
     */
    UIButton *btn_qingjia = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W * 0.2, SCREEN_H * 0.84 - SCREEN_W * 0.16, SCREEN_W * 0.16, SCREEN_W * 0.16)];
    
    [btn_qingjia setImage:[UIImage imageNamed:@"btn_qingjia"] forState:UIControlStateNormal];
    
    [btn_qingjia setImage:[UIImage imageNamed:@"btn_qingjia"] forState:UIControlStateHighlighted];
    
    [btn_qingjia addTarget:self action:@selector(click_qingjia) forControlEvents:UIControlEventTouchUpInside]; //创建button的点击事件
    
    [self.view addSubview:btn_qingjia];
    
    
    /**
     自定义的审批按钮
     */
    UIButton *btn_shenpi = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_W * 0.64, SCREEN_H * 0.84 - SCREEN_W * 0.16, SCREEN_W * 0.16, SCREEN_W * 0.16)];
    
    [btn_shenpi setImage:[UIImage imageNamed:@"btn_shenpi"] forState:UIControlStateNormal];
    
    [btn_shenpi setImage:[UIImage imageNamed:@"btn_shenpi"] forState:UIControlStateHighlighted];
    
    [btn_shenpi addTarget:self action:@selector(click_shenpi) forControlEvents:UIControlEventTouchUpInside]; //创建button的点击事件
    
    [self.view addSubview:btn_shenpi];
    
    
    
}



/**
 *  _btnClockOn相应的事件
 */
- (void)move {
    
    
    /**
     从本地获取用户信息
     */
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    NSString *user_id = [user objectForKey:@"user_id"];
    
    
    
    /**
     按钮的动画
     */
    NSMutableArray *array = [NSMutableArray array];
    
    for(int i = 1 ; i <= 79 ; i++)
    {
        UIImage *img =
        [UIImage imageNamed:
         [NSString stringWithFormat:@"circle_animation_red_%02d",i]];
        
        [array addObject:img];
    }
    
    _circleClockOn.animationImages = array;
    
    _circleClockOn.animationDuration = 4; //设定所有图片在4秒内播放完毕
    
    _circleClockOn.animationRepeatCount = 1; //设置播放一次
    
    [_circleClockOn setImage:[UIImage imageNamed:@"circle_animation_red_79"]];
    
    [_circleClockOn startAnimating]; //开始播放
    
    [_btnClockOn setImage:[UIImage imageNamed:@"icon_red.png"] forState:UIControlStateNormal];
    
    
    /**
     将上班打卡信息传入数据库
     */
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [[AFJSONResponseSerializer alloc]init];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary]; //需要传入的Request数据
    
    [dict setValue:@"上班打卡" forKey:@"clo_type"];
    
    [dict setValue:[NSString stringWithFormat:@"%@",user_id] forKey:@"user_id"];
    
    [manager POST:clock_add parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *resultdict = (NSDictionary *)responseObject; //获取传回的数据
        
        int code = [[resultdict valueForKey:@"code"]intValue];
        
        if (code == 200) {
            
            NSString *date = [resultdict valueForKey:@"data"]; //获取打卡的时间
            
            [_btnClockOn setTitle:date forState:UIControlStateNormal]; //将时间显示在button上
            
            [_userState setText:@"已打卡"];
            
            _btnClockOn.userInteractionEnabled= NO; //设置按钮不可点击
            
        }else {
            NSLog(@"错误！");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"错误信息：%@",error);
        
    }];
    
//    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
//
//        if (error)
//        {
//            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
//
//            if (error.code == AMapLocationErrorLocateFailed)
//            {
//                return;
//            }
//        }
//
//        if(location.coordinate.latitude > 31.278062 && location.coordinate.latitude < 31.283502 && location.coordinate.longitude > 120.745708 && location.coordinate.longitude < 120.754687)
//        {
//            /**
//             按钮的动画
//             */
//            NSMutableArray *array = [NSMutableArray array];
//            
//            for(int i = 1 ; i <= 79 ; i++)
//            {
//                UIImage *img =
//                [UIImage imageNamed:
//                 [NSString stringWithFormat:@"circle_animation_red_%02d",i]];
//                
//                [array addObject:img];
//            }
//            
//            _circleClockOn.animationImages = array;
//            
//            _circleClockOn.animationDuration = 4; //设定所有图片在4秒内播放完毕
//            
//            _circleClockOn.animationRepeatCount = 1; //设置播放一次
//            
//            [_circleClockOn setImage:[UIImage imageNamed:@"circle_animation_red_79"]];
//            
//            [_circleClockOn startAnimating]; //开始播放
//            
//            [_btnClockOn setImage:[UIImage imageNamed:@"icon_red.png"] forState:UIControlStateNormal];
//            
//            
//            /**
//             将上班打卡信息传入数据库
//             */
//            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//            
//            manager.responseSerializer = [[AFJSONResponseSerializer alloc]init];
//            
//            NSMutableDictionary *dict = [NSMutableDictionary dictionary]; //需要传入的Request数据
//            
//            [dict setValue:@"上班打卡" forKey:@"clo_type"];
//            
//            [dict setValue:[NSString stringWithFormat:@"%d",1] forKey:@"user_id"];
//            
//            [manager POST:clock_add parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                
//                NSDictionary *resultdict = (NSDictionary *)responseObject; //获取传回的数据
//                
//                int code = [[resultdict valueForKey:@"code"]intValue];
//                
//                if (code == 200) {
//                    
//                    NSString *date = [resultdict valueForKey:@"data"]; //获取打卡的时间
//                    
//                    [_btnClockOn setTitle:date forState:UIControlStateNormal]; //将时间显示在button上
//                    
//                    [_userState setText:@"已打卡"];
//                    
//                    _btnClockOn.userInteractionEnabled= NO; //设置按钮不可点击
//                    
//                }else {
//                    NSLog(@"错误！");
//                }
//                
//            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                
//                NSLog(@"错误信息：%@",error);
//                
//            }];
//        }else{
//            
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您不在指定的区域内！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alert show];
//        }
//    }];
    
}


/**
 *  _btnClockOut相应的事件
 */
- (void)move2 {
    
    
    
    /**
     从本地获取用户信息
     */
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    NSString *user_id = [user objectForKey:@"user_id"];
    
    
    /**
     按钮的动画
     */
    NSMutableArray *array = [NSMutableArray array];
    
    for(int i = 1 ; i <= 79 ; i++)
    {
        UIImage *img =
        [UIImage imageNamed:
         [NSString stringWithFormat:@"circle_animation_green_%02d",i]];
        
        [array addObject:img];
    }
    
    _circleClockOut.animationImages = array;
    
    _circleClockOut.animationDuration = 4; //设定所有图片在4秒内播放完毕
    
    _circleClockOut.animationRepeatCount = 1; //设置播放一次
    
    [_circleClockOut setImage:[UIImage imageNamed:@"circle_animation_green_79"]];
    
    [_circleClockOut startAnimating]; //开始播放
    
    [_btnClockOut setImage:[UIImage imageNamed:@"icon_green2"] forState:UIControlStateNormal];
    
    /**
     将下班打卡信息传入数据库
     */
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [[AFJSONResponseSerializer alloc]init];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary]; //需要传入的Request数据
    
    [dict setValue:@"下班打卡" forKey:@"clo_type"];
    
    [dict setValue:[NSString stringWithFormat:@"%@",user_id] forKey:@"user_id"];
    
    [manager POST:clock_add parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *resultdict = (NSDictionary *)responseObject; //获取传回的数据
        
        int code = [[resultdict valueForKey:@"code"]intValue];
        
        if (code == 200) {
            
            NSString *date = [resultdict valueForKey:@"data"]; //获取打卡的时间
            
            [_btnClockOut setTitle:date forState:UIControlStateNormal]; //将时间显示在button上
            
            _btnClockOut.userInteractionEnabled = NO; //设置按钮不可点击
            
        }else {
            NSLog(@"错误！");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"错误信息：%@",error);
        
    }];
    
    
    
//    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
//        
//        if (error)
//        {
//            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
//            
//            if (error.code == AMapLocationErrorLocateFailed)
//            {
//                return;
//            }
//        }
//        
//        if(location.coordinate.latitude > 31.278062 && location.coordinate.latitude < 31.283502 && location.coordinate.longitude > 120.745708 && location.coordinate.longitude < 120.754687)
//        {
//            /**
//             按钮的动画
//             */
//            NSMutableArray *array = [NSMutableArray array];
//            
//            for(int i = 1 ; i <= 79 ; i++)
//            {
//                UIImage *img =
//                [UIImage imageNamed:
//                 [NSString stringWithFormat:@"circle_animation_green_%02d",i]];
//                
//                [array addObject:img];
//            }
//            
//            _circleClockOut.animationImages = array;
//            
//            _circleClockOut.animationDuration = 4; //设定所有图片在4秒内播放完毕
//            
//            _circleClockOut.animationRepeatCount = 1; //设置播放一次
//            
//            [_circleClockOut setImage:[UIImage imageNamed:@"circle_animation_green_79"]];
//            
//            [_circleClockOut startAnimating]; //开始播放
//            
//            [_btnClockOut setImage:[UIImage imageNamed:@"icon_green2"] forState:UIControlStateNormal];
//            
//            /**
//             将下班打卡信息传入数据库
//             */
//            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//            
//            manager.responseSerializer = [[AFJSONResponseSerializer alloc]init];
//            
//            NSMutableDictionary *dict = [NSMutableDictionary dictionary]; //需要传入的Request数据
//            
//            [dict setValue:@"下班打卡" forKey:@"clo_type"];
//            
//            [dict setValue:[NSString stringWithFormat:@"%d",1] forKey:@"user_id"];
//            
//            [manager POST:clock_add parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                
//                NSDictionary *resultdict = (NSDictionary *)responseObject; //获取传回的数据
//                
//                int code = [[resultdict valueForKey:@"code"]intValue];
//                
//                if (code == 200) {
//                    
//                    NSString *date = [resultdict valueForKey:@"data"]; //获取打卡的时间
//                    
//                    [_btnClockOut setTitle:date forState:UIControlStateNormal]; //将时间显示在button上
//                    
//                    _btnClockOut.userInteractionEnabled = NO; //设置按钮不可点击
//                    
//                }else {
//                    NSLog(@"错误！");
//                }
//                
//            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                
//                NSLog(@"错误信息：%@",error);
//                
//            }];
//        }else{
//            
//            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您不在指定的区域内！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alert show];
//        }
//    }];
    
    
}

- (void)click_kaoqinjilu {
    
    /**
     跳转到考勤记录
     */
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"WorkSpace" bundle:nil];
    
    AttendanceRecordsViewController *arVC = [storyboard instantiateViewControllerWithIdentifier:@"AttendanceRecordsVC"];
    
    arVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:arVC animated:YES];
    arVC.hidesBottomBarWhenPushed = NO;
    
}

- (void)click_waiqin {
    /**
     跳转到外勤
     */
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"WorkSpace" bundle:nil];
    
    FieldViewController *fwVC = [storyboard instantiateViewControllerWithIdentifier:@"FieldWorkVC"];
    
    fwVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:fwVC animated:YES];
    fwVC.hidesBottomBarWhenPushed = NO;
}

- (void)click_qingjia {
    /**
     跳转到请假
     */
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"WorkSpace" bundle:nil];
    
    TakeOffViewController *toVC = [storyboard instantiateViewControllerWithIdentifier:@"TakeOffVC"];
    
    [self.navigationController pushViewController:toVC animated:YES];
}

- (void)click_shenpi {
    
    ApprovalVC *approvalVC = [[ApprovalVC alloc]initWithNibName:@"ApprovalVC" bundle:nil];
    
    [self.navigationController pushViewController:approvalVC animated:YES];
    
}


-(void)viewWillAppear:(BOOL)animated {
    
    //remove掉上个视图navgationBar上的button控件
    for (UIView *views in self.navigationController.navigationBar.subviews) {
        if ([views isKindOfClass:[UIButton class]]) {
            [views removeFromSuperview];
        }
    }
    
    _userImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_W * 0.42, 30, SCREEN_W * 0.16, SCREEN_W * 0.16)];
    
    NSString *documentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filePath = [[NSString alloc]initWithFormat:@"%@%@",documentsPath,@"/image.png"];
    
    [_userImg setImage:[UIImage  imageWithData:[NSData dataWithContentsOfFile:filePath]]];
    
    if([NSData dataWithContentsOfFile:filePath] == nil)
    {
        [_userImg setImage:[UIImage imageNamed:@"per_head_default.png"]];
    }
}



@end
