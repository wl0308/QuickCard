//
//  TakeOffUser.h
//  QuickCard
//
//  Created by xingxing on 11/2/15.
//  Copyright (c) 2015 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TakeOffUser : NSObject

@property (nonatomic, copy)NSString *abs_reason;
@property (nonatomic, copy)NSString *user_id;
@property (nonatomic, copy)NSString *abs_id;
@property (nonatomic, copy)NSString *user_name;
@property (nonatomic, copy)NSString *abs_starttime;
@property (nonatomic, copy)NSString *abs_endtime;
@property (nonatomic, copy)NSString *abs_type_type;


-(instancetype)initWithDictionary:(NSDictionary *)dict;
+(instancetype)takeOffUserWithDictionary:(NSDictionary *)dict;


@end
