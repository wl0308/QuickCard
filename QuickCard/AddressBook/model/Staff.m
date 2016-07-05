
//
//  Staff.m
//  QuickCard
//
//  Created by administrator on 10/13/15.
//  Copyright (c) 2015 administrator. All rights reserved.
//

#import "Staff.h"

@implementation Staff

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if(self = [super init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)staffWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}

@end
