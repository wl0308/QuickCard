//
//  ChangePassWordViewController.m
//  QuickCard
//
//  Created by administrator on 15/10/12.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "ChangePassWordViewController.h"
#import "CellUtil.h"
#import "AFNetworking.h"

@interface ChangePassWordViewController ()

@property (nonatomic,weak) UITextField *oldText;
@property (nonatomic,weak) UITextField *changeText;
@property (nonatomic,weak) UITextField *changeTextAgain;
@property (nonatomic,weak) UIButton *sureBtn;

@end

@implementation ChangePassWordViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //自定义导航栏左侧按钮
    
    [self.navigationItem setHidesBackButton:YES];  //隐藏默认按钮
    
    UIButton *goBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    goBackBtn.frame = CGRectMake(0, 0 , 28, 28);
    [goBackBtn setBackgroundImage:[UIImage imageNamed:@"btn_return"] forState:UIControlStateNormal];
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:goBackBtn];
    
    [goBackBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = back;
    
    //自定义导航栏的title
    
    float xPoint = (NAVSIZE_H - 20) / 2;
    float yPoint = (NAVSIZE_W - 20) / 2;
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(xPoint, yPoint, 20, 20)];
    titleLab.text = @"修改密码";
    titleLab.textColor = [UIColor whiteColor];
    
    self.navigationItem.titleView = titleLab;
    
    //定义密码输入框
    
    UITextField *oldText = [[UITextField alloc] initWithFrame:CGRectMake(5, NAVSIZE_H + self.height * 2, SCREEN_W - 10, self.height * 2)];
    
    [oldText.layer setCornerRadius:8.0];
    oldText.placeholder = @"请输入旧密码";
    oldText.backgroundColor = [UIColor colorWithRed:211.0f/255.0f green:211.0f/255.0f blue:211.0f/255.0f alpha:0.5];
    
    UITextField *newText = [[UITextField alloc] initWithFrame:CGRectMake(5, NAVSIZE_H + self.height * 5, SCREEN_W - 10, self.height * 2)];
    
    [newText.layer setCornerRadius:8.0];
    newText.placeholder = @"请输入新密码";
    newText.backgroundColor = [UIColor colorWithRed:211.0f/255.0f green:211.0f/255.0f blue:211.0f/255.0f alpha:0.5];
    
    UITextField *newText2 = [[UITextField alloc] initWithFrame:CGRectMake(5, NAVSIZE_H + self.height * 8, SCREEN_W - 10, self.height * 2)];
    
    [newText2.layer setCornerRadius:8.0];
    newText2.placeholder = @"确认密码";
    newText2.backgroundColor = [UIColor colorWithRed:211.0f/255.0f green:211.0f/255.0f blue:211.0f/255.0f alpha:0.5];
    
    UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_W / 3, NAVSIZE_H + self.height * 11 - 10, SCREEN_W / 3, self.height * 2 - 6)];
    
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn.layer setCornerRadius:10.0];
    sureBtn.backgroundColor = [UIColor colorWithRed:105.0f/255.0f green:105.0f/255.0f blue:105.0f/255.0f alpha:0.5];
    
    [sureBtn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    
    self.oldText = oldText;
    self.changeText = newText;
    self.changeTextAgain = newText2;
    self.sureBtn = sureBtn;
    
    [self.view addSubview:oldText];
    [self.view addSubview:newText];
    [self.view addSubview:newText2];
    [self.view addSubview:sureBtn];
    
   
}

//自定义确定按钮 事件

- (void)sure {

    //沙盒获取用户手机号码和密码
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *user_mobile = [user objectForKey:@"user_monile"];
    NSString *user_password = [user objectForKey:@"user_password"];
    
    if (![self.changeText.text isEqualToString:@" "] && ![self.changeTextAgain.text  isEqualToString:@" "] ){
        
        if ([self.changeText.text isEqualToString: self.changeTextAgain.text] && [self.oldText.text isEqualToString:user_password]) {
            
      //将新密码写入数据库
            
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [[AFJSONResponseSerializer alloc] init];
 
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSString stringWithFormat:@"%@",user_mobile] forKey:@"user_mobile"];
    [dict setObject:[NSString stringWithFormat:@"%@",self.changeText.text] forKey:@"user_password"];
    
    [mgr POST:users_update parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = (NSDictionary *)responseObject;
        int code = [[dict objectForKey:@"code"] intValue];
        
        if (code == 200) {
            
            //保存新密码到沙盒
            
            [user setObject:self.changeText.text forKey:@"user_password"];
        
            [self.navigationController popViewControllerAnimated:YES];
            NSLog(@"%d",code);
            
        }
        else
        {
        
            NSLog(@"%d",code);
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"错误信息");
        
    }];
    
    
            [self.navigationController popViewControllerAnimated:YES];
            
    }
    
}
    else
    {
        self.sureBtn.enabled = NO;
    }
}

//自定义导航栏按钮事件

- (void)goBack {

    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
