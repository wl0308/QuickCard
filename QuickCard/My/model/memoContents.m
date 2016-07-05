//
//  memoContents.m
//  QuickCard
//
//  Created by administrator on 15/10/12.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "memoContents.h"

@implementation memoContents

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    if (self == [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
        
    }
    
    return self;
    
}

+ (instancetype)MemoContentsWithDict:(NSDictionary *)dict {
    
    return [[super alloc] initWithDict:dict];
    
}

@end
