//
//  OrderTableViewCell.h
//  QuickCard
//
//  Created by administrator on 15/10/11.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "orderInfos.h"

@interface OrderTableViewCell : UITableViewCell

@property (nonatomic,strong) orderInfos *orders;

- (void)infosShow:(CGFloat)height;

@end
