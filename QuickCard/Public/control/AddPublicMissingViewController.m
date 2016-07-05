//
//  AddPublicMissingViewController.m
//  QuickCard
//
//  Created by administrator on 15/10/16.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "AddPublicMissingViewController.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "AddPublicMissings.h"
#import "PublicMissingViewController.h"
#define myWidth [UIScreen mainScreen].bounds.size.width
#define mainHeight [UIScreen mainScreen].bounds.size.height
@interface AddPublicMissingViewController ()
//@property(nonatomic,retain)NSMutableArray *pubArr;
//@property(nonatomic,copy)UITextField * pub_time;
@property(nonatomic,copy)UITextView * pub_noticeMissing;
@property(nonatomic,copy)UITextField * pub_titltMissing;
@property(nonatomic,copy)NSString * not_contnent;
@property(nonatomic,copy)NSString * dep_department;
@property(nonatomic,copy)NSString * not_title;
//@property(weak,nonatomic)ui
@end

@implementation AddPublicMissingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor colorWithRed:239.0f/255.0f green:239.0f/255.0f blue:239.0f/255.0f alpha:1.0];
    self.title=@"发布通知";
    
    
    [self addText];
    UIButton *goBackPublic = [UIButton buttonWithType:UIButtonTypeCustom];
    
    goBackPublic.frame = CGRectMake(0, 0 , 28, 28);
    [goBackPublic setBackgroundImage:[UIImage imageNamed:@"btn_return"] forState:UIControlStateNormal];
    
    UIBarButtonItem *backPublic = [[UIBarButtonItem alloc] initWithCustomView:goBackPublic];
    
    [goBackPublic addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = backPublic;
    
    
    UIButton *addPublicMissing=[UIButton buttonWithType:UIButtonTypeCustom];
    addPublicMissing.frame=CGRectMake(myWidth-28, 0, 38, 28);
    [addPublicMissing setTitle:@"发布" forState:UIControlStateNormal];
    UIBarButtonItem *addPublic=[[UIBarButtonItem alloc]initWithCustomView:addPublicMissing];
    [addPublicMissing addTarget:self action:@selector(addNotice) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=addPublic;
    
    _pub_noticeMissing.layer.borderColor = UIColor.grayColor.CGColor;
    _pub_noticeMissing.layer.borderWidth = 1;
    _pub_noticeMissing.layer.cornerRadius = 6;
    _pub_noticeMissing.layer.masksToBounds = YES;
    _pub_titltMissing.layer.borderColor = UIColor.grayColor.CGColor;
    _pub_titltMissing.layer.borderWidth = 1;
    _pub_titltMissing.layer.cornerRadius = 6;
    _pub_titltMissing.layer.masksToBounds = YES;
    
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor:[UIColor whiteColor]};
    
   }

- (void)goBack {
    
    
    [self.navigationController popViewControllerAnimated:NO];
    
}
-(void)addText{
    _pub_noticeMissing=[[UITextView alloc]initWithFrame:CGRectMake(myWidth/16, NAVSIZE_H*1.5+75, myWidth-myWidth/8, mainHeight/3)];
    _pub_noticeMissing.backgroundColor=[UIColor whiteColor];
    _pub_noticeMissing.layer.cornerRadius=10;
    _pub_noticeMissing.layer.masksToBounds=YES;
    //    _pub_notice.borderStyle=UITextBorderStyleRoundedRect;
    //    _pub_notice.placeholder=@"请输入想要发布的通告";
    //    _pub_notice.adjustsFontSizeToFitWidth=YES;
    self.automaticallyAdjustsScrollViewInsets=NO;
    _pub_noticeMissing.keyboardAppearance=UIKeyboardAppearanceAlert;
    
    _pub_titltMissing=[[UITextField alloc]initWithFrame:CGRectMake(myWidth/16, NAVSIZE_H*1.5+30, myWidth-myWidth/8, 30)];
    _pub_titltMissing.placeholder=@" 标题:";
    _pub_titltMissing.backgroundColor=[UIColor whiteColor];
    _pub_titltMissing.layer.cornerRadius=10;
    _pub_titltMissing.layer.masksToBounds=YES;
    [self.view addSubview:_pub_titltMissing];
    [self.view addSubview:_pub_noticeMissing];
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)addNotice{
    
    self.not_contnent=_pub_noticeMissing.text;
    self.dep_department=_mytitle;
    self.not_title=_pub_titltMissing.text;
    if (![self.not_contnent isEqual:@""] && ![self.not_title isEqual:@""]) {
        AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
        mgr.responseSerializer = [[AFJSONResponseSerializer alloc] init];
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        
        [dict setObject:self.not_contnent forKey:@"not_contnent"];
        [dict setObject:self.dep_department forKey:@"dep_department"];
        [dict setObject:self.not_title forKey:@"not_title"];
        NSLog(@"--------%@",dict);
        
        [mgr POST:notice_add parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *dict = (NSDictionary *)responseObject;
            int code = [[dict valueForKey:@"code"] intValue];
            NSLog(@"========%@",dict);
            
            if (code == 200) {
                
                [self.navigationController popViewControllerAnimated:NO];
                
            }
            
            else
            {
                
                NSLog(@"%d",code);
                
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"%@",error);
            
        }];
       
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"发布通告" message:@"文本内容不能为空！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        [alert show];
        
    }
}
@end