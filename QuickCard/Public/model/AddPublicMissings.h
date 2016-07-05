//
//  AddPublicMissings.h
//  QuickCard
//
//  Created by administrator on 15/10/16.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddPublicMissings : NSObject
@property(nonatomic,assign)int pub_id;
@property(nonatomic,copy)NSString * not_contnent;
@property(nonatomic,copy)NSString * dep_department;
@property(nonatomic,copy)NSString * not_title;
-(instancetype)initWithDictionary:(NSDictionary *)dict;
+(instancetype)AddPublicMissingsWithDictionary:(NSDictionary *)dict;
@end
