//
//  PublicMissingViewController.m
//  QuickCard
//
//  Created by administrator on 15/10/16.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "PublicMissingViewController.h"
#import "PublicViewController.h"
#import "AddPublicMissingViewController.h"
#import "PublicContnent.h"
#import "AFNetworking.h"
#import "PublicMissingTableViewCell.h"
#define myWidth [UIScreen mainScreen].bounds.size.width
#define mainHeight [UIScreen mainScreen].bounds.size.height
@interface PublicMissingViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UILabel *_publicTitle;
    UITextField *_publicText;
    UIView *_cellView;
    UILabel *_lblHead;
    NSString *user_grade;
    NSString *user_id;
    PublicMissingTableViewCell *cell;
    UIBarButtonItem *anotherButton;
    NSMutableArray *buttons;
}
@property(nonatomic,strong)NSMutableArray *notArr;
@property(nonatomic,strong)PublicContnent *publicContnent;
@property(nonatomic,strong)PublicViewController *notData;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,assign)BOOL flag;
@end
@implementation PublicMissingViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:239.0f/255.0f green:239.0f/255.0f blue:239.0f/255.0f alpha:1.0];
    [self.navigationItem setHidesBackButton:YES];
    self.title=_mytitle;
    _flag=NO;
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    user_grade=[userDefaults objectForKey:@"user_grade"];
    user_id=[userDefaults objectForKey:@"user_id"];
    
    UIButton *goBackPublic = [UIButton buttonWithType:UIButtonTypeCustom];
    
    goBackPublic.frame = CGRectMake(0, 0 , 28, 28);
    [goBackPublic setBackgroundImage:[UIImage imageNamed:@"btn_return"] forState:UIControlStateNormal];
    
    UIBarButtonItem *backPublic = [[UIBarButtonItem alloc] initWithCustomView:goBackPublic];
    
    [goBackPublic addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = backPublic;
    UIButton *addPublicMissing=[UIButton buttonWithType:UIButtonTypeCustom];
    addPublicMissing.frame=CGRectMake(myWidth-28, 0, 24, 24);
    [addPublicMissing setBackgroundImage:[UIImage imageNamed:@"btn_apply"] forState:UIControlStateNormal];
    UIBarButtonItem *addPublic=[[UIBarButtonItem alloc]initWithCustomView:addPublicMissing];
    [addPublicMissing addTarget:self action:@selector(addPM) forControlEvents:UIControlEventTouchUpInside];
    
    if ([user_grade isEqualToString:@"经理"]) {
        UIToolbar *tool=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 70, 60)];
        [tool setBackgroundImage:[UIImage new] forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        [tool setShadowImage:[UIImage new] forToolbarPosition:UIToolbarPositionAny];
        tool.clipsToBounds=YES;
        [tool setTintColor:[UIColor colorWithRed:64 green:110 blue:117 alpha:1]];
        
        buttons=[[NSMutableArray alloc]initWithCapacity:2];
        anotherButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(clickSettings)];
        
        [buttons addObject:anotherButton];
        [buttons addObject:addPublic];
        [tool setItems:buttons animated:NO];
        UIBarButtonItem *myBtn=[[UIBarButtonItem alloc]initWithCustomView:tool];
        self.navigationItem.rightBarButtonItem=myBtn;
    }else{
        self.navigationItem.rightBarButtonItem=addPublic;
    }
    
    
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor:[UIColor whiteColor]};
    
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    _notArr=[NSMutableArray array];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // 请求的序列化
    manager.responseSerializer = [[AFJSONResponseSerializer alloc] init];
    
    self.dep_department=_mytitle;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:self.dep_department forKey:@"dep_department"];
    
    
    [manager POST:subdetail_show
       parameters:dict
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSDictionary *dict=(NSDictionary *)responseObject;
              NSArray *dataArr=[dict valueForKey:@"data"];
              
              int code=[[dict valueForKey:@"code"]intValue];
              if (code == 200) {
                  for (NSDictionary *dict in dataArr) {
                      
                      PublicContnent *notText=[PublicContnent PublicContentWithDictionary:dict];
                      NSLog(@"%@",dict);
                      [_notArr addObject:notText];
                      NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"not_id" ascending:YES]];
                      
                      [_notArr sortUsingDescriptors:sortDescriptors];
                      
                      NSMutableArray *resultArr = [NSMutableArray array];
                      
                      for (int i = (int)_notArr.count - 1; i >= 0; i--) {
                          
                          [resultArr addObject:_notArr[i]];
                          
                      }
                      
                      _notArr = resultArr;
                      [self addTableView];
                      
                  }
//                  [self.tableView reloadData];
              }
              
              
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"%@",error);
          }];
    
    
    
    
}






- (void)goBack {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (UITableViewHeaderFooterView *)headerViewForSection:(NSInteger)section{
    return 0;
}

-(void)addTableView{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(SCREEN_W/16,SCREEN_H/48+NAVSIZE_H, SCREEN_W-SCREEN_W/8, SCREEN_H)style:UITableViewStyleGrouped];
    //    _tableView.layer.cornerRadius=10;
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.contentInset = UIEdgeInsetsMake(0,0,200,0);
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:_tableView];
}
-(void)clipExtraCellLina:(UITableView *)tableView{
    UIView *view=[[UIView alloc]init];
    view.backgroundColor=[UIColor clearColor];
    [_tableView setTableFooterView:view];
}
-(void)clickSettings{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Public" bundle:nil];
    PublicMissingViewController *gVC = [storyboard instantiateViewControllerWithIdentifier:@"AddPM"];
    gVC.mytitle=_mytitle;
    [self.navigationController pushViewController:gVC animated:YES];
    
}
-(void)addPM{
    if (_flag==NO) {
        _dep_department=_mytitle;
        AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
        mgr.responseSerializer = [[AFJSONResponseSerializer alloc] init];
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:user_id forKey:@"user_id"];
        [dict setObject:_dep_department forKey:@"dep_department"];
        [mgr POST:subscribe_add parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dict=(NSDictionary *)responseObject;
            int code=[[dict valueForKey:@"code"]intValue];
            if (code == 200) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"订阅" message:@"订阅成功！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
                _flag=YES;
                [alert show];
            }else{
                NSLog(@"%d",code);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
        }];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"订阅" message:@"该部门已经订阅！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        [alert show];
    }
    
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.notArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    static NSString *CellIdentifier = @"Cell";
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[PublicMissingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    PublicContnent *publicContnent=self.notArr[indexPath.section];
    cell.publicContnent=publicContnent;
    if (indexPath.row==1) {
         [cell publicMissingTableViewCellShow];
    }else{
        cell.backgroundColor=[UIColor colorWithRed:239.0f/255.0f green:239.0f/255.0f blue:239.0f/255.0f alpha:1.0];
    }
    cell.layer.cornerRadius=15;
    tableView.separatorStyle=UITableViewCellSelectionStyleNone;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 0;
    
    
        
    }else
        return 120;
}

@end
