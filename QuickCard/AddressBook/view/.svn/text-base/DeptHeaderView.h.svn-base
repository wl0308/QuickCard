//
//  DeptHeaderView.h
//  QuickCard
//
//  Created by administrator on 10/14/15.
//  Copyright (c) 2015 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Department, DeptHeaderView ;

/**
 *  需要遵循的协议
 */
@protocol deptHeaderViewDelegate <NSObject>
@optional
- (void)deptHeaderViewDidClickedNameView;
@end

@interface DeptHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) Department *dept;
@property (nonatomic, weak) id<deptHeaderViewDelegate> delegate;

+ (id)deptHeaderViewWithTableView:(UITableView *)tableView;


@end






