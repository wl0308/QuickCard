//
//  orderInfos.m
//  QuickCard
//
//  Created by administrator on 15/10/10.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "orderInfos.h"

@implementation orderInfos

- (instancetype)initWithDict:(NSDictionary *)dict {

    if (self == [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
        
    }
    
    return self;
    
}
+ (instancetype)OrderInfosWithDict:(NSDictionary *)dict {

    return [[super alloc]initWithDict:dict];
}

@end
