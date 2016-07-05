//
//  memoTableViewCell.m
//  QuickCard
//
//  Created by administrator on 15/10/12.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "memoTableViewCell.h"

@implementation memoTableViewCell

- (void)memoShow:(CGFloat)height {
    
    UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(6, 4, SCREEN_W / 2, height / 2)];
    NSString *timeStr =[self.memocontents.mem_datetime substringFromIndex:11];
    timeLab.text = [timeStr substringToIndex:5];
    timeLab.font = [UIFont boldSystemFontOfSize:27];
    
    UILabel *contentLab = [[UILabel alloc] initWithFrame:CGRectMake(6, height / 2 + 8, SCREEN_W / 3 * 2, height / 2 - 10)];
   NSString *contentStr = [self.memocontents.mem_datetime substringToIndex:10];
   NSString *contentStr2 = [self.memocontents.mem_content stringByAppendingString:@","];
   contentLab.text = [contentStr2 stringByAppendingString:contentStr];
   contentLab.font = [UIFont systemFontOfSize:16];
   contentLab.textColor = [UIColor colorWithRed:50.0f/255.0f green:50.0f/255.0f blue:50.0f/255.0f alpha:0.5];

    
    [self.contentView addSubview:timeLab];
    [self.contentView addSubview:contentLab];
    
    self.userInteractionEnabled = NO;
    
    
}

@end
