//
//  OrderTableViewController.m
//  QuickCard
//
//  Created by administrator on 15/10/9.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "OrderTableViewController.h"
#import "orderInfos.h"
#import "AFNetworking.h"
#import "CellUtil.h"
#import "departmentTableViewController.h"
#import "OrderTableViewCell.h"

@interface OrderTableViewController ()

@property (nonatomic,assign) float height;
@property (nonatomic,assign) int rowCount;
@property (nonatomic,strong) NSMutableArray *ordersArr;

@end

@implementation OrderTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    float height = (SCREEN_H - NAVSIZE_H)/25;
    self.height = height;
    
    // 自定义导航栏的title
    
    float xPoint = (NAVSIZE_W - 20) / 2;
    float yPoint = (NAVSIZE_H - 20) / 2;
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(xPoint, yPoint, 20, 20)];
    titleLab.text = @"订阅";
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
    
     self.tabBarController.tabBar.hidden =YES;

}

// 返回

- (void)goBack {
    
     self.tabBarController.tabBar.hidden =NO;
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

//懒加载数据

- (NSMutableArray *)ordersArr {
    
    if (_ordersArr == nil) {
        
        _ordersArr = [NSMutableArray array];
        
        AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
        mgr.responseSerializer = [[AFJSONResponseSerializer alloc] init];
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        
        //从沙盒获取用户信息
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *user_id = [user objectForKey:@"user_id"];
        
        [dict setValue:[NSString stringWithFormat:@"%@",user_id] forKey:@"user_id"];
        
        [mgr POST:subscribe_show parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *dict = (NSDictionary *)responseObject;
            int code = [[dict valueForKey:@"code"] intValue];
            if (code == 200) {
                
                 NSArray *dataArr = [dict valueForKey:@"data"];
                
                for (NSDictionary *dict in dataArr) {
                    
                    orderInfos *order = [orderInfos OrderInfosWithDict:dict];
                    [_ordersArr addObject:order];
                
                }
                
                [self.tableView reloadData];
                
            }
            
            else
            {
            
                NSLog(@"出现错误");
                
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"错误%@",error);
            
        }];
        
    }
 
 
    return _ordersArr;
    
}



// 获得section数

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 1;
        
    }
    
    else if (section ==1) {
    
        return self.ordersArr.count;
        
    }
    else
    {
    
        return 1;
    }

}

//cell 信息显示

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    //cell重用
   
    NSString *orderCellID = @"ordID";
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:orderCellID];
    
    if (cell == nil) {
        
        cell = [[OrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderCellID];
        
    }
    
    // 移除cell上的控件
    NSArray *subviews = [[NSArray alloc] initWithArray:cell.contentView.subviews];
    
    for (UIView *subview in subviews) {
        
        [subview removeFromSuperview];
        
    }
   
    if (indexPath.section == 0) {
        
        [CellUtil fillcolor:cell high:self.height];
        
    }
    
    else if (indexPath.section == 1) {
        
      cell.orders = [self.ordersArr objectAtIndex:indexPath.row];
        
        [cell infosShow:self.height];
        
        cell.userInteractionEnabled = YES;
    
}
    
    else if (indexPath.section == 2)
    {
    
//        [CellUtil fillcolor:cell high:SCREEN_H];
        
    }
    
    return cell;
}

//设置行高

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    if (indexPath.section == 0) {
        
        return self.height;
        
    }
    
   else  if (indexPath.section == 1){
        
            return self.height * 3;
      
    }
    
    else
    {
    
       return SCREEN_H;
        
    }
    
    
}

//对所选行进行操作

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
  
        
 
    UIStoryboard *storyboard = self.storyboard;
    
    departmentTableViewController *departmentVC = [storyboard instantiateViewControllerWithIdentifier:@"departmentID"];
    
    orderInfos *order = [self.ordersArr objectAtIndex:indexPath.row];
    departmentVC.dep_department = order.deptname;
    
    [self.navigationController pushViewController:departmentVC animated:YES];
    
    

}
@end
