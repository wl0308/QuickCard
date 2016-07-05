//
//  ClockSettingViewController.m
//  QuickCard
//
//  Created by administrator on 15/10/13.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "ClockSettingViewController.h"
#import "PopCircle.h"
#import "AFNetworking.h"
@interface ClockSettingViewController ()

@property (nonatomic,copy) NSString *timeStr;
@property (nonatomic,strong) UILabel *starTimeLab;
@property (nonatomic,strong) UILabel *engTimeLab;
@property (nonatomic,strong) UIButton *editStartBtn;
@property (nonatomic,strong) UIButton *editEndBtn;
@property (nonatomic,strong) UITextField *numText;


@end

@implementation ClockSettingViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //自定义导航栏左侧按钮
    
    [self.navigationItem setHidesBackButton:YES];  //隐藏默认按钮
    
    UIButton *goBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    goBackBtn.frame = CGRectMake(0, 0 , 28, 28);
    [goBackBtn setBackgroundImage:[UIImage imageNamed:@"btn_return"] forState:UIControlStateNormal];
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:goBackBtn];
    
    [goBackBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = back;
    
    
    // 自定义导航栏的title
    
    float xPoint = (NAVSIZE_W - 20) / 2;
    float yPoint = (NAVSIZE_H - 20) / 2;
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(xPoint, yPoint, 20, 20)];
    titleLab.text = @"打卡设置";
    titleLab.textColor = [UIColor whiteColor];
    
    self.navigationItem.titleView = titleLab;
    
    
    //自定义view加到界面上
    
    UIImageView *timeImgView = [[UIImageView alloc]initWithFrame:CGRectMake(5,  NAVSIZE_H + self.height * 2 , SCREEN_W - 10, self.height * 3)];
    [timeImgView setImage:[UIImage imageNamed:@"cell_background"]];
    
    [self.view addSubview:timeImgView];
    
    //自定义view上面的控件
    
    UILabel *startLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 13, SCREEN_W / 2 - 30, self.height - 12)];
    startLab.text = @"标准上班时间 :";
    
    [timeImgView addSubview:startLab];
    
    UILabel *endLab = [[UILabel alloc] initWithFrame:CGRectMake(10, self.height * 2 - 1 , SCREEN_W / 2 - 30, self.height - 12)];
    endLab.text = @"标准下班时间 :";
    
    [timeImgView addSubview:endLab];
    
    self.starTimeLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W / 3 * 2 - 10, 7, SCREEN_W / 5, self.height)];
    
    self.engTimeLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W / 3 * 2 - 10, self.height * 2 -5, SCREEN_W / 5, self.height)];
   
    [timeImgView addSubview:self.starTimeLab];
    [timeImgView addSubview:self.engTimeLab];
    
    
    self.editStartBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_W / 3 * 2 + SCREEN_W / 5 , 8 + self.height * 2 +NAVSIZE_H, SCREEN_W / 10 - 10, self.height )];
    [self.editStartBtn setImage:[UIImage imageNamed:@"btn_write_s"] forState:UIControlStateNormal];
    
    self.editStartBtn.tag = 1;
    
    [self.editStartBtn addTarget:self action:@selector(chooseTime:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.editStartBtn];
    
    self.editEndBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_W / 3 * 2 + SCREEN_W / 5 , self.height * 4 - 5 +NAVSIZE_H, SCREEN_W / 10 - 10, self.height )];

    [self.editEndBtn setImage:[UIImage imageNamed:@"btn_write_s"] forState:UIControlStateNormal];
    
    self.editEndBtn.tag = 2;
    
    [self.editEndBtn addTarget:self action:@selector(chooseTime:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.editEndBtn];

    //自定义view加到界面上
    
    UIImageView *localImgView = [[UIImageView alloc]initWithFrame:CGRectMake(5,  NAVSIZE_H + self.height * 6 , SCREEN_W - 10, self.height * 6)];
    [localImgView setImage:[UIImage imageNamed:@"cell_background"]];
    
    [self.view addSubview:localImgView];
    
    //自定义view上面的控件
    
    UILabel *localLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 13, SCREEN_W - 20, self.height - 12)];
    localLab.text = @"企业位置  请点击下方按钮进行定位";
    
    [localImgView addSubview:localLab];
    
    UIButton *localBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_W - 80) / 2 - 5, self.height * 2, 80 , self.height / 3 * 4)];
    [localBtn.layer setCornerRadius:10.0];
    [localBtn setBackgroundColor:[UIColor colorWithRed:39.0f/255.0f green:69.0f/255.0f blue:153.0f/255.0f alpha:0.5]];
    [localBtn setTitle:@"自动定位" forState:UIControlStateNormal];
    [localBtn addTarget:self action:@selector(startLocal) forControlEvents:UIControlEventTouchUpInside];
    
    [localImgView addSubview:localBtn];
    localImgView.userInteractionEnabled = YES;
    
    UILabel *detaiLab = [[UILabel alloc] initWithFrame:CGRectMake(10, self.height * 4 - 3, SCREEN_W - 20, self.height)];
    detaiLab.text = @"进入以“企业位置”为中心，“有效半径”为半径的范围内，员工即可进行上下班打卡";
    detaiLab.font = [UIFont systemFontOfSize:14];
    detaiLab.textColor = [UIColor colorWithRed:105.0f/255.0f green:105.0f/255.0f blue:105.0f/255.0f alpha:0.5];

    detaiLab.lineBreakMode = NSLineBreakByCharWrapping;
    detaiLab.numberOfLines = 0;
    [detaiLab sizeToFit];
    
    [localImgView addSubview:detaiLab];
    
    //定义半径
    
    UIImageView *ImgView = [[UIImageView alloc]initWithFrame:CGRectMake(5,  NAVSIZE_H + self.height * 13 , SCREEN_W - 10, self.height * 3)];
    [ImgView setImage:[UIImage imageNamed:@"cell_background"]];
    ImgView.userInteractionEnabled = YES;
    [self.view addSubview:ImgView];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, self.height + 1, 80, self.height)];
    lab.text = @"有效半径";
    [ImgView addSubview:lab];
    
    self.numText = [[UITextField alloc] initWithFrame:CGRectMake(NAVSIZE_W / 2 + 8, self.height + 2, 70, self.height)];
    self.numText.text = @"100";
    self.numText.layer.cornerRadius = 3.0;
    self.numText.layer.masksToBounds = YES;
    self.numText.layer.borderColor = [[UIColor colorWithRed:50.0f / 255.0f green:50.0f / 255.0f blue:50.0f / 255.0f alpha:0.5] CGColor];
    self.numText.layer.borderWidth = 1;
    [ImgView addSubview:self.numText];
    
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(NAVSIZE_W / 2 + 80, self.height + 2, 15, self.height)];
    lab1.text = @"米";
    [ImgView addSubview:lab1];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(NAVSIZE_W / 2 -25, self.height + 2, 25, 25)];
    [btn.layer setCornerRadius:12.0];
    btn.layer.masksToBounds = YES;
    [btn setBackgroundImage:[UIImage imageNamed:@"Minus"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(minus) forControlEvents:UIControlEventTouchUpInside];
    [ImgView addSubview:btn];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(NAVSIZE_W / 2 + 100, self.height + 2, 25, 25)];
    [btn1.layer setCornerRadius:12.0];
    btn1.layer.masksToBounds = YES;
    [btn1 setBackgroundImage:[UIImage imageNamed:@"Add"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    [ImgView addSubview:btn1];
    
    
}

- (void)minus {

   int num = [self.numText.text intValue];
    num = num - 5;
    self.numText.text = [NSString stringWithFormat:@"%d",num];
    
}

- (void)add {

    int num = [self.numText.text intValue];
    num = num + 5;
    self.numText.text = [NSString stringWithFormat:@"%d",num];
}
//定位 事件

- (void)startLocal {
    
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"定位成功" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertview show];
   

    
}

//编辑按钮事件

- (void)chooseTime :(UIButton *)btn {
    

    PopCircle *pop = [[PopCircle alloc] initWithFrame:CGRectMake(35, SCREEN_H / 3, SCREEN_W - 70, SCREEN_H / 3)];
    
    self.passDelegate = pop;
    [self.passDelegate passTag:btn.tag];
    [self.view addSubview:pop];
    
  
}

//导航栏左侧按钮事件

- (void)goBack {

    [self.navigationController popViewControllerAnimated:YES];
    
}

//弹出框从view上移除进行的动作

- (void)viewWillLayoutSubviews {

    //数据库请求获得上下班时间
    
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [[AFJSONResponseSerializer alloc] init];
    
    [mgr POST:work_time_show parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        
        int code = [[dict valueForKey:@"code"] intValue];
        
        if (code == 200) {
            
            NSArray *dataArr = [dict valueForKey:@"data"];
            NSDictionary *dictTime = [dataArr firstObject];
            NSString *startStr = [dictTime valueForKey:@"wor_time1"];
            self.starTimeLab.text = [startStr substringToIndex:5];
            
            NSString *endStr = [dictTime valueForKey:@"wor_time2"];
            self.engTimeLab.text = [endStr substringToIndex:5];
            
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    

}


@end
