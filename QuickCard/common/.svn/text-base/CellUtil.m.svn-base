//
//  CellUtil.m
//  QuickCard
//
//  Created by administrator on 15/10/10.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "CellUtil.h"

@implementation CellUtil

//灰色填充
+(void)fillcolor:(UITableViewCell *)cell high:(CGFloat)height {
    
    UIView *fillView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, height)];
    
    
    [fillView setBackgroundColor:[UIColor colorWithRed:239.0f/255.0f green:239.0f/255.0f blue:239.0f/255.0f alpha:0.5]];
    
    cell.userInteractionEnabled = NO;
    
    [cell.contentView addSubview:fillView];
}

@end
