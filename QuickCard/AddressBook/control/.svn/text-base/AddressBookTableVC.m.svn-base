//
//  addressBookTableVC.m
//  QuickCard
//
//  Created by administrator on 10/12/15.
//  Copyright © 2015 administrator. All rights reserved.
//

#import "AddressBookTableVC.h"
#import "AFNetworking.h"
#import "StaffCell.h"
#import "Staff.h"
#import "Department.h"
#import "DeptHeaderView.h"
#import "AddStaffVC.h"
#import "UserInfoVC.h"


@interface AddressBookTableVC ()<deptHeaderViewDelegate,UISearchBarDelegate,UISearchResultsUpdating>

@property (nonatomic,strong) UIRefreshControl *refresh;
@property(nonatomic,strong)NSMutableArray *departmentArr;
@property(nonatomic,strong)NSMutableArray *searchResult;
@property(nonatomic,strong)UISearchController *searchController;
@property(nonatomic,strong)NSMutableArray *searchName;
@property(nonatomic,strong)NSMutableArray *searchPhone;

@end

@implementation AddressBookTableVC

- (void)loadData
{
    NSMutableArray *deptArr = [NSMutableArray array];
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    mgr.responseSerializer = [[AFJSONResponseSerializer alloc]init];
    
    NSString *urlPath = show_department;
    
    [mgr POST:urlPath parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //获取响应JSON数据
        NSDictionary *data = (NSDictionary *)responseObject;
        
        int code = [[data valueForKey:@"code"]intValue];
        
        //接口连接成功
        if (code == 200)
        {
            
            //获取JSON中的data数据
            NSArray *dataArr = [data valueForKey:@"data"];
            
            for (NSDictionary *dict in dataArr) {
                
                Department *dept = [Department departmentWithDict:dict];
                [deptArr addObject:dept];
            }
            _departmentArr = deptArr;
            NSLog(@"ddd---%d",_departmentArr.count);
            [self.tableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败!%@",error);
    }];
    
//    NSLog(@"ddd---%d",_departmentArr.count);
    
    
    
}

- (NSMutableArray *)departmentArr
{
    if (_departmentArr == nil) {
        
        [self loadData];
        
    }
    /**
     *  初始化加载姓名列表
     */
    _searchName = [NSMutableArray array];
    _searchPhone = [NSMutableArray array];
    NSMutableArray *arr = [_departmentArr valueForKey:@"users"];
    //NSLog(@"name%@",[arr valueForKey:@"user_name"]);
    for (NSDictionary *dict in arr) {
        NSArray *arrname = [dict valueForKey:@"user_name"];
        NSLog(@"nnnn%@",arrname);
        for (NSString *name in arrname) {
            [_searchName addObject:name];
            
            NSLog(@"nameee%@",name);
        }
        
        NSArray *arrPhone = [dict valueForKey:@"user_mobile"];
        for (NSString *phone in arrPhone) {
            [_searchPhone addObject:phone];
            NSLog(@"nameee%@",phone);
        }
    }
    NSLog(@"lllllllili%@",_searchName);
    NSLog(@"lllllllili%@",_searchPhone);
//    NSLog(@"=====%@",[_departmentArr valueForKey:@"users"]);
    return _departmentArr;
}

- (void)initNav
{
    
    //导航栏添加背景图片
    float systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    UIImage *bgImg = [UIImage imageNamed:@"nav_bg"];
    if (systemVersion >= 5.0) {
        [self.navigationController.navigationBar setBackgroundImage:bgImg forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        [self.navigationController.navigationBar insertSubview:[[UIImageView alloc]initWithImage:bgImg] atIndex:1];
    }
    
    //设置tableView的行高
    self.tableView.rowHeight = (SCREEN_H - NAVSIZE_H)/25*2;
    //头部控件的高度
    self.tableView.sectionHeaderHeight = 44;
    [self clearExtraLine:self.tableView];
    
    // 自定义导航栏的title
    
    float xPoint = (NAVSIZE_W - 20) / 2;
    float yPoint = (NAVSIZE_H - 20) / 2;
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(xPoint, yPoint, 20, 20)];
    titleLab.text = @"通讯录";
    titleLab.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLab;
}

/**
 *  搜索框
 */
- (void)initSearchBar
{
    
    _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    _searchController.searchBar.frame = CGRectMake(0, NAVSIZE_W, NAVSIZE_W, 44);
    self.tableView.tableHeaderView = self.searchController.searchBar;
    _searchController.searchResultsUpdater = self;
    _searchController.dimsBackgroundDuringPresentation = NO;
//    _searchController.active = NO;
    _searchController.searchBar.delegate = self;
    _searchController.hidesNavigationBarDuringPresentation = NO;
    self.tableView.tableHeaderView = _searchController.searchBar;
//    [self.view addSubview:self.searchController.searchBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNav];
    [self loadData];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *user_grade = [user objectForKey:@"user_grade"];
    if ([user_grade isEqualToString:@"经理"]) {
        //设置添加按钮属性
        UIBarButtonItem *addbtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addStaffClick)];
        self.navigationItem.rightBarButtonItem = addbtn;
    }
    //设置刷新
    [self setBeginRefreshing];
    
    [self initSearchBar];

    
}

/**
 *  下拉刷新
 */
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

/**
 *  刷新时间
 */
- (void)refreshData {
    
    //提示上次刷新的时间
    
    NSString *time = nil;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; //创建时间格式
    
    time = [formatter stringFromDate:[NSDate date]];
    NSString *lastUpdated = [NSString stringWithFormat:@"上一次的刷新时间为%@",time];
    
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdated];
    
    //加载数据
    [self loadData];
    
    //停止刷新
    [self.refreshControl endRefreshing];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    if (self.searchController.active) {
        return 1;
    }
    return self.departmentArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (self.searchController.active) {
        self.searchController.dimsBackgroundDuringPresentation = YES;
        _searchController.hidesNavigationBarDuringPresentation = YES;
        return [self.searchResult count];
    }
    
    Department *dept = self.departmentArr[section];

    return (dept.isOpened ? dept.users.count : 0);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellID = @"staffCell";
    StaffCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];

    if (cell == nil)
    {
        cell = [[StaffCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellID];
    }
    
    if (self.searchController.active) {
        [cell.textLabel setText:self.searchName[indexPath.row]];
        [cell.detailTextLabel setText:self.searchPhone[indexPath.row]];
    }
    else
    {
        Department *dept = self.departmentArr[indexPath.section];
        cell.staffData = dept.users[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:13];
    }
    
    
    return cell;
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchString = [self.searchController.searchBar text];
    
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@", searchString];
    
    if (self.searchResult!= nil) {
        [self.searchResult removeAllObjects];
    }

    //过滤数据
    self.searchResult= [NSMutableArray arrayWithArray:[self.searchPhone filteredArrayUsingPredicate:preicate]];
    
    //刷新表格
    
    [self.tableView reloadData];
}

/**
*  返回每一组需要显示的头部标题（字符出纳）
*/
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    //创建头部控件
    DeptHeaderView *header = [DeptHeaderView deptHeaderViewWithTableView:tableView];
    
    header.delegate = self ;
    //给header设置数据
    header.dept = self.departmentArr[section];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.searchController.active) {
        
        return 0;
    }
    return 44;
}

#pragma mark - headerView的代理方法
/**
*  点击了headerView上面的名字按钮时就会被调用
*/
- (void)deptHeaderViewDidClickedNameView
{
    [self.tableView reloadData];
}
#pragma mark - 去掉多余的线
- (void)clearExtraLine:(UITableView *)tableView
{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
}

#pragma mark - 管理员添加职员
- (void)addStaffClick
{
    static NSString *ID = @"addStaffVC";
    AddStaffVC *addVC = [self.storyboard instantiateViewControllerWithIdentifier:ID];

    [self.navigationController pushViewController:addVC animated:YES];
}


#pragma mark - 选择某一行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"UserInfoVC";
    UserInfoVC *uInfoVC = [self.storyboard instantiateViewControllerWithIdentifier:ID];
    
    Department *dept = self.departmentArr[indexPath.section];
    Staff *staff = dept.users[indexPath.row];
    
    uInfoVC.name = staff.user_name;
    uInfoVC.img = [UIImage imageNamed:staff.user_img];
    uInfoVC.tel = staff.user_mobile;
    uInfoVC.dept = dept.department;
    uInfoVC.grade = staff.user_grade;
    uInfoVC.email = staff.user_email;
    
    [self.navigationController pushViewController:uInfoVC animated:YES];
}







@end
