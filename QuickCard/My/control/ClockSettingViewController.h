//
//  ClockSettingViewController.h
//  QuickCard
//
//  Created by administrator on 15/10/13.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol PassTagDetegate

- (void)passTag:(int)tag;

@end

@interface ClockSettingViewController : UIViewController 
@property (nonatomic,assign) float height;
@property (retain,nonatomic) id<PassTagDetegate> passDelegate;



@end
