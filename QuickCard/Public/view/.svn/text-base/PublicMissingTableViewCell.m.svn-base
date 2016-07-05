//
//  PublicMissingTableViewCell.m
//  QuickCard
//
//  Created by administrator on 15/11/5.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "PublicMissingTableViewCell.h"
#import "AFNetworking.h"
@implementation PublicMissingTableViewCell

-(void)publicMissingTableViewCellShow{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(SCREEN_W/32, 0, SCREEN_W-SCREEN_W/16, SCREEN_H/4)];
    
    UILabel *titel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W-SCREEN_W/16, SCREEN_H/16)];
    titel.text=_publicContnent.not_title;
    [titel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [view addSubview:titel];
    
    UILabel *contnent=[[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_H/16, SCREEN_W-SCREEN_W/32*5, SCREEN_H/48*7)];
    contnent.text=_publicContnent.not_contnent;
    contnent.numberOfLines=0;
    contnent.font=[UIFont systemFontOfSize:16];
    contnent.adjustsFontSizeToFitWidth=YES;
    [view addSubview:contnent];
    
    UILabel *time=[[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_H/24*5, SCREEN_W-SCREEN_W/16, SCREEN_H/24)];
    time.text=_publicContnent.not_date;
    time.textColor=[UIColor colorWithRed:201.0f/255.0f green:201.0f/255.0f blue:201.0f/255.0f alpha:1.0];
    time.font=[UIFont systemFontOfSize:14];
    [view addSubview:time];
    
    [self.contentView addSubview:view];
}

@end
