//
//  passwordVC.m
//  QuickCard
//
//  Created by administrator on 10/9/15.
//  Copyright © 2015 administrator. All rights reserved.
//

#import "PasswordVC.h"
#import "LoginVC.h"
#import "AFNetworking.h"
#import "global.pch"
@interface PasswordVC ()
{
    NSTimer *timer;
    int m;
}

@property (weak, nonatomic) IBOutlet UITextField *user_mobile;
@property (weak, nonatomic) IBOutlet UITextField *user_password;
@property (weak, nonatomic) IBOutlet UITextField *queryPassword;
@property (weak, nonatomic) IBOutlet UITextField *CAPTCHA;

@property (weak, nonatomic) IBOutlet UIButton *Captchabtn;
- (IBAction)getCAPTCHA:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *Query;

@end

@implementation PasswordVC

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
    
    //自定义导航栏的title
    
    float xPoint = (NAVSIZE_H - 20) / 2;
    float yPoint = (NAVSIZE_W - 20) / 2;
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(xPoint, yPoint, 20, 20)];
    titleLab.text = @"忘记密码";
    titleLab.textColor = [UIColor whiteColor];
    
    self.navigationItem.titleView = titleLab;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNav];
    
    self.Query.layer.cornerRadius = self.Query.frame.size.height / 4;
    [self.Query addTarget:self action:@selector(QuerybtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationController.navigationBarHidden = NO;
    
    if (self.mobile) {
        self.user_mobile.text = self.mobile;
    }
    
    //初始化倒计时
    m = 60;
    
}

/**
 *  返回
 */
- (void)goBack {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

/**
 *  确认按钮事件
 */
- (void)QuerybtnAction
{
    if (self.user_mobile.text.length == 0 ||self.user_password.text.length == 0 || self.CAPTCHA.text.length == 0) {
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入完整" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        return;
    }
    else if (![self.user_password.text isEqualToString:self.queryPassword.text])
    {
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"对不起，您输入的密码不一致" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        return;
    }
    else
    {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        
        [dict setValue:self.user_mobile.text forKey:user_mobileKey];
        
        [dict setValue:self.user_password.text forKey:user_passwordKey];
        
        NSLog(@"%@",dict);
        
        //AFNetworking单例方法
        AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
        
        mgr.responseSerializer = [[AFJSONResponseSerializer alloc]init];
        
        //用户登录接口
        NSString *urlPath = users_update;
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
                [[[UIAlertView alloc] initWithTitle:@"提示" message:@"修改密码成功" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
                
            }
            //不存在该用户或密码错误
            else if (code == 100)
            {
                [[[UIAlertView alloc] initWithTitle:@"提示" message:@"修改密码失败" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        }];
        LoginVC *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"loginVC"];
        
        loginVC.mobile = self.user_mobile.text;
        
        loginVC.password = self.user_password.text;
        
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

/**
 *  获取验证码
 */
- (IBAction)getCAPTCHA:(UIButton *)sender
{
   timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    UILabel *lbl = [[UILabel alloc] initWithFrame:self.Captchabtn.frame];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.tag = 88;
    [self.view addSubview:lbl];
    
    //自动获取验证码
    [self change];
}

- (void)timeChange
{
    //根据tag获取到label
    UILabel *lbl = (UILabel *)[self.view viewWithTag:88];
    //判断倒计时是否结束（为0时），如果结束，那么就把label删掉，并让按钮显示出来，而且可以点击，同时，销毁定时器
    if (m == 0) {
        [lbl removeFromSuperview];
        self.Captchabtn.hidden = NO;
        self.Captchabtn.enabled = YES;
        [timer invalidate];//停止定时器
        m = 60;
        return;
    }
    self.Captchabtn.enabled = NO;
    self.Captchabtn.hidden = YES;
    //改变label的文字
    lbl.text = [NSString stringWithFormat:@"%ds",m];
    m--;
}

- (void)change
{
    
    NSArray *changeArray = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",
                    @"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",nil];
    
    //可变字符串，存取得到的随机数
    NSMutableString *getStr = [[NSMutableString alloc] initWithCapacity:5];
    
    //可变string，最终想要的验证码
    NSMutableString *changeString = [[NSMutableString alloc] initWithCapacity:6];
    
    //得到四个随机字符，取四次，可自己设长度
    for(NSInteger i = 0; i < 4; i++)
    {
        //得到数组中随机数的下标
        NSInteger index = arc4random() % ([changeArray count] - 1);
        
        //得到数组中随机数，赋给getStr
        getStr = [changeArray objectAtIndex:index];
        
        //把随机字符加到可变string后面，循环四次后取完
        changeString = (NSMutableString *)[changeString stringByAppendingString:getStr];
    }
    self.CAPTCHA.text = changeString;
}
@end
