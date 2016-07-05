//
//  loginVC.m
//  QuickCard
//
//  Created by administrator on 10/9/15.
//  Copyright © 2015 administrator. All rights reserved.
//

#import "LoginVC.h"
#import "PasswordVC.h"
#import "AFNetworking.h"
#import "MyTableViewController.h"
#import "AllBarViewController.h"

@interface LoginVC ()

@property (weak, nonatomic) IBOutlet UIImageView *user_img;

@property (weak, nonatomic) IBOutlet UITextField *user_mobile;

@property (weak, nonatomic) IBOutlet UITextField *user_password;

@property (weak, nonatomic) IBOutlet UIButton *loginbtn;

@end

@implementation LoginVC

/**
 *  界面显示时隐藏导航栏
 */
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    
    self.user_mobile.text = self.mobile;
    self.user_password.text = self.password;
    
    [[NSNotificationCenter defaultCenter]removeObserver:self.user_mobile];
    [[NSNotificationCenter defaultCenter]removeObserver:self.user_password];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置头像属性
    self.user_img.layer.masksToBounds = YES;
    
    self.user_img.layer.cornerRadius = 50;
    
    self.user_img.image = [UIImage imageNamed:@"per_head_default"];
    
    self.user_img.frame = CGRectMake(self.user_img.frame.origin.x, self.user_img.frame.origin.y, self.user_img.frame.size.width, self.user_img.frame.size.width);
    
    self.loginbtn.layer.cornerRadius = 10;
    [self.loginbtn addTarget:self action:@selector(loginbtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    //给view添加背景图片
    UIImageView *bg = [[UIImageView alloc]init];
    
    bg.frame = self.view.frame;
    
    [bg setImage:[UIImage imageNamed:@"bg"]];
    
    [self.view addSubview:bg];
    
}

/**
 *  忘记密码
 */
- (IBAction)forgetPwdBtnClick:(UIButton *)sender {
    
    PasswordVC *pwdVC = [self.storyboard instantiateViewControllerWithIdentifier:@"pwdVC"];
    
    pwdVC.mobile = self.user_mobile.text;
    
    [self.navigationController pushViewController:pwdVC animated:YES];
}
/**
 *  用户第一次登录
 */
- (void)loginbtnAction
{
    if (self.user_mobile.text.length == 0 ||self.user_password.text.length == 0) {
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入完整" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        return;
    }
    else
    {
        //获取用户名和密码，保存到dict中
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        
        [dict setValue:self.user_mobile.text forKey:user_mobileKey];
        
        [dict setValue:self.user_password.text forKey:user_passwordKey];
        
        NSLog(@"%@",dict);
        
        //AFNetworking单例方法
        AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
        
        mgr.responseSerializer = [[AFJSONResponseSerializer alloc]init];
        
        //用户登录接口
        NSString *urlPath = users_login;
        //    NSLog(@"%@",urlPath);
        NSLog(@"before post.........");
        
        //利用POST方法传入dict到服务器端请求数据
        [mgr POST:urlPath parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            
            NSLog(@"%@",responseObject);
            
            //获取响应JSON数据
            NSDictionary *dataDict = (NSDictionary *)responseObject;
            
            int code = [[dataDict valueForKey:@"code"]intValue];
            
            //存在该用户且密码正确
            if (code == 200)
            {
                
                //获取JSON中的data数据
                NSArray *dataArr = [dataDict valueForKey:@"data"];
                
                NSDictionary *userDict = [dataArr firstObject];
                
                //获取用户的所有信息
                int id = [[userDict valueForKey:user_idKey]intValue];
                NSString *img = [userDict valueForKey:user_imgKey];
                NSString *user_superior_number = [userDict valueForKey:user_superiorNumKey];
                NSString *user_number = [userDict valueForKey:user_numberKey];
                NSString *user_name = [userDict valueForKey:user_nameKey];
                NSString *user_grade = [userDict valueForKey:user_gradeKey];
                NSString *user_sex = [userDict valueForKey:user_sexKey];
                NSString *user_email = [userDict valueForKey:user_emailKey];
                NSString *user_address = [userDict valueForKey:user_addressKey];
                NSString *user_department = [userDict valueForKey:user_deptKey];
                
                //打印沙河路径
                NSLog(@"%@",NSHomeDirectory());
                
                //将用户的所有信息数据本地化
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                [user setObject:[NSString stringWithFormat:@"%d",id] forKey:user_idKey];
                [user setObject:self.user_mobile.text forKey:user_mobileKey];
                [user setObject:self.user_password.text forKey:user_passwordKey];
                [user setObject:img forKey:user_imgKey];
                [user setObject:user_superior_number forKey:user_superiorNumKey];
                [user setObject:user_number forKey:user_numberKey];
                [user setObject:user_name forKey:user_nameKey];
                [user setObject:user_grade forKey:user_gradeKey];
                [user setObject:user_sex forKey:user_sexKey];
                [user setObject:user_email forKey:user_emailKey];
                [user setObject:user_address forKey:user_addressKey];
                [user setObject:user_department forKey:user_deptKey];
                
                //设置同步
                [user synchronize];
                
                //登录跳转
                AllBarViewController *allBarVC = [AllBarViewController new];
                NSLog(@"hello..............");
                [self.navigationController pushViewController:allBarVC animated:YES];
                
                //            NSLog(@"id-%d,user_mobile-%@,user_password-%@",id,self.user_mobile.text,self.user_password.text);
            }
            //不存在该用户或密码错误
            else if (code == 100)
            {
                [[[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名或密码错误" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        }];
    }
    
}

/**
 *  触摸键盘外空白区域隐藏键盘
 *
 *  @param touches
 *  @param event
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


@end
