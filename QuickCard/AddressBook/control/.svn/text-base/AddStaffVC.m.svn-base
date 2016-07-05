//
//  AddStaffVC.m
//  QuickCard
//
//  Created by administrator on 10/13/15.
//  Copyright (c) 2015 administrator. All rights reserved.
//

#import "AddStaffVC.h"
#import "AFNetworking.h"
#import "DropDown.h"
#import "Staff.h"
@interface AddStaffVC ()
@property (weak, nonatomic) IBOutlet UIImageView *user_img;
@property (weak, nonatomic) IBOutlet UITextField *user_number;
@property (weak, nonatomic) IBOutlet UITextField *user_name;
@property (weak, nonatomic) UITextField *user_sex;
@property (weak, nonatomic) IBOutlet UITextField *user_mobile;
@property (weak, nonatomic) IBOutlet UITextField *user_superior_number;
@property (weak, nonatomic) IBOutlet UITextField *user_address;
@property (weak, nonatomic) IBOutlet UITextField *user_email;
@property (weak, nonatomic) IBOutlet UIButton *addbtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelbtn;


@property (weak, nonatomic) UITextField *user_department;
@property (weak, nonatomic) UITextField *user_grade;
@end

@implementation AddStaffVC

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //设置员工号为第一响应者
    [self.user_number becomeFirstResponder];
}

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
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNav];
    
    //设置头像属性
    self.user_img.layer.masksToBounds = YES;
    self.user_img.layer.cornerRadius = 10;
    self.user_img.image = [UIImage imageNamed:@"per_head_default"];

    // 自定义导航栏的title
    
    float xPoint = (NAVSIZE_W - 20) / 2;
    float yPoint = (NAVSIZE_H - 20) / 2;
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(xPoint, yPoint, 20, 20)];
    titleLab.text = @"添加";
    titleLab.textColor = [UIColor whiteColor];
    
    self.navigationItem.titleView = titleLab;
    
    self.addbtn.layer.cornerRadius = 10;
    [self.addbtn addTarget:self action:@selector(addbtnClick) forControlEvents:UIControlEventTouchUpInside];
    
#pragma mark - 下拉框
    //添加性别下拉框
    DropDown *sex = [[DropDown alloc]initWithFrame:CGRectMake(172, 194, (NAVSIZE_W - 100) / 2, 30)];
    NSLog(@"%f---%f",self.user_number.frame.size.width,(NAVSIZE_W - 100) / 2);
    [sex.textField setFont:[UIFont systemFontOfSize:14]];
    sex.textField.placeholder = @"性别";
    NSArray *sexArr = [[NSArray alloc]initWithObjects:@"男",@"女", nil];
    sex.tableArray = sexArr;
    [self.view addSubview:sex];
    self.user_sex = sex.textField;
    
    //添加部门下拉框
    DropDown *department = [[DropDown alloc]initWithFrame:CGRectMake(90, 321, 80, 30)];
    [department.textField setFont:[UIFont systemFontOfSize:14]];
    department.textField.borderStyle =  UITextBorderStyleNone;
    department.textField.placeholder = @"部门";
    NSArray *deptArr = [[NSArray alloc]initWithObjects:@"人事部",@"技术部",@"后勤部",@"行政部", nil];
    department.tableArray = deptArr;
    [self.view addSubview:department];
    self.user_department = department.textField;
    
    //添加职位下拉框
    DropDown *grade = [[DropDown alloc]initWithFrame:CGRectMake(154, 321, 64, 30)];
    [grade.textField setFont:[UIFont systemFontOfSize:14]];
    grade.textField.borderStyle =  UITextBorderStyleNone;
    grade.textField.placeholder = @"职位";
    NSArray *gradeArr = [[NSArray alloc]initWithObjects:@"经理",@"组长",@"职员", nil];
    grade.tableArray = gradeArr;
    [self.view addSubview:grade];
    self.user_grade = grade.textField;
    
    self.tabBarController.tabBar.hidden =YES;
    
    //取消按钮属性和点击事件
    self.cancelbtn.layer.cornerRadius = 10;
    
    [self.cancelbtn addTarget:self action:@selector(cancelbtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    NSLog(@"%f---%f",self.user_number.frame.size.width,(NAVSIZE_W - 100) / 2);
}

// 返回
- (void)goBack {
    
    self.tabBarController.tabBar.hidden =NO;
    [self cancelbtnClick];
    
}

- (void)cancelbtnClick
{
    //初始化
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否取消添加?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //添加按钮
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        self.tabBarController.tabBar.hidden =NO;
        [self.navigationController popViewControllerAnimated:YES];
    }]];
    //弹出
    [self presentViewController:alert animated:YES completion:NULL];
}

/**
 *  添加按钮事件
 */
- (void)addbtnClick
{
    if (self.user_number.text.length == 0 || self.user_name.text.length == 0 || self.user_sex.text.length == 0 || self.user_mobile.text.length == 0 || self.user_department.text.length == 0 || self.user_grade.text.length == 0 || self.user_superior_number.text.length == 0) {
        
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入完整" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        return;
    }
    else
    {
        //获取用户名和密码，保存到dict中
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:self.user_number.text forKey:user_numberKey];
        [dict setValue:self.user_name.text forKey:user_nameKey];
        [dict setValue:self.user_sex.text forKey:user_sexKey];
        [dict setValue:self.user_mobile.text forKey:user_mobileKey];
        [dict setValue:self.user_department.text forKey:user_deptKey];
        [dict setValue:self.user_grade.text forKey:user_gradeKey];
        [dict setValue:self.user_superior_number.text forKey:user_superiorNumKey];
        [dict setValue:self.user_address.text forKey:user_addressKey];
        [dict setValue:self.user_email.text forKey:user_emailKey];
        NSLog(@"dict:%@",dict);
        //AFNetworking单例方法
        AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
        mgr.responseSerializer = [[AFJSONResponseSerializer alloc]init];
        
        //添加用户接口
        NSString *urlPath = users_add;
        
        //利用POST方法传入dict到服务器端请求数据
        [mgr POST:urlPath parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            //获取响应JSON数据
            NSDictionary *dataDict = (NSDictionary *)responseObject;
            
            int code = [[dataDict valueForKey:@"code"]intValue];
            
            if (code == 200)
            {
                //提示添加成功
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"添加成功！" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
                [alert show];
                [self performSelector:@selector(dismissAlert:) withObject:alert afterDelay:1.0];
            }
            else if (code == 100)
            {
                NSLog(@"添加失败");
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        }];
    }
    
}

- (void)dismissAlert:(UIAlertView *)alert
{
    if (alert) {
        [alert dismissWithClickedButtonIndex:[alert cancelButtonIndex] animated:YES];
        //关闭当前试图控制器
        [self.navigationController popViewControllerAnimated:YES];
    }
}















@end
