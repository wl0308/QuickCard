//
//  MyTakeOffTableViewCell.m
//  QuickCard
//
//  Created by administrator on 15/11/7.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "MyTakeOffTableViewCell.h"

@implementation MyTakeOffTableViewCell

-(void)myTakeOffShow{
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    _user_name=[userDefaults objectForKey:@"user_name"];
    
    UILabel *user_name=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W/32,SCREEN_H/48, SCREEN_W/8, SCREEN_H/24)];
    user_name.text=_user_name;
    user_name.font=[UIFont systemFontOfSize:16.0f];
    [self.contentView addSubview:user_name];

    UILabel *reason=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W/16*11, SCREEN_H/48, SCREEN_W/32*9, SCREEN_H/24)];
    reason.text=_myTakeOff.abs_reason;
    reason.font=[UIFont systemFontOfSize:16.0f];
    reason.textAlignment=UITextAlignmentRight;
    [self.contentView addSubview:reason];
    
    UILabel *takeOffTimeLab=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W/32, SCREEN_H/8, SCREEN_W/4, SCREEN_H/24)];
    takeOffTimeLab.font=[UIFont systemFontOfSize:15.0f];
    takeOffTimeLab.text=@"请假时间";
    takeOffTimeLab.textColor=[UIColor colorWithRed:130.0f/255.0f green:130.0f/255.0f blue:130.0f/255.0f alpha:1.0];
    [self.contentView addSubview:takeOffTimeLab];
    
    UILabel *takeOffTime=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W/32*9, SCREEN_H/8, SCREEN_W/8*5, SCREEN_H/24)];
    NSString *starttime=_myTakeOff.abs_starttime;
    NSString *endtime=_myTakeOff.abs_endtime;
    NSString *starttimeAdd=[starttime stringByAppendingString:@" 至 "];
    NSString *takeofftime=[starttimeAdd stringByAppendingString:endtime];
    takeOffTime.text=takeofftime;
    takeOffTime.textColor=[UIColor colorWithRed:130.0f/255.0f green:130.0f/255.0f blue:130.0f/255.0f alpha:1.0];
    takeOffTime.font=[UIFont systemFontOfSize:14.0f];
    [self.contentView addSubview:takeOffTime];
    
    UILabel *type=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W/32, SCREEN_H/96*7, SCREEN_W/4, SCREEN_H/24)];
   
    if([_myTakeOff.abs_type_type isEqual:@"同意"]){
        type.text=@"已通过";
        type.font=[UIFont systemFontOfSize:15.0f];
        type.textColor=[UIColor greenColor];
    }else if([_myTakeOff.abs_type_type isEqual:@"不同意"]){
        type.text=@"未通过";
        type.font=[UIFont systemFontOfSize:15.0f];
        type.textColor=[UIColor redColor];
    }else {
        type.text=@"审批中";
        type.font=[UIFont systemFontOfSize:15.0f];
        type.textColor=[UIColor colorWithRed:95.0f/255.0f green:95.0f/255.0f blue:95.0f/255.0f alpha:1.0];
    }
    [self.contentView addSubview:type];
}

@end
