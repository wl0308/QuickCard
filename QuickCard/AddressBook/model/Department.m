//
//  Department.m
//  QuickCard
//
//  Created by administrator on 10/13/15.
//  Copyright (c) 2015 administrator. All rights reserved.
//

#import "Department.h"
#import "Staff.h"

@implementation Department

+ (instancetype)departmentWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        
        //取staff对象，添加到部门的staffs数组中
        NSMutableArray *staffArr = [NSMutableArray array];
        
        for (NSDictionary *dict in self.users)
        {
            Staff *staffDict = [Staff staffWithDict:dict];
            [staffArr addObject:staffDict];
        }
        self.users = staffArr;
    }
    return self;
}

@end
