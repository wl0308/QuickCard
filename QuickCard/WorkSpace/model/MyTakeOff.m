//
//  MyTakeOff.m
//  QuickCard
//
//  Created by administrator on 15/11/7.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "MyTakeOff.h"

@implementation MyTakeOff
-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    if(self = [super init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)MytakeOffWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}
@end
