//
//  departmentTableViewController.h
//  QuickCard
//
//  Created by administrator on 15/10/10.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface departmentTableViewController : UITableViewController

@property (nonatomic,copy) NSString *dep_department;
@property (nonatomic,strong) UIRefreshControl *refresh;

@end
