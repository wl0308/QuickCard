//
//  AboutQKViewController.m
//  QuickCard
//
//  Created by administrator on 15/10/12.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "AboutQKViewController.h"

@interface AboutQKViewController ()

@end

@implementation AboutQKViewController

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
    
    
    // 自定义导航栏的title
    
    float xPoint = (NAVSIZE_W - 20) / 2;
    float yPoint = (NAVSIZE_H - 20) / 2;
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(xPoint, yPoint, 20, 20)];
    titleLab.text = @"关于快卡";
    titleLab.textColor = [UIColor whiteColor];
    
    self.navigationItem.titleView = titleLab;
    //    float height = (SCREEN_H - NAVSIZE_H) / 25;
    //自定义界面
    //    UILabel *typeLab = [[UILabel alloc] initWithFrame:CGRectMake(45,NAVSIZE_H + height * 4, SCREEN_W  / 2 - 50, height * 2)];
    //    typeLab.text = @"快卡版本    : 正式版1.02a";
    UIImageView *view=[[UIImageView alloc]initWithFrame:CGRectMake(0, NAVSIZE_H, SCREEN_W, SCREEN_H)];
    view.image=[UIImage imageNamed:@"bg_gyqk"];
    
    UILabel *nameLab=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W/32*11, SCREEN_H/3, SCREEN_W/16*5, SCREEN_H/12)];
    nameLab.text=@"Quick Card";
    nameLab.textColor=[UIColor colorWithRed:65.0f/255.0f green:115.0f/255.0f blue:180.0f/255.0f alpha:1.0f];
    nameLab.font=[UIFont systemFontOfSize:20.0f];
    
    UILabel *typeLab=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W/64*27, SCREEN_H/24*11, SCREEN_W/32*5, SCREEN_H/12)];
    typeLab.text=@"V1.02";
    typeLab.textColor=[UIColor colorWithRed:150.0f/255.0f green:150.0f/255.0f blue:150.0f/255.0f alpha:1.0f];
    typeLab.font=[UIFont systemFontOfSize:18.0f];
    
    UILabel *qqLab=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W/64*19, SCREEN_H/3*2, SCREEN_W/32*15, SCREEN_H/12)];
    qqLab.text=@"官方QQ群:458601904";
    qqLab.textColor=[UIColor colorWithRed:100.0f/255.0f green:100.0f/255.0f blue:100.0f/255.0f alpha:1.0f];
    qqLab.font=[UIFont systemFontOfSize:14.0f];
    
    UILabel *mailLab=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W/32*5, SCREEN_H/24*17, SCREEN_W/16*11, SCREEN_H/12)];
    mailLab.text=@"官方邮箱:masterwang@163.com";
    mailLab.textAlignment=UITextAlignmentCenter;
    mailLab.textColor=[UIColor colorWithRed:100.0f/255.0f green:100.0f/255.0f blue:100.0f/255.0f alpha:1.0f];
    mailLab.font=[UIFont systemFontOfSize:14.0f];
    
    UILabel *peosoner=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W/64*17, SCREEN_H/12*9, SCREEN_W/32*15, SCREEN_H/12)];
    peosoner.text=@"版权所有:快卡项目小组";
    peosoner.textAlignment=UITextAlignmentCenter;
    peosoner.textColor=[UIColor colorWithRed:100.0f/255.0f green:100.0f/255.0f blue:100.0f/255.0f alpha:1.0f];
    peosoner.font=[UIFont systemFontOfSize:14.0f];
    
    UILabel *copyrightLab=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W/32*7, SCREEN_H/48*39, SCREEN_W/16*9, SCREEN_H/12)];
    copyrightLab.text=@"Copyright 2015 WWWL.COM All Rights Reserved";
    copyrightLab.numberOfLines=2;
    copyrightLab.textAlignment=UITextAlignmentCenter;
    copyrightLab.textColor=[UIColor colorWithRed:181.0f/255.0f green:181.0f/255.0f blue:181.0f/255.0f alpha:1.0f];
    copyrightLab.font=[UIFont systemFontOfSize:13.0f];
    
    [view addSubview:copyrightLab];
    [view addSubview:peosoner];
    [view addSubview:mailLab];
    [view addSubview:qqLab];
    [view addSubview:typeLab];
    [view addSubview:nameLab];
    [self.view addSubview:view];
}

- (void)goBack {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
