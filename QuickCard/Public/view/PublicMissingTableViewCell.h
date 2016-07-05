//
//  PublicMissingTableViewCell.h
//  QuickCard
//
//  Created by administrator on 15/11/5.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublicContnent.h"
@interface PublicMissingTableViewCell : UITableViewCell
@property(nonatomic,strong)NSMutableArray *notArr;
@property(nonatomic,strong)PublicContnent *publicContnent;
-(void)publicMissingTableViewCellShow;
@end
