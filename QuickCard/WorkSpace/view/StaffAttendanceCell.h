//
//  StaffAttendanceCell.h
//  QuickCard
//
//  Created by Destiny on 15/10/20.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StaffAttendanceCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *user_name;
@property (weak, nonatomic) IBOutlet UILabel *user_clo_time1;
@property (weak, nonatomic) IBOutlet UILabel *user_clo_time2;
@property (weak, nonatomic) IBOutlet UIButton *user_fieldwork;

@end
