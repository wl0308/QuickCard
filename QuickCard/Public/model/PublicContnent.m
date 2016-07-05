//
//  PublicContnent.m
//  QuickCard
//
//  Created by administrator on 15/10/16.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "PublicContnent.h"

@implementation PublicContnent
-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    if(self = [super init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)PublicContentWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
    
}
@end
