//
//  MyTakeOffTableViewCell.h
//  QuickCard
//
//  Created by administrator on 15/11/7.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTakeOff.h"
@interface MyTakeOffTableViewCell : UITableViewCell
@property(nonatomic,strong)MyTakeOff * myTakeOff;
@property(nonatomic,strong)NSString * user_name;
-(void)myTakeOffShow;
@end
