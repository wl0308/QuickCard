//
//  TakeOffViewController.m
//  QuickCard
//
//  Created by Destiny on 15/10/20.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "TakeOffViewController.h"
#import "DropDown.h"
#import "AFNetworking.h"
#import "MyTakeOffTableViewController.h"
@interface TakeOffViewController ()

@property (nonatomic,strong) DropDown *dropDown;
@property (nonatomic,strong) DropDown *dropDown1;
@property (nonatomic,strong) UITextField *reasonText;
@property (nonatomic,strong) UITextField *startText;
@property (nonatomic,strong) UITextField *endText;
@property (nonatomic,strong) UITextField *personText;
@property (nonatomic,assign) float height;

@end

@implementation TakeOffViewController



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = NO;
    
    self.height = (SCREEN_H - NAVSIZE_H) / 25;
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"message_detial_bg"]];
    imgView.frame = CGRectMake(15, NAVSIZE_H + self.height * 2, SCREEN_W - 30, self.height * 16);
    [self.view addSubview:imgView];
    
    
    //自定义导航栏的title
    
    float xPoint = (NAVSIZE_H - 20) / 2;
    float yPoint = (NAVSIZE_W - 20) / 2;
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(xPoint, yPoint, 20, 20)];
    titleLab.text = @"请假";
    titleLab.textColor = [UIColor whiteColor];
    
    self.navigationItem.titleView = titleLab;
    
    //自定义导航栏左侧按钮
    
    [self.navigationItem setHidesBackButton:YES];  //隐藏默认按钮
    
    UIButton *goBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    goBackBtn.frame = CGRectMake(0, 0 , 28, 28);
    [goBackBtn setBackgroundImage:[UIImage imageNamed:@"btn_return"] forState:UIControlStateNormal];
    
    [goBackBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:goBackBtn];
    
    self.navigationItem.leftBarButtonItem = back;
    
    UIButton *myTakeOffBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [myTakeOffBtn setTitle:@"我的请假" forState:UIControlStateNormal];
    myTakeOffBtn.titleLabel.textColor=[UIColor whiteColor];
    myTakeOffBtn.titleLabel.font=[UIFont systemFontOfSize:14.0f];
    myTakeOffBtn.frame=CGRectMake(SCREEN_W-60, 0, 60, 28);
    [myTakeOffBtn addTarget:self action:@selector(myTakeOffBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *myTakeOff=[[UIBarButtonItem alloc]initWithCustomView:myTakeOffBtn];
    self.navigationItem.rightBarButtonItem=myTakeOff;
    
    //隐藏tabbar
    
     self.tabBarController.tabBar.hidden = YES;
    
    self.navigationController.navigationBarHidden = NO;

    
    UILabel *typeLab = [[UILabel alloc] initWithFrame:CGRectMake(45,NAVSIZE_H + self.height * 4, SCREEN_W  / 2 - 50, self.height * 2)];
    typeLab.text = @"请假类型    : ";
   
    UILabel *takeOffDaysLab = [[UILabel alloc] initWithFrame:CGRectMake(45,NAVSIZE_H + self.height * 6, SCREEN_W  / 2 - 50, self.height * 2)];
    takeOffDaysLab.text = @"请假天数    : ";
   
    UILabel *reasonLab = [[UILabel alloc] initWithFrame:CGRectMake(45,NAVSIZE_H + self.height * 8, SCREEN_W - 50, self.height * 2)];
    reasonLab.text = @"请假原由    : ";
    
    UILabel *startLab = [[UILabel alloc] initWithFrame:CGRectMake(45,NAVSIZE_H + self.height * 10, SCREEN_W - 50, self.height * 2)];
    startLab.text = @"起始时间    : ";
    
    UILabel *endLab = [[UILabel alloc] initWithFrame:CGRectMake(45,NAVSIZE_H + self.height * 12, SCREEN_W - 50, self.height * 2)];
    endLab.text = @"结束时间    : ";
    
    UILabel *personLab = [[UILabel alloc] initWithFrame:CGRectMake(45,NAVSIZE_H + self.height * 14, SCREEN_W - 50, self.height * 2)];
    personLab.text = @"审批人     : ";
    
    self.dropDown = [[DropDown alloc] initWithFrame:CGRectMake(SCREEN_W / 2 - 5 , NAVSIZE_H + self.height * 4 + self.height / 4 + 2, SCREEN_W / 2 - 30, self.height + self.height / 2)];
    self.dropDown.textField.placeholder = @"请选择类型";
    NSArray *arr = [[NSArray alloc] initWithObjects:@"产假",@"年假",@"病假",@"婚假", @"其他",nil];
    self.dropDown.tableArray = arr;
//    [self.view addSubview:self.dropDown];

    self.dropDown1 = [[DropDown alloc] initWithFrame:CGRectMake(SCREEN_W / 2 - 5 , NAVSIZE_H + self.height * 6 + self.height / 4 + 2, SCREEN_W / 2 - 30, self.height + self.height / 2)];
    self.dropDown1.textField.placeholder = @"请选择请假日期";
    NSArray *arr1 = [[NSArray alloc] initWithObjects:@"一天",@"两天",@"三天",@"四天",@"四天以上",nil];
    self.dropDown1.tableArray = arr1;
    
    [self.view addSubview:self.dropDown1];
    
    
    self.reasonText = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_W / 2 - 5, NAVSIZE_H + self.height * 8 + self.height / 4 + 2, SCREEN_W / 2 - 30, self.height + self.height / 2)];
    self.reasonText.placeholder = @"请输入请假理由";
   
    self.reasonText.font = [UIFont systemFontOfSize:15];
    self.reasonText.backgroundColor = [UIColor whiteColor];
    self.reasonText.borderStyle = UITextBorderStyleRoundedRect;
    
    self.startText = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_W / 2 - 5, NAVSIZE_H + self.height * 10 + self.height / 4 + 2, SCREEN_W / 2 - 30, self.height + self.height / 2)];
    self.startText.placeholder = @"请输入年月日";
    self.startText.font = [UIFont systemFontOfSize:15];
    self.startText.backgroundColor = [UIColor whiteColor];
    self.startText.borderStyle = UITextBorderStyleRoundedRect;
    
    self.endText = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_W / 2 - 5, NAVSIZE_H + self.height * 12 + self.height / 4 + 2, SCREEN_W / 2 - 30, self.height + self.height / 2)];
    self.endText.placeholder = @"请输入年月日";
    self.endText.font = [UIFont systemFontOfSize:15];
    self.endText.backgroundColor = [UIColor whiteColor];
    self.endText.borderStyle = UITextBorderStyleRoundedRect;
    
    self.personText = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_W / 2 - 5, NAVSIZE_H + self.height * 14 + self.height / 4 + 2, SCREEN_W / 2 - 30, self.height + self.height / 2)];
    self.personText.placeholder = @"分配审批人";
    self.personText.font = [UIFont systemFontOfSize:15];
    self.personText.backgroundColor = [UIColor whiteColor];
    self.personText.borderStyle = UITextBorderStyleRoundedRect;
//    self.personText.userInteractionEnabled=NO;
     [self.personText addTarget:self action:@selector(person) forControlEvents:UIControlEventAllTouchEvents];
    
    
    [self.view addSubview:typeLab];
    [self.view addSubview:takeOffDaysLab];
    [self.view addSubview:reasonLab];
    [self.view addSubview:startLab];
    [self.view addSubview:endLab];
    [self.view addSubview:personLab];
    [self.view addSubview:self.dropDown];
    [self.view addSubview:self.reasonText];
    [self.view addSubview:self.startText];
    [self.view addSubview:self.endText];
    [self.view addSubview:self.personText];
    
   
    
    
    UIButton *submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_W / 3, NAVSIZE_H + self.height * 19, SCREEN_W / 3, self.height * 2 - 6)];
   
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn.layer setCornerRadius:10.0];
    submitBtn.backgroundColor = [UIColor colorWithRed:105.0f/255.0f green:105.0f/255.0f blue:105.0f/255.0f alpha:0.3];
    
    [submitBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:submitBtn];
    
}

//提交按钮事件
-(void)person{
    if ([self.dropDown1.textField.text isEqualToString:@"一天"]) {
        self.personText.text=@"王亮";
    }else if([self.dropDown1.textField.text isEqualToString:@"两天"]){
        self.personText.text=@"John";
    }else if([self.dropDown1.textField.text isEqualToString:@"三天"]){
        self.personText.text=@"Tom";
    }else if([self.dropDown1.textField.text isEqualToString:@"四天"]){
        self.personText.text=@"Alex";
    }else if([self.dropDown1.textField.text isEqualToString:@"四天以上"]){
        self.personText.text=@"Robin";
    }
}
- (void)submit {
    
    
    if (![self.dropDown.textField  isEqual: @" "] && ![self.reasonText.text  isEqual: @""] && ![self.startText.text  isEqual: @""] && ![self.endText.text  isEqual: @""]) {
        
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *user_id = [user valueForKey:@"user_id"];
        
        NSString *startYearTime = [self.startText.text substringToIndex:4];
        NSString *startMonthTime = [self.startText.text substringWithRange:NSMakeRange(4, 2)];
        NSString *startDayTime = [self.startText.text substringFromIndex:6];
        NSString *startTime = [NSString stringWithFormat:@"%@-%@-%@",startYearTime,startMonthTime,startDayTime];
        
        NSString *endYearTime = [self.endText.text substringToIndex:4];
        NSString *endMonthTime = [self.endText.text substringWithRange:NSMakeRange(4, 2)];
        NSString *endDayTime = [self.endText.text substringFromIndex:6];
        NSString *endTime = [NSString stringWithFormat:@"%@-%@-%@",endYearTime,endMonthTime,endDayTime];
        
      
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:self.reasonText.text forKey:@"abs_reason"];
        [dict setObject:startTime forKey:@"abs_starttime"];
        [dict setObject:endTime forKey:@"abs_endtime"];
        [dict setObject:self.dropDown.textField.text forKey:@"abs_type"];
        [dict setObject:[NSString stringWithFormat:@"%@",user_id] forKey:@"user_id"];
        
        AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
        mgr.responseSerializer = [[AFJSONResponseSerializer alloc] init];
        
        [mgr POST:absence_add parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *dict = (NSDictionary *)responseObject;
            int code = [[dict valueForKey:@"code"] intValue];
            
            if (code == 200) {
                
                NSLog(@"%d",code);
                
                self.navigationController.navigationBar.hidden =YES;
                self.tabBarController.tabBar.hidden = NO;
                [self.navigationController popViewControllerAnimated:YES];
              
                
            }
            
            else
            {
            
                NSLog(@"%d",code);
            }
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"%@",error);
            
            
        }];

    
}
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBar.hidden =YES;
    [self.navigationController popViewControllerAnimated:YES];
}
// 返回

- (void)goBack {
    
    //显示tabbar
    
     self.tabBarController.tabBar.hidden = NO;
     self.navigationController.navigationBar.hidden =YES;
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)myTakeOffBtn{
    MyTakeOffTableViewController *myTakeOffView=[[MyTakeOffTableViewController alloc]init];
    [self.navigationController pushViewController:myTakeOffView animated:YES];
}


@end
