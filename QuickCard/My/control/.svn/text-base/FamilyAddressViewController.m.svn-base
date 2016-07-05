//
//  FamilyAddressViewController.m
//  QuickCard
//
//  Created by administrator on 15/10/10.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "FamilyAddressViewController.h"
#import "PersonTableViewController.h"
#import "AFNetworking.h"

@interface FamilyAddressViewController ()

@property (nonatomic,strong) UITextField *addressText;

@end

@implementation FamilyAddressViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //自定义导航栏的title
    
    float xPoint = (NAVSIZE_H - 20) / 2;
    float yPoint = (NAVSIZE_W - 20) / 2;
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(xPoint, yPoint, 20, 20)];
    titleLab.text = @"家庭住址";
    titleLab.textColor = [UIColor whiteColor];
    
    self.navigationItem.titleView = titleLab;
    
    //自定义输入框
    
    float height = (SCREEN_H - NAVSIZE_H) / 30 ;
    self.addressText = [[UITextField alloc]initWithFrame:CGRectMake(0, height * 2 + NAVSIZE_H, SCREEN_W,height * 2 - 5)];
    
    self.addressText.tintColor = [UIColor colorWithRed:160.0f/255.0f green:160.0f/255.0f blue:160.0f/255.0f alpha:0.5];
    
    self.addressText.backgroundColor = [UIColor whiteColor];
    //从沙盒获取家庭住址
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *user_address = [user valueForKey:@"user_address"];
    self.addressText.text = user_address;
    
    [self.view addSubview:self.addressText];
    
    
    //自定义导航栏左侧按钮
    
    [self.navigationItem setHidesBackButton:YES];  //隐藏默认按钮
    
    UIButton *goBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    goBackBtn.frame = CGRectMake(0, 0 , 28, 28);
    [goBackBtn setBackgroundImage:[UIImage imageNamed:@"btn_return"] forState:UIControlStateNormal];
    
     [goBackBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:goBackBtn];
    
    self.navigationItem.leftBarButtonItem = back;
    
    //自定义导航栏右侧按钮
    
    UIButton *saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 28)];
  
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    saveBtn.titleLabel.textColor = [UIColor whiteColor];
    
    [saveBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    
    self.navigationItem.rightBarButtonItem = save;

    
    
    
}

// 返回

- (void)goBack {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

// 保存

- (void)save {
    
    //数据存入数据库
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    int user_id = (int)[user valueForKey:@"user_id"];
   
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [[AFJSONResponseSerializer alloc] init];
    
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    [dict setObject:[NSString stringWithFormat:@"%@",self.addressText.text] forKey:@"user_address"];
    [dict setObject:[NSString stringWithFormat:@"%d",user_id] forKey:@"user_id"];
    
    [mgr POST:users_updateAddress parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        int code = [[dict valueForKey:@"code"] intValue];
        
        if (code == 200) {
            
            [user setObject:self.addressText.text forKey:@"user_address"];
           
            
            UIStoryboard *storyboard = self.storyboard;
    
            
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

@end
