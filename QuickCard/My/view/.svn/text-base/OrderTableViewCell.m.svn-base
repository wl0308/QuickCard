//
//  OrderTableViewCell.m
//  QuickCard
//
//  Created by administrator on 15/10/11.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "OrderTableViewCell.h"

@implementation OrderTableViewCell

// 数据显示

- (void)infosShow:(CGFloat)height {

    UILabel *depLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 6, 100, height)];
    depLab.text = self.orders.deptname;
    
    [self.contentView addSubview:depLab];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(15 , height + 14, 100, height)];
    titleLab.text = self.orders.not_title;
    
    titleLab.font = [UIFont boldSystemFontOfSize:15];
    titleLab.textColor = [UIColor colorWithRed:50.0f/255.0f green:50.0f/255.0f blue:50.0f/255.0f alpha:0.5];
    
    [self.contentView addSubview:titleLab];
    
    UILabel *timeLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W - 48, 8, 100, height)];
    
    NSString *strTime = [self.orders.not_date substringFromIndex:5];
    timeLab.text = strTime;
    
    timeLab.font = [UIFont boldSystemFontOfSize:14];
    timeLab.textColor = [UIColor colorWithRed:50.0f/255.0f green:50.0f/255.0f blue:50.0f/255.0f alpha:0.5];
    
    [self.contentView addSubview:timeLab];
    
}
@end
