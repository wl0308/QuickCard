//
//  MyTakeOff.h
//  QuickCard
//
//  Created by administrator on 15/11/7.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyTakeOff : NSObject

@property (nonatomic, copy)NSString *abs_reason;
@property (nonatomic, copy)NSString *user_id;
@property (nonatomic, copy)NSString *abs_id;
@property (nonatomic, copy)NSString *abs_starttime;
@property (nonatomic, copy)NSString *abs_endtime;
@property (nonatomic, copy)NSString *abs_type_type;

-(instancetype)initWithDictionary:(NSDictionary *)dict;
+(instancetype)MytakeOffWithDictionary:(NSDictionary *)dict;
@end
