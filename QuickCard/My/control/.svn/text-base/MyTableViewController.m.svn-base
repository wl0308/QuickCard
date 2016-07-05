//
//  MyTableViewController.m
//  QuickCard
//
//  Created by administrator on 15/10/9.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "MyTableViewController.h"
#import "PersonTableViewController.h"
#import "OrderTableViewController.h"
#import "NoticeTableViewController.h"
#import "MemoTableViewController.h"
#import "SettingTableViewController.h"
#import "CellUtil.h"

@interface MyTableViewController ()

@property (nonatomic,assign) float height;

@end

@implementation MyTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    // 自定义导航栏的title
    
    float xPoint = (NAVSIZE_W - 20) / 2;
    float yPoint = (NAVSIZE_H - 20) / 2;
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(xPoint, yPoint, 20, 20)];
    titleLab.text = @"我";
    titleLab.textColor = [UIColor whiteColor];
    
    self.navigationItem.titleView = titleLab;

    // 导航栏添加背景图片
    
    float systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    UIImage *backgroundImage = [UIImage imageNamed:@"nav_bg"];
    
    if (systemVersion >= 5.0) {
        
        [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
        
    }
    else
    {

        [self.navigationController.navigationBar insertSubview:[[UIImageView alloc] initWithImage:backgroundImage] atIndex:1];
    }
  
   
    //便于cell高度的划分
    
    float height = (SCREEN_H - NAVSIZE_H)/25;
    self.height = height;
    
    //设置tableview不可滑动
    
    self.tableView.scrollEnabled = NO;
    
}

// 返回行数

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 9;
    
}


// cell信息展示

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
  
    //cell 重用
    
    NSString *msgCellID = @"msgID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:msgCellID];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:msgCellID];
        
    }
    
   
    
    if (indexPath.row == 0) {
        
        [CellUtil fillcolor:cell high:self.height];  //调用灰色填充的类方法
        
        
    }
    
    else if (indexPath.row == 1) {
    
         [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        
         //从沙盒获取用户信息
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *user_name = [user objectForKey:@"user_name"];
        NSString *user_number = [user objectForKey:@"user_number"];
        
        
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 8, self.height * 4 -16, self.height * 4 -16)];
        
        
        NSString *documentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString *filePath = [[NSString alloc] initWithFormat:@"%@%@",documentsPath,@"/image.png"];
        
        
        self.imgView.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:filePath]];

        [cell.contentView addSubview:self.imgView];
        
        UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(self.height * 4, self.height - 5, self.height * 4, self.height)];
        nameLab.text = user_name;
        [cell.contentView addSubview:nameLab];
        
        UILabel *workerNum = [[UILabel alloc] initWithFrame:CGRectMake(self.height * 4, self.height * 3 - 16, self.height * 4, self.height)];
        workerNum.text = @"员工号 :";
        [cell.contentView addSubview:workerNum];
        
        UILabel *number = [[UILabel alloc]initWithFrame:CGRectMake(self.height * 8, self.height * 3 - 16, self.height *7, self.height)];
        number.text = user_number;
        
        [cell.contentView addSubview:number];
        
    
    }
    
    else if (indexPath.row == 2) {
    
        [CellUtil fillcolor:cell high:self.height];
    }
    
    else if (indexPath.row == 3) {
        
        [self showCell:cell functionName:@"订阅" imgName:@"add_addressicon"];  //调用自定义cell中的控件方法
    
    }
    
    else if (indexPath.row == 4) {
        
        [self showCell:cell functionName:@"通知" imgName:@"voice_password_create_icon"];
        
    }
    
    else if (indexPath.row == 5) {
        
        [self showCell:cell functionName:@"备忘" imgName:@"Transfer_Subject_receiving"];
        
    }
    
    else if (indexPath.row == 6) {
        
        [CellUtil fillcolor:cell high:self.height];
        
    }
    
    else if (indexPath.row ==7) {
    
        [self showCell:cell functionName:@"设置" imgName:@"MoreSetting"];
    }
    
    else
    {
        
        [CellUtil fillcolor:cell high:self.height *10];
        
    }
    
    return cell;
    
}


//自定义cell里面的控件

- (void)showCell:(UITableViewCell *)cell functionName:(NSString *)funStr imgName:(NSString *)imgStr {

    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imgStr]];
    imgView.frame = CGRectMake(6, 8, self.height * 2 - 16, self.height * 2 - 16);
    
    [cell.contentView addSubview:imgView];
    
    UILabel *functionlab = [[UILabel alloc] initWithFrame:CGRectMake(self.height * 2 + 6, 8, 50, self.height * 2 - 16)];
    functionlab.text = funStr;
    
    [cell.contentView addSubview:functionlab];
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
}

//设置cell的行高

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    
    if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row ==6) {
        
        return self.height;
        
    }
    
    else if (indexPath.row == 1) {
    
        return self.height * 4;
        
    }
    
    else if (indexPath.row == 3 || indexPath.row == 4 || indexPath.row ==5 || indexPath.row ==7)
        {
    
        return self.height * 2;
        
    }
    
    else
        
    {
        
        return self.height * 10;
        
    }
    
}

//点击cell以后进行的动作

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 1) {
        
        UIStoryboard *storyboard = self.storyboard;
        PersonTableViewController *personVC  = [storyboard instantiateViewControllerWithIdentifier:@"personID"];
        
        [self.navigationController pushViewController:personVC animated:YES];
        
     }
    
    else if (indexPath.row == 3) {
    
        UIStoryboard *storyboard = self.storyboard;
        OrderTableViewController *orderVC  = [storyboard instantiateViewControllerWithIdentifier:@"orderID"];
        
      [self.navigationController pushViewController:orderVC animated:YES];
        
        
        
    }
    
    else if (indexPath.row == 4) {
        
        UIStoryboard *storyboard = self.storyboard;
       NoticeTableViewController *noticeVC  = [storyboard instantiateViewControllerWithIdentifier:@"noticeID"];
        
        [self.navigationController pushViewController:noticeVC animated:YES];
        
    }
    
    else if (indexPath.row == 5) {
        
        UIStoryboard *storyboard = self.storyboard;
        MemoTableViewController *memoVC  = [storyboard instantiateViewControllerWithIdentifier:@"memoID"];
        
        [self.navigationController pushViewController:memoVC animated:YES];
        
    }
    
    else if (indexPath.row == 7) {
        
        UIStoryboard *storyboard = self.storyboard;
        SettingTableViewController *settingVC  = [storyboard instantiateViewControllerWithIdentifier:@"settingID"];
        
        [self.navigationController pushViewController:settingVC animated:YES];
        
    }

    
}


@end
