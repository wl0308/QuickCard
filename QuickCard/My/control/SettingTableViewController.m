//
//  SettingTableViewController.m
//  QuickCard
//
//  Created by administrator on 15/10/9.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "SettingTableViewController.h"
#import "CellUtil.h"
#import "ChangePassWordViewController.h"
#import "AboutQKViewController.h"
#import "ClockSettingViewController.h"
#import "LoginVC.h"
@interface SettingTableViewController ()

@property (nonatomic,assign) float height;

@end

@implementation SettingTableViewController

//导航栏设置

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //便于设置cell的高度
    
    float height = (SCREEN_H  - NAVSIZE_H) / 25;
    self.height = height;
    
    //设置tableview不可滑动
    
    self.tableView.scrollEnabled = NO;
    
    //自定义导航栏左侧按钮
    
    [self.navigationItem setHidesBackButton:YES];  //隐藏默认按钮
    
    UIButton *goBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    goBackBtn.frame = CGRectMake(0, 0 , 28, 28);
    [goBackBtn setBackgroundImage:[UIImage imageNamed:@"btn_return"] forState:UIControlStateNormal];
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:goBackBtn];
    
    [goBackBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = back;
    
    self.tableView.separatorStyle = YES;

    // 自定义导航栏的title
    
    float xPoint = (NAVSIZE_W - 20) / 2;
    float yPoint = (NAVSIZE_H - 20) / 2;
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(xPoint, yPoint, 20, 20)];
    titleLab.text = @"设置";
    titleLab.textColor = [UIColor whiteColor];
    
    self.navigationItem.titleView = titleLab;
    
     self.tabBarController.tabBar.hidden =YES;
   
}


//自定义导航栏左侧按钮事件

- (void)goBack {
    
     self.tabBarController.tabBar.hidden =NO;
    [self.navigationController popViewControllerAnimated:YES];
    
}

//返回行数

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 7;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *setCellID = @"setID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:setCellID];
    
    NSArray *subviews = [[NSArray alloc] initWithArray:cell.contentView.subviews];
    
    for (UIView *subview in subviews) {
        
        [subview removeFromSuperview];
        
    }
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:setCellID];

    }
    
    if (indexPath.row == 0) {
        
        [CellUtil fillcolor:cell high:self.height];
        
    }
    
    else if (indexPath.row == 1) {
    
        [self cellShow:cell functionName:@"修改密码"];
        
    }
    
    else if (indexPath.row == 2) {
        
        [self cellShow:cell functionName:@"关于快卡"];
        
    }
    
    else if (indexPath.row == 3) {
        
        [self cellShow:cell functionName:@"打卡设置"];
        
    }
    
    else if (indexPath.row == 4) {
        
        [CellUtil fillcolor:cell high:self.height];
        
    }
    
    else if (indexPath.row == 5) {
        
        UILabel *funNameLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W / 3, 10, SCREEN_W / 3, self.height * 2 - 20)];
        funNameLab.text = @"退出登录";
        
        [cell.contentView addSubview:funNameLab];
        
    }
    
    else
    {
    
      [CellUtil fillcolor:cell high:SCREEN_H - NAVSIZE_H -self.height * 10];
        
    }

    return cell;
    
}

//调用自定义cell

- (void)cellShow:(UITableViewCell *)cell functionName:(NSString *)name {
    
    UILabel *funNameLab = [[UILabel alloc]initWithFrame:CGRectMake(6, 8, SCREEN_W / 3, self.height * 2 - 16)];
    funNameLab.text = name;
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    [cell.contentView addSubview:funNameLab];
    
}

//自定义行高

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0 || indexPath.row == 4) {
        
        return self.height;
    }
    
    else if (indexPath.row == 6) {
    
        return SCREEN_H - NAVSIZE_H -self.height * 10;
        
    }
    
    else
    {
    
        return self.height * 2;
        
    }
    
}

//选中行的操作，页面跳转

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 1) {
        
        UIStoryboard *storyboard = self.storyboard;
        ChangePassWordViewController *changeVC = [storyboard instantiateViewControllerWithIdentifier:@"changeID"];
        
        changeVC.height = self.height;
        
        [self.navigationController pushViewController:changeVC animated:YES];
        
    }
    
   else if (indexPath.row == 2) {
        
        UIStoryboard *storyboard = self.storyboard;
        AboutQKViewController *aboutQKVC = [storyboard instantiateViewControllerWithIdentifier:@"aboutID"];
        
        [self.navigationController pushViewController:aboutQKVC animated:YES];
        
    }
    
    else if (indexPath.row == 3) {
    
        UIStoryboard *storyboard = self.storyboard;
        ClockSettingViewController *clockSettingVC = [storyboard instantiateViewControllerWithIdentifier:@"clockID"];
        
        clockSettingVC.height = self.height;
        
        [self.navigationController pushViewController:clockSettingVC animated:YES];
        
        
    }
    else if (indexPath.row == 5) {
    
       
      
        
        NSString *appDoMain = [[NSBundle mainBundle]bundleIdentifier];
        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDoMain];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:[NSBundle mainBundle]];
        LoginVC *loginVc = [storyboard instantiateViewControllerWithIdentifier:@"loginVC"];
        [self.navigationController pushViewController:loginVc animated:YES];
        
        
        
    }
    
    
}



















@end
