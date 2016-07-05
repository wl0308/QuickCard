//
//  MemoTableViewController.m
//  QuickCard
//
//  Created by administrator on 15/10/9.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "MemoTableViewController.h"
#import "memoContents.h"
#import "AFNetworking.h"
#import "CellUtil.h"
#import "memoTableViewCell.h"
#import "AddMemoTableViewController.h"

@interface MemoTableViewController ()


@property (nonatomic,strong) NSMutableArray *memosArr;
@property (nonatomic,assign) float height;

@end
@implementation MemoTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //方便设置 cell 的行高
    float height =  (SCREEN_H - NAVSIZE_H) / 25;
    self.height = height;
    
    //自定义导航栏的title
    
    float xPoint = (NAVSIZE_H - 20) / 2;
    float yPoint = (NAVSIZE_W - 20) / 2;
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(xPoint, yPoint, 20, 20)];
    titleLab.text = @"个人信息";
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
    
    
    //自定义导航栏右侧按钮
    
    UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 28)];
    
    [addBtn setTitle:@"添加" forState:UIControlStateNormal];
    addBtn.titleLabel.textColor = [UIColor whiteColor];
    
    [addBtn addTarget:self action:@selector(addMemo) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
    
    self.navigationItem.rightBarButtonItem = add;

     self.tabBarController.tabBar.hidden =YES;
    
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
    
    self.memosArr = [NSMutableArray array];
    
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [[AFJSONResponseSerializer alloc] init];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *user_id = [user valueForKey:@"user_id"];
    [dict setValue:[NSString stringWithFormat:@"%@",user_id] forKey:@"user_id"];
    
    [mgr POST:memorandum_show parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        
        int code = [[dict valueForKey:@"code"] intValue];
        
        if (code == 200) {
            
            NSArray *dataArr = [dict valueForKey:@"data"];
            
            for (NSDictionary *dict in dataArr) {
                
                memoContents *memocontents = [memoContents MemoContentsWithDict:dict];
                [self.memosArr addObject:memocontents];
                NSLog(@"+++++++++++%d",memocontents.mem_id);
                
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



}
- (void)addMemo {
    
    UIStoryboard *storyboard = self.storyboard;
    AddMemoTableViewController *addMemoVC = [storyboard instantiateViewControllerWithIdentifier:@"addID"];
    
    addMemoVC.height = self.height;
    
    [self.navigationController pushViewController:addMemoVC animated:YES];
    
}

- (void)goBack {
    
     self.tabBarController.tabBar.hidden =NO;
    [self.navigationController popViewControllerAnimated:YES];
    
}

//懒加载

- (NSMutableArray *)memosArr {
    
    
    if (_memosArr == nil) {
        
        _memosArr = [NSMutableArray array];

        AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
        mgr.responseSerializer = [[AFJSONResponseSerializer alloc] init];
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *user_id = [user valueForKey:@"user_id"];
        [dict setValue:[NSString stringWithFormat:@"%@",user_id] forKey:@"user_id"];
        
        [mgr POST:memorandum_show parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *dict = (NSDictionary *)responseObject;
            
            int code = [[dict valueForKey:@"code"] intValue];
            
            if (code == 200) {
                
                NSArray *dataArr = [dict valueForKey:@"data"];
                
                for (NSDictionary *dict in dataArr) {
                    
                    memoContents *memocontents = [memoContents MemoContentsWithDict:dict];
                    [_memosArr addObject:memocontents];
                    
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
    
    return _memosArr;
    
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
    
    else if (section == 1) {
    
        return self.memosArr.count;
        
    }
    
    else
    {
    
        return 1;
    }
}

// cell 信息显示

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *memoCellID = @"memoID";
    memoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:memoCellID];
    
    
    if (cell == nil) {
        
        cell = [[memoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:memoCellID];
        
    }
    
    NSArray *subviews = [[NSArray alloc] initWithArray:cell.contentView.subviews];
    
    for (UIView *subview in subviews) {
        
        [subview removeFromSuperview];
        
    }
    
    if (indexPath.section == 0) {
        
        [CellUtil fillcolor:cell high:self.height];
        
    }
    
    else if (indexPath.section == 1 ) {
        
        
        cell.memocontents = [self.memosArr objectAtIndex:indexPath.row];
        
        [cell memoShow:self.height * 3];
        
    
        //初始化本地通知对象
        
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        if (notification != nil) {
            
            NSString *timeStr = cell.memocontents.mem_datetime;
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
               [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *date = [formatter dateFromString:timeStr];
            
            notification.fireDate = date;
            notification.timeZone = [NSTimeZone defaultTimeZone];
            notification.alertBody = cell.memocontents.mem_content;
            notification.alertAction = NSLocalizedString(cell.memocontents.mem_content, nil);
            notification.soundName = [[NSBundle mainBundle] pathForResource:cell.memocontents.mem_mus ofType:@"m4r"];
            
            //设置标志
            
            int i =  (int)indexPath.row;
         
            NSDictionary *dict = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%d",i] forKey:@"someKey"];
            notification.userInfo = dict;
            
            //添加推送到uiapplication
            
            [[UIApplication sharedApplication] scheduleLocalNotification:notification];
            cell.userInteractionEnabled = YES;
            
        }
    
    }
    
    else if (indexPath.section == 2 ) {
    
        [CellUtil fillcolor:cell high:SCREEN_H];
        
    }
    
    return cell;
}



// 设置行高

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



    

//滑动删除

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
 
        AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
        mgr.responseSerializer = [[AFJSONResponseSerializer alloc] init];
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        memoContents *memo = [self.memosArr objectAtIndex:indexPath.row];
        NSLog(@"--------------%d",memo.mem_id);
            [dict setObject:[NSString stringWithFormat:@"%d",memo.mem_id] forKey:@"mem_id"];
            [mgr POST:memorandum_delete parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSDictionary *dict = (NSDictionary *)responseObject;
                int code = [[dict valueForKey:@"code"] intValue];
                if (code == 200) {
                    
                    
                    [self.memosArr removeObjectAtIndex:indexPath.row];
                    
                    
                    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                [self.tableView reloadData];
                    
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                NSLog(@"%@",error);
                
            }];
      
    
      }
   }
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}













@end
