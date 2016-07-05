//
//  NoticeTableViewController.m
//  QuickCard
//
//  Created by administrator on 15/10/9.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "NoticeTableViewController.h"
#import "Notification.h"
#import "AFNetworking.h"
#import "NotificationTableViewCell.h"
#import "CellUtil.h"

@interface NoticeTableViewController ()



@property (nonatomic,strong) NSMutableArray *notificationArr;
@property (nonatomic,assign) float height;

@end

@implementation NoticeTableViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];


    //cell高度的划分
    
    float height = (SCREEN_H - NAVSIZE_H) / 25;
    self.height = height;
    
    // 自定义导航栏的title
    
    float xPoint = (NAVSIZE_W - 20) / 2;
    float yPoint = (NAVSIZE_H - 20) / 2;
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(xPoint, yPoint, 20, 20)];
    titleLab.text = @"通知";
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
    
    //  设置刷新
    
    [self setBeginRefreshing];
     self.tabBarController.tabBar.hidden =YES;
    
    
}

//刷新函数

- (void)setBeginRefreshing {

    self.refresh = [[UIRefreshControl alloc] init];
    self.refresh.tintColor = [UIColor grayColor];
    self.refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    
    //监听事件
    [self.refresh addTarget:self action:@selector(refreshTableViewAction:) forControlEvents:UIControlEventValueChanged];
    
    self.refreshControl = self.refresh;
    
}

- (void)refreshTableViewAction:(UIRefreshControl *)refreshs {

    if (refreshs.refreshing) {
        
        refreshs.attributedTitle = [[NSAttributedString alloc] initWithString:@"正在刷新"];
        [self performSelector:@selector(refreshData) withObject:nil afterDelay:2];
        
    }
    
}


- (void)refreshData {
    
    //提示上次刷新的时间
    
    NSString *time = nil;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; //创建时间格式
    
    time = [formatter stringFromDate:[NSDate date]];
    NSString *lastUpdated = [NSString stringWithFormat:@"上一次的刷新时间为%@",time];
    
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdated];

    self.notificationArr = [NSMutableArray array];
    
    //网络请求数据
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [[AFJSONResponseSerializer alloc] init];
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    
    //从沙盒获取用户信息
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *user_id = [user objectForKey:@"user_id"];
    
    [dict setValue:[NSString stringWithFormat:@"%@",user_id] forKey:@"user_id"];
    
    [mgr POST:notification_show parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        int code = [[dict valueForKey:@"code"] intValue];
        
        if (code == 200) {
            
            NSLog(@"%d",code);
            
            NSArray *dataArr = [dict valueForKey:@"data"];
            
            for (NSDictionary *dict in dataArr) {
                
                Notification *notifications = [Notification NotificationWithDict:dict];
                [self.notificationArr addObject:notifications];
                
            }
            
            [self.refreshControl endRefreshing];
            
            [self.tableView reloadData];
        }
        
        else
        {
            
            NSLog(@"%d",code);
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
    // 数组按not_id 排序，使其在cell显示的时候按时间顺序显示
    
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"not_id" ascending:YES]];
    
    [self.notificationArr sortUsingDescriptors:sortDescriptors];  //  not_id从小到大
    
    //逆序 使其按照not_id从大到小排列
    
    NSMutableArray *resultArr = [NSMutableArray array];
    
    for (int i = (int)self.notificationArr.count - 1; i >= 0; i--) {
        
        [resultArr addObject:self.notificationArr[i]];
    }
    
    self.notificationArr = resultArr;


    
    
}
// 返回

- (void)goBack {
    
     self.tabBarController.tabBar.hidden =NO;
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}



//懒加载

- (NSMutableArray *)notificationArr {
    
  
   
 
    if (_notificationArr == nil) {
        
          _notificationArr = [NSMutableArray array];
        
        AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
        mgr.responseSerializer = [[AFJSONResponseSerializer alloc] init];
        
        
        //从沙盒获取用户信息
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *user_id = [user objectForKey:@"user_id"];
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:[NSString stringWithFormat:@"%@",user_id] forKey:@"user_id"];
        
        [mgr POST:notification_show parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *dict = (NSDictionary *)responseObject;
            int code = [[dict valueForKey:@"code"] intValue];
            
            if (code == 200) {
                
                NSLog(@"%d",code);
                
                NSArray *dataArr = [dict valueForKey:@"data"];
                
                for (NSDictionary *dict in dataArr) {
                    
                    Notification *notifications = [Notification NotificationWithDict:dict];
                    [_notificationArr addObject:notifications];
                    
                }
                
                [self.tableView reloadData];
            }
            
            else
            {
                
                NSLog(@"%d",code);
                
                
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"%@",error);
            
        }];
        
    }
    
    // 数组按not_id 排序，使其在cell显示的时候按时间顺序显示
    
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"not_id" ascending:YES]];
    
    [_notificationArr sortUsingDescriptors:sortDescriptors];  //  not_id从小到大
    
    //逆序 使其按照not_id从大到小排列
    
    NSMutableArray *resultArr = [NSMutableArray array];
    
    for (int i = (int)_notificationArr.count - 1; i >= 0; i--) {
        
        [resultArr addObject:_notificationArr[i]];
    }
    
    _notificationArr = resultArr;
    
 

    return _notificationArr;

    
}

// 返回section

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}
//返回行数

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        
        return 1;
    }
    
    else if (section == 1)
    {
    
        return self.notificationArr.count;
        
    }
    else
    {
    
        return 1;
    }
    
    
 
}

//cell 信息显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *notifiCellID = @"notID";
    NotificationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:notifiCellID];
    
    if (cell == nil) {
        
        cell = [[NotificationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:notifiCellID];
    }
    
    NSArray *subviews = [[NSArray alloc]initWithArray:cell.contentView.subviews];
    
    for (UIView *subview in subviews) {
        
        [subview removeFromSuperview];
        
    }
    
    if (indexPath.section == 0) {
        
        [CellUtil fillcolor:cell high:self.height];
    }
    
   else if (indexPath.section == 1) {
        
        cell.notifications = self.notificationArr[indexPath.row];
       
        [cell notifiShow:self.height *3];
        
    }
    else
    {
    
        [CellUtil fillcolor:cell high:SCREEN_H];
    }
    
    
    return cell;
}

//行高

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        
        return self.height;
        
    }
    
    else if (indexPath.section == 1) {
    
        return self.height * 3;
        
    }
    
    else
    {
    
        return SCREEN_H;
    }

}























@end
