//
//  UserInfoVC.m
//  QuickCard
//
//  Created by administrator on 10/20/15.
//  Copyright (c) 2015 administrator. All rights reserved.
//

#import "UserInfoVC.h"
#import "CellUtil.h"

@interface UserInfoVC ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,assign) float height;
@property (nonatomic,assign) NSIndexPath *indexpath;

@end

@implementation UserInfoVC

/**
 *  自定义导航栏
 */
- (void)initNav
{
    [self.navigationItem setHidesBackButton:YES];  //隐藏默认按钮
    
    UIButton *goBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    goBackBtn.frame = CGRectMake(0, 0 , 28, 28);
    [goBackBtn setBackgroundImage:[UIImage imageNamed:@"btn_return"] forState:UIControlStateNormal];
    
    [goBackBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:goBackBtn];
    
    self.navigationItem.leftBarButtonItem = back;
    
    //自定义导航栏头部
    
    float xPoint = (NAVSIZE_H - 20) / 2;
    float yPoint = (NAVSIZE_W - 20) / 2;
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(xPoint, yPoint, 20, 20)];
    titleLab.text = @"详细信息";
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
        [self.navigationController.navigationBar insertSubview:[[UIImageView alloc]initWithImage:backgroundImage] atIndex:1];
    }
    //便于cell高度的划分
    float height = (SCREEN_H - NAVSIZE_H)/25;
    self.height = height;
}

/**
 *  返回
 */
- (void)goBack {
    
    self.tabBarController.tabBar.hidden =NO;
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.scrollEnabled = NO;
    
    //初始化导航栏
    [self initNav];
    
    self.tabBarController.tabBar.hidden =YES;
    
    //去掉多余的线
    [self clearExtraLine:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"uInfoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    NSInteger row = indexPath.row;
    if (row == 0 || row == 2 || row == 4 || row > 6) {
        //调用灰色填充的类方法
        [CellUtil fillcolor:cell high:self.height];
    }
    else if (row == 1) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 8, self.height * 4 -16, self.height * 4 -16)];
        imgView.image = self.img;
        [cell.contentView addSubview:imgView];
        
        UILabel *namelbl = [[UILabel alloc] initWithFrame:CGRectMake(self.height * 4, self.height - 5, self.height * 4, self.height)];
        namelbl.text = self.name;
        [cell.contentView addSubview:namelbl];
        
        UILabel *dept_grade = [[UILabel alloc] initWithFrame:CGRectMake(self.height * 4, self.height * 3 - 16, self.height * 9, self.height)];
        dept_grade.text = [NSString stringWithFormat:@"%@%@",self.dept,self.grade];
        dept_grade.font = [UIFont systemFontOfSize:14];
        [dept_grade setTextColor:[UIColor grayColor]];
        [cell.contentView addSubview:dept_grade];
    }
    else if (row == 3)
    {
        UILabel *telName = [[UILabel alloc] initWithFrame:CGRectMake(16, 8, 50, self.height * 2 - 16)];
        telName.text = @"电话";
        [cell.contentView addSubview:telName];
        
        UILabel *tel =[[UILabel alloc] initWithFrame:CGRectMake(86, 8, 150, self.height * 2 - 16)];
        tel.text = self.tel;
        [tel setTextColor:[UIColor blueColor]];
        tel.font = [UIFont systemFontOfSize:15];
        tel.userInteractionEnabled = YES;
        
        //添加长按手势
        UILongPressGestureRecognizer *telLP = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(telLPAction:)];
        telLP.minimumPressDuration = 1.0;
        [tel addGestureRecognizer:telLP];
        //添加至cell容器中
        [cell.contentView addSubview:tel];
    }
    else if (row == 5)
    {
        UILabel *emailName = [[UILabel alloc] initWithFrame:CGRectMake(16, 8, 50, self.height * 2 - 16)];
        emailName.text = @"邮箱";
        [cell.contentView addSubview:emailName];
        
        UILabel *email =[[UILabel alloc] initWithFrame:CGRectMake(86, 8, 150, self.height * 2 - 16)];
        email.text = self.email;
        [email setTextColor:[UIColor grayColor]];
        email.font = [UIFont systemFontOfSize:15];
        email.userInteractionEnabled = YES;
        [cell.contentView addSubview:email];
    }
    return cell;
}

//设置cell的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    if (row == 0 || row == 2 || row == 4)
    {
        return self.height;
    }
    else if (row == 1)
    {
        return self.height * 4;
    }
    else if (row == 3 || row ==5)
    {
        return self.height * 2;
    }
    else
    {
        return self.height * 10;
    }
}
#pragma mark - 长按手势
- (void)telLPAction:(UILongPressGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [gesture locationInView:self.tableView];
        self.indexpath = [self.tableView indexPathForRowAtPoint:point];
        
        //实现长按打电话
        UIWebView *web = [[UIWebView alloc]init];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.tel]];
        [web loadRequest:[NSURLRequest requestWithURL:url]];
    }
}

#pragma mark - 去掉多余的线
- (void)clearExtraLine:(UITableView *)tableView
{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor colorWithRed:239.0f/255.0f green:239.0f/255.0f blue:239.0f/255.0f alpha:0.5];
    [self.tableView setTableFooterView:view];
}
@end
