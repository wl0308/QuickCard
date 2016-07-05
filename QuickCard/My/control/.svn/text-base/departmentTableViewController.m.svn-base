//
//  departmentTableViewController.m
//  QuickCard
//
//  Created by administrator on 15/10/10.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "departmentTableViewController.h"
#import "orderDepartmentNotices.h"
#import "OrderDepDetaiinfosTableViewCell.h"
#import "AFNetworking.h"


@interface departmentTableViewController ()

@property (nonatomic,strong) NSMutableArray *orderDepArr;

@end

@implementation departmentTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //设置预估计的cell的高度
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = NO;

    
    // 自定义导航栏的title
    
    float xPoint = (NAVSIZE_W - 20) / 2;
    float yPoint = (NAVSIZE_H - 20) / 2;
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(xPoint, yPoint, 20, 20)];
    titleLab.text = self.dep_department;
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
    
    //设置刷新
    
    [self setBeginRefreshing];
    
    
    
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

    //提示上一次刷新时间
    NSString *time = nil;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; //创建时间格式
    
    time = [formatter stringFromDate:[NSDate date]];
    NSString *lastUpdated = [NSString stringWithFormat:@"上一次刷新的时间为%@",time];
    
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdated];
    
    //网络请求数据
    
    self.orderDepArr = [NSMutableArray array];
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [[AFJSONResponseSerializer alloc] init];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:self.dep_department forKey:@"dep_department"];
    
    [mgr POST:subdetail_show parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        int code = [[dict valueForKey:@"code"] intValue];
        
        if (code == 200) {
            
            NSArray *dataArr = [dict valueForKey:@"data"];
            
            for (NSDictionary *dict in dataArr) {
                
                orderDepartmentNotices *orderDep = [orderDepartmentNotices OrderDepartmentNoticesWithDict:dict];
                [self.orderDepArr addObject:orderDep];
                
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

    [self.orderDepArr sortUsingDescriptors:sortDescriptors];  //  not_id从小到大

}

//按钮事件
- (void)goBack {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

//懒加载数据

- (NSMutableArray *)orderDepArr {
    
    if (_orderDepArr == nil) {
        
        _orderDepArr = [NSMutableArray array];
        
        AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
        mgr.responseSerializer = [[AFJSONResponseSerializer alloc] init];
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:self.dep_department forKey:@"dep_department"];
        
    
        NSLog(@"%@",self.dep_department);
        [mgr POST:subdetail_show parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *dict = (NSDictionary *)responseObject;
            int code = [[dict valueForKey:@"code"] intValue];
            
            if (code == 200) {
                
                NSArray *dataArr = [dict valueForKey:@"data"];
                
                for (NSDictionary *dict in dataArr) {
                    
                    orderDepartmentNotices *orderDep = [orderDepartmentNotices OrderDepartmentNoticesWithDict:dict];
                    [_orderDepArr addObject:orderDep];
                    
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
    
    [_orderDepArr sortUsingDescriptors:sortDescriptors];  //  not_id从小到大
    
    return _orderDepArr;
  
    
}

//返回行数

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.orderDepArr.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

//cell信息显示

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   
    NSString *orderDepCellID = @"depID";
    OrderDepDetaiinfosTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:orderDepCellID];
    
    if (cell == nil) {
        
        cell = [[OrderDepDetaiinfosTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderDepCellID];
        
    }
    
    cell.orderDep = [self.orderDepArr objectAtIndex:indexPath.section];
    [cell detailInfosShow];
    
 
    return cell;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(0, 0, SCREEN_W, 44);
    view.backgroundColor = [UIColor colorWithRed:239.0f/255.0f green:239.0f/255.0f blue:239.0f/255.0f alpha:0.5];
    
    
    UILabel *timeLab = [[UILabel alloc] init];
    
    if (section == 0) {
    
    timeLab.frame = CGRectMake((SCREEN_W - 95) / 2, 12, 95, 30);
        
    }
    else
    {
    
      timeLab.frame = CGRectMake((SCREEN_W - 95) / 2, 3, 95, 30);
        
    }
    timeLab.backgroundColor =[UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:0.5];
    timeLab.textAlignment = NSTextAlignmentCenter;
    
    timeLab.layer.cornerRadius = 10.0;
    timeLab.layer.masksToBounds = YES;
    
    timeLab.textColor = [UIColor whiteColor];
    
    
    orderDepartmentNotices *order = [self.orderDepArr objectAtIndex:section];
    NSString *timeStr = [order.not_time substringToIndex:5];
    
   
    timeLab.text = timeStr;
    
    [view addSubview:timeLab];
     return view;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if (section == 0) {
        return 54;
        
    }
    
    else
        
        return 44;
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

  
//    [cell setTranslatesAutoresizingMaskIntoConstraints:NO];
//    
   UIImageView *view = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cell_bg4"]];
    
    [cell setBackgroundView:view];
    [cell setBackgroundColor:[UIColor clearColor]];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
