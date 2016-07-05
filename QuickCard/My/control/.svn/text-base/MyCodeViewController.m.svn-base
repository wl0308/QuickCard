//
//  MyCodeViewController.m
//  QuickCard
//
//  Created by administrator on 15/10/10.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "MyCodeViewController.h"
#import "QRCodeGenerator.h"

@interface MyCodeViewController ()

@end

@implementation MyCodeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //自定义导航栏的title
    
    float xPoint = (NAVSIZE_H - 20) / 2;
    float yPoint = (NAVSIZE_W - 20) / 2;
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(xPoint, yPoint, 20, 20)];
    titleLab.text = @"我的二维码";
    titleLab.textColor = [UIColor whiteColor];
    
    self.navigationItem.titleView = titleLab;
    
    //自定义导航栏左侧按钮
    
    [self.navigationItem setHidesBackButton:YES];  //隐藏默认按钮
    
    UIButton *goBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    goBackBtn.frame = CGRectMake(0, 0 , 28, 28);
    [goBackBtn setBackgroundImage:[UIImage imageNamed:@"btn_return"] forState:UIControlStateNormal];
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:goBackBtn];
    
    [goBackBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = back;
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *nameStr = [user valueForKey:@"user_name"];
    NSString *moblieStr = [user valueForKey:@"user_mobile"];
   
    UIImage *imageCode = [QRCodeGenerator qrImageForString:[NSString stringWithFormat:@"%@ ：%@",nameStr,moblieStr] imageSize:self.view.bounds.size.width];
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(20, 150, SCREEN_W - 40, SCREEN_W - 40)];
    [view setImage:imageCode];
    [self.view addSubview:view];
   
}

- (void)goBack {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



@end
