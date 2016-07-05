//
//  NotificationTableViewCell.m
//  QuickCard
//
//  Created by administrator on 15/10/11.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "NotificationTableViewCell.h"

@implementation NotificationTableViewCell

- (void)notifiShow:(CGFloat)height {
    
    
    UILabel *messageLab = [[UILabel alloc] initWithFrame:CGRectMake(5, 6, SCREEN_W, height / 2 -4)];
    messageLab.text = self.notifications.not_content;
    messageLab.font = [UIFont boldSystemFontOfSize:15];
    
    [self.contentView addSubview:messageLab];
    
    UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(5, height / 2 + 3, SCREEN_W, height / 2 -4)];
    
    timeLab.text = self.notifications.not_time;
    timeLab.textColor = [UIColor colorWithRed:50.0f/255.0f green:50.0f/255.0f blue:50.0f/255.0f alpha:0.5];
    timeLab.font = [UIFont systemFontOfSize:15];
    
    [self.contentView addSubview:timeLab];
    
    self.userInteractionEnabled = YES;

}

@end
