//
//  PopCircle.m
//  QuickCard
//
//  Created by administrator on 15/10/13.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "PopCircle.h"
#import "ClockSettingViewController.h"
#import "AFNetworking.h"
@implementation PopCircle

- (id)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setBackgroundColor:[UIColor whiteColor]];
        self.layer.cornerRadius = 15;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 7;
        self.layer.borderColor = [[UIColor colorWithRed:112.0f/255.0f green:128.0f/255.0f blue:144.0f/255.0f alpha:0.5] CGColor];
        
        self.DP = [[UIDatePicker alloc] init];

        self.DP.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        self.DP.datePickerMode = UIDatePickerModeCountDownTimer;
        self.DP.date = [NSDate date];
        self.DP.frame = CGRectMake(5, 5, frame.size.width - 10, frame.size.height - 10);
        
        [self.DP addTarget:self action:@selector(timeChange:) forControlEvents:UIControlEventValueChanged];
        
        [self addSubview:self.DP];
        
        UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width / 8 * 3 + 3,frame.size.height - 45 , frame.size.width / 4 - 6, 30)];
        
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        sureBtn.backgroundColor = [UIColor colorWithRed:112.0f/255.0f green:128.0f/255.0f blue:144.0f/255.0f alpha:0.5];
        sureBtn.layer.cornerRadius = 15.0;
        
        [sureBtn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:sureBtn];
    
        
    }
    
    
    return self;
    
}


- (void)timeChange:(UIDatePicker *)picker {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    self.nowTime = [formatter stringFromDate:picker.date];

   }


- (void)sure {

 
    
    //数据存储到数据库中
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [[AFJSONResponseSerializer alloc] init];
    
    if (self.tag == 1) {
        
        
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:[NSString stringWithFormat:@"%@",self.nowTime] forKey:@"wor_time1"];
        NSLog(@"%@",dict);
        [mgr POST:work_time_updateTime1 parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *dict = (NSDictionary *)responseObject;
            
            int code = [[dict objectForKey:@"code"] intValue];
            
            if (code == 200) {
                
                  [self removeFromSuperview];
        
            }
            
            else
            {
            
                NSLog(@"%d",code);
                
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"%@",error);
            
        }];
    }
  
    else if (self.tag == 2) {
    
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:[NSString stringWithFormat:@"%@",self.nowTime] forKey:@"wor_time2"];
        
        [mgr POST:work_time_updateTime2 parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *dict = (NSDictionary *)responseObject;
            
            int code = [[dict objectForKey:@"code"] intValue];
            
            if (code == 200) {
                
                [self removeFromSuperview];
                
            }
            
            else
            {
            
                NSLog(@"%d",code);
                
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"%@",error);
            
        }];
    }
    
   
}


- (void)passTag:(int)tag {

    self.tag = tag;
    NSLog(@"%d",self.tag);
    
}








@end
