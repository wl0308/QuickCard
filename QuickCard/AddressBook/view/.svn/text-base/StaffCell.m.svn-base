//
//  StaffCell.m
//  QuickCard
//
//  Created by administrator on 10/14/15.
//  Copyright (c) 2015 administrator. All rights reserved.
//

#import "StaffCell.h"
#import "Staff.h"
#import "Department.h"
#import "AFNetworking.h"
#import "ChineseString.h"
@interface StaffCell()

@property(nonatomic,retain)NSMutableArray *indexArray;
@property(nonatomic,retain)NSMutableArray *LetterResultArr;

@end

@implementation StaffCell

@synthesize indexArray;
@synthesize LetterResultArr;

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellID = @"staffCell";
    StaffCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[StaffCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

- (void)setStaffData:(Staff *)staffData
{
    _staffData = staffData;
    
    self.textLabel.text = staffData.user_name;
    self.textLabel.font = [UIFont systemFontOfSize:13];
    
    self.detailTextLabel.text = staffData.user_mobile;
    self.detailTextLabel.font = [UIFont systemFontOfSize:13];
    //对通讯录进行排序
    NSArray *stringsToSort = [NSArray arrayWithObjects:staffData.user_name, nil];
    self.indexArray = [ChineseString IndexArray:stringsToSort];
    self.LetterResultArr = [ChineseString LetterSortArray:stringsToSort];
    
}

@end
