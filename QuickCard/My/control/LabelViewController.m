//
//  LabelViewController.m
//  QuickCard
//
//  Created by administrator on 15/10/19.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "LabelViewController.h"
#import "AddMemoTableViewController.h"

@interface LabelViewController ()

@property (nonatomic,strong) UITextField *labelText;
@end

@implementation LabelViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //自定义输入框
    
    float height = (SCREEN_H - NAVSIZE_H) / 30;
    
    self.labelText = [[UITextField alloc] initWithFrame:CGRectMake(0, height * 2 + NAVSIZE_H, SCREEN_W,height * 2 - 5)];
    self.labelText.tintColor = [UIColor colorWithRed:160.0f/255.0f green:160.0f/255.0f blue:160.0f/255.0f alpha:0.5];
    self.labelText.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.labelText];
    
    //自定义导航栏的title
    
    float xPoint = (NAVSIZE_H - 20) / 2;
    float yPoint = (NAVSIZE_W - 20) / 2;
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(xPoint, yPoint, 20, 20)];
    titleLab.text = @"标签";
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
    
    //自定义导航栏右侧按钮
    
    UIButton *saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 28)];
    
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    saveBtn.titleLabel.textColor = [UIColor whiteColor];
    
    [saveBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    
    self.navigationItem.rightBarButtonItem = save;
    
 
}

- (void)goBack {

    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)save {

    AddMemoTableViewController *addMemoVC = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 2];
     addMemoVC.detailLab.text = self.labelText.text;
 
    
    [self.navigationController popToViewController:addMemoVC animated:YES];
   
    
}



@end
