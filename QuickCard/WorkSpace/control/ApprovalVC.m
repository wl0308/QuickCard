//
//  ApprovalVC.m
//  QuickCard
//
//  Created by Destiny on 15/10/21.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "ApprovalVC.h"
#import "AFNetworking.h"
#import "global.pch"
#import "TakeOffUser.h"

@interface ApprovalVC ()
{
    NSInteger currentPage;
    NSInteger pageCount;
}
//view上的控件
@property (weak, nonatomic)IBOutlet UIImageView *list_bg;

@property (weak, nonatomic) IBOutlet UIButton *lastPageBtn;
@property (weak, nonatomic) IBOutlet UILabel *approvalNum;
@property (weak, nonatomic) IBOutlet UIButton *nextPageBtn;
@property (weak, nonatomic) IBOutlet UIButton *agreebtn;
@property (weak, nonatomic) IBOutlet UIButton *refusebtn;

@property (nonatomic,strong) UILabel *namelbl;
@property (nonatomic,strong) UILabel *typelbl;
@property (nonatomic,strong) UILabel *reasonlbl;
@property (nonatomic,strong) UILabel *startlbl;
@property (nonatomic,strong) UILabel *endlbl;

@property (nonatomic,strong) UILabel *name;
@property (nonatomic,strong) UILabel *type;
@property (nonatomic,strong) UILabel *reason;
@property (nonatomic,strong) UILabel *start;
@property (nonatomic,strong) UILabel *end;


//存储请假单的数组
@property (nonatomic, strong) NSMutableArray *approvalArr;

//返回通知需要的属性
@property (nonatomic, assign) int abs_id;
@property (nonatomic, weak) NSString *abs_state;
@property (nonatomic, assign) int user_id;
@property (nonatomic, weak) NSString *not_content;


@end

@implementation ApprovalVC

- (void)initNav
{
    self.navigationController.navigationBar.hidden = NO;
    // 自定义导航栏的title
    float xPoint = (NAVSIZE_W - 20) / 2;
    float yPoint = (NAVSIZE_H - 20) / 2;
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(xPoint, yPoint, 20, 20)];
    titleLab.text = @"审批";
    titleLab.textColor = [UIColor whiteColor];
    
    self.navigationItem.titleView = titleLab;
    
    //添加背景
    self.list_bg.image = [UIImage imageNamed:@"message_detial_bg"];
    
    //自定义导航栏左侧按钮
    [self.navigationItem setHidesBackButton:YES];  //隐藏默认按钮
    
    UIButton *goBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    goBackBtn.frame = CGRectMake(0, 0 , 28, 28);
    [goBackBtn setBackgroundImage:[UIImage imageNamed:@"btn_return"] forState:UIControlStateNormal];
    
    [goBackBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:goBackBtn];
    
    self.navigationItem.leftBarButtonItem = back;
    
    self.tabBarController.tabBar.hidden =YES;
}

- (void)loaddata
{
    //NSMutableArray *appArr = [NSMutableArray array];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    self.approvalArr = [NSMutableArray array];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    self.user_number = [user objectForKey:user_numberKey];
    
    [dict setValue:self.user_number forKey:user_numberKey];
    NSLog(@"user_number-%@",self.user_number);
    NSLog(@"dict-%@",dict);
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [[AFJSONResponseSerializer alloc]init];
    
    NSString *urlPath = absence_show;
    
    [mgr POST:urlPath parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //获取响应JSON数据
        NSDictionary *data = (NSDictionary *)responseObject;
        NSLog(@"%@",data);
        int code = [[data valueForKey:@"code"]intValue];
        NSLog(@"cccccccccc%d",code);
        //接口连接成功
        if (code == 200)
        {
            
            //获取JSON中的data数据
            NSArray *dataArr = [data valueForKey:@"data"];
            NSLog(@"%@",dataArr);
            
            for (NSDictionary *dict in dataArr)
            {
                TakeOffUser *takeoff = [TakeOffUser takeOffUserWithDictionary:dict];
                [self.approvalArr addObject:takeoff];
                
            }
            NSLog(@"%@",self.approvalArr);
            //self.approvalArr = appArr;
           
            //当前页码和总页数
            currentPage = 1;
            pageCount = self.approvalArr.count;
            NSLog(@"cooooooooooooooo---%ld +++%lu",(long)pageCount,(unsigned long)self.approvalArr.count);
             //当前审批页面没有请假单时
             if (pageCount == 0)
             {
                 [self remove];
             
             
             }
             
             //有请假单需要审批时
             else
             {
                 self.approvalNum.text = [NSString stringWithFormat:@"%ld/%ld",(long)currentPage,(long)pageCount];
                 if (currentPage == 1 && pageCount == 1)
                 {
                     self.lastPageBtn.enabled = NO;
                     self.nextPageBtn.enabled = NO;
                 }
                 else if (currentPage == 1 && pageCount > 1)
                 {
                     self.lastPageBtn.enabled = NO;
                     self.nextPageBtn.enabled = YES;
                 }
                 else if (currentPage > 1 &&currentPage == pageCount)
                 {
                     self.nextPageBtn.enabled = NO;
                     self.lastPageBtn.enabled = YES;
                 }
                 else
                 {
                     self.lastPageBtn.enabled = YES;
                     self.nextPageBtn.enabled = YES;
                 }
                 
                 
                 TakeOffUser *offuser = [self.approvalArr objectAtIndex:currentPage - 1];
                 //控件的文本值
                 _name.text = [offuser valueForKey:user_nameKey];
                 _type.text = [offuser valueForKey:@"abs_type_type"];
                 _reason.text = [offuser valueForKey:@"abs_reason"];
                 _start.text = [offuser valueForKey:@"abs_starttime"];
                 _end.text = [offuser valueForKey:@"abs_endtime"];
                 
                 [self.lastPageBtn addTarget:self action:@selector(lastPageBtnAction) forControlEvents:UIControlEventTouchUpInside];
                 [self.nextPageBtn addTarget:self action:@selector(nextPageBtnAction) forControlEvents:UIControlEventTouchUpInside];
                 
                 //添加点击触发事件
                 [self.agreebtn addTarget:self action:@selector(addStateAction:) forControlEvents:UIControlEventTouchUpInside];
                 [self.refusebtn addTarget:self action:@selector(addStateAction:) forControlEvents:UIControlEventTouchUpInside];
                 
                 //需要的属性值
                 self.abs_id = [[offuser valueForKey:@"abs_id"]intValue];
                 self.user_id = [[offuser valueForKey:@"user_id"]intValue];
                 self.not_content = [NSString stringWithFormat:@"您的时间为%@到%@的请假条已被批准",_start.text,_end.text];
                 NSLog(@"notttt%@",self.not_content);
             }
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败!%@",error);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化导航栏
    [self initNav];
    
    //初始化加载控件
    [self initlbl];
    
    //加载数据
    [self loaddata];
    
    //设置按钮属性
    self.agreebtn.layer.cornerRadius = 10;
    self.refusebtn.layer.cornerRadius = 10;
    
}

- (void)initlbl
{
    _namelbl = [[UILabel alloc]initWithFrame:CGRectMake(40, 30, 85, 21)];
    _namelbl.textColor = [UIColor lightGrayColor];
    _namelbl.text = @"请假人员:";
    [self.list_bg addSubview:_namelbl];
    
    _typelbl = [[UILabel alloc]initWithFrame:CGRectMake(40, 86, 85, 21)];
    _typelbl.textColor = [UIColor lightGrayColor];
    _typelbl.text = @"请假类型:";
    [self.list_bg addSubview:_typelbl];
    
    _reasonlbl = [[UILabel alloc]initWithFrame:CGRectMake(40, 142, 85, 21)];
    _reasonlbl.textColor = [UIColor lightGrayColor];
    _reasonlbl.text = @"请假原因:";
    [self.list_bg addSubview:_reasonlbl];
    
    _startlbl = [[UILabel alloc]initWithFrame:CGRectMake(40, 198, 85, 21)];
    _startlbl.textColor = [UIColor lightGrayColor];
    _startlbl.text = @"开始时间:";
    [self.list_bg addSubview:_startlbl];
    
    _endlbl = [[UILabel alloc]initWithFrame:CGRectMake(40, 254, 85, 21)];
    _endlbl.textColor = [UIColor lightGrayColor];
    _endlbl.text = @"结束时间:";
    [self.list_bg addSubview:_endlbl];
    
    //消息显示文本
    _name = [[UILabel alloc]initWithFrame:CGRectMake(135, 30, 145, 21)];
    _name.textColor = [UIColor blackColor];
    _name.textAlignment = NSTextAlignmentLeft;
    [self.list_bg addSubview:_name];
    
    _type = [[UILabel alloc]initWithFrame:CGRectMake(135, 86, 145, 21)];
    _type.textColor = [UIColor blackColor];
    [self.list_bg addSubview:_type];
    
    _reason = [[UILabel alloc]initWithFrame:CGRectMake(135, 127, 145, 51)];
    _reason.textColor = [UIColor blackColor];
    [self.list_bg addSubview:_reason];
    
    _start = [[UILabel alloc]initWithFrame:CGRectMake(135, 198, 145, 21)];
    _start.textColor = [UIColor blackColor];
    [self.list_bg addSubview:_start];
    
    _end = [[UILabel alloc]initWithFrame:CGRectMake(135, 254, 145, 21)];
    _end.textColor = [UIColor blackColor];
    [self.list_bg addSubview:_end];
    
    
}

- (void)remove
{
    //隐藏当前页面的所有控件
    self.lastPageBtn.hidden = YES;
    self.approvalNum.hidden = YES;
    self.nextPageBtn.hidden = YES;
    self.agreebtn.hidden = YES;
    self.refusebtn.hidden = YES;
    _name.hidden = YES;
    _namelbl.hidden = YES;
    _type.hidden = YES;
    _typelbl.hidden = YES;
    _reason.hidden = YES;
    _reasonlbl.hidden = YES;
    _start.hidden = YES;
    _startlbl.hidden = YES;
    _end.hidden = YES;
    _endlbl.hidden = YES;
    
    float height = self.list_bg.frame.size.height;
    float width = self.list_bg.frame.size.width;
    //创建一个提示文本，提示无请假单需要审批
    UILabel *suggest = [[UILabel alloc]initWithFrame:CGRectMake(width/2 - 50, height/2 - 10, 100, 21)];
    suggest.text = @"暂无请假单";
    suggest.textColor = [UIColor redColor];
    
    //添加到背景图的view层
    [self.list_bg addSubview:suggest];
}

// 返回
- (void)goBack {
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden =NO;
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)lastPageBtnAction
{
    currentPage --;
    TakeOffUser *offuser = [self.approvalArr objectAtIndex:currentPage - 1];
    //控件的文本值
    _name.text = [offuser valueForKey:user_nameKey];
    _type.text = [offuser valueForKey:@"abs_type_type"];
    _reason.text = [offuser valueForKey:@"abs_reason"];
    _start.text = [offuser valueForKey:@"abs_starttime"];
    _end.text = [offuser valueForKey:@"abs_endtime"];
}

- (void)nextPageBtnAction
{
    currentPage ++;
    NSLog(@"=====================----%@",self.approvalArr[currentPage-1]);
    TakeOffUser *offuser = [self.approvalArr objectAtIndex:currentPage - 1];
    //控件的文本值
    _name.text = [offuser valueForKey:user_nameKey];
    _type.text = [offuser valueForKey:@"abs_type_type"];
    _reason.text = [offuser valueForKey:@"abs_reason"];
    _start.text = [offuser valueForKey:@"abs_starttime"];
    _end.text = [offuser valueForKey:@"abs_endtime"];
}


- (void)addStateAction:(UIButton *)btn
{
    self.abs_state = btn.titleLabel.text;
    
#pragma mark - 添加审批状态
    NSMutableDictionary *absDict = [NSMutableDictionary dictionary];
    [absDict setValue:[NSString stringWithFormat:@"%d",self.abs_id] forKey:@"abs_id"];
    [absDict setValue:self.abs_state forKey:@"abs_state"];
    
    NSLog(@"abs-id%d",self.abs_id);
    AFHTTPRequestOperationManager *absMgr = [AFHTTPRequestOperationManager manager];
    absMgr.responseSerializer = [[AFJSONResponseSerializer alloc]init];
    
    NSString *absUrlPath = absence_add_state;
    
    [absMgr POST:absUrlPath parameters:absDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //获取响应JSON数据
        NSDictionary *data = (NSDictionary *)responseObject;
        
        int code = [[data valueForKey:@"code"]intValue];
        
        NSLog(@"cococococode%d",code);
        //接口连接成功
        if (code == 200)
        {
            //初始化
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"审批成功" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            //添加按钮
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                pageCount --;
                [self.approvalArr removeObjectAtIndex:currentPage - 1];
                if (pageCount == 0) {
                    [self remove];
                }
            }]];
            //弹出
            [self presentViewController:alert animated:YES completion:NULL];
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败!%@",error);
    }];
    
#pragma mark - 添加通知
    NSMutableDictionary *notiDict = [NSMutableDictionary dictionary];
    [notiDict setValue:[NSString stringWithFormat:@"%d",self.user_id] forKey:@"user_id"];
    [notiDict setValue:self.not_content forKey:@"not_content"];
    
    AFHTTPRequestOperationManager *notiMgr = [AFHTTPRequestOperationManager manager];
    notiMgr.responseSerializer = [[AFJSONResponseSerializer alloc]init];
    
    NSString *notiUrlPath = notification_add;
    
    [notiMgr POST:notiUrlPath parameters:absDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //获取响应JSON数据
        NSDictionary *data = (NSDictionary *)responseObject;
        
        int code = [[data valueForKey:@"code"]intValue];
        
        //接口连接成功
        if (code == 200)
        {
            NSLog(@"添加通知成功");
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败!%@",error);
    }];
}











@end
