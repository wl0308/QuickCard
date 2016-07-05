//
//  StaffAttendance.m
//  QuickCard
//
//  Created by Destiny on 15/10/20.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "StaffAttendance.h"

@implementation StaffAttendance
-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    if(self = [super init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)StaffAttendanceWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
    
}
@end
