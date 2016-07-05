//
//  PopCircle.h
//  QuickCard
//
//  Created by administrator on 15/10/13.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ClockSettingViewController.h"

@interface PopCircle : UIView<PassTagDetegate> {

}

@property (nonatomic,strong) UIDatePicker *DP;
@property (nonatomic,strong) NSString *nowTime;
@property (nonatomic,assign)int tag;



@end
