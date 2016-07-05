//
//  memoTableViewCell.h
//  QuickCard
//
//  Created by administrator on 15/10/12.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "memoContents.h"

@interface memoTableViewCell : UITableViewCell

@property (nonatomic,strong) memoContents *memocontents;

- (void)memoShow:(CGFloat)height;

@end
