//
//  Notification.m
//  QuickCard
//
//  Created by administrator on 15/10/11.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "Notification.h"

@implementation Notification

- (instancetype)initWithDict:(NSDictionary *)dict {

    if (self == [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
    
}

+ (instancetype)NotificationWithDict:(NSDictionary *)dict {

    return [[super alloc] initWithDict:dict];
    
}

@end
