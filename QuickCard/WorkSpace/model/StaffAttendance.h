//
//  StaffAttendance.h
//  QuickCard
//
//  Created by Destiny on 15/10/20.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StaffAttendance : NSObject

@property (nonatomic, copy)NSString *user_img;
@property (nonatomic, copy)NSString *user_name;
@property (nonatomic, copy)NSString *user_time1;
@property (nonatomic, copy)NSString *user_time2;
@property (nonatomic, copy)NSString *fie_destination;
@property (nonatomic, copy)NSString *fie_time1;
@property (nonatomic, copy)NSString *fie_time2;


-(instancetype)initWithDictionary:(NSDictionary *)dict;
+(instancetype)StaffAttendanceWithDictionary:(NSDictionary *)dict;

@end
