//
//  orderDepartmentNotices.h
//  QuickCard
//
//  Created by administrator on 15/10/11.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface orderDepartmentNotices : NSObject

@property (nonatomic,assign) int not_id;
@property (nonatomic,copy) NSString *not_title;
@property (nonatomic,copy) NSString *not_contnent;
@property (nonatomic,copy) NSString *not_date;
@property (nonatomic,copy) NSString *not_time; 

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)OrderDepartmentNoticesWithDict:(NSDictionary *)dict;

@end
