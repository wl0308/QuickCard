//
//  CalendarView.h
//  QuickCard
//
//  Created by Destiny on 15/10/19.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CalendarDelegate;
@protocol CalendarDataSource;

@interface CalendarView : UIView

- (void)showNextMonth;
- (void)showPreviousMonth;


@property (nonatomic, strong) NSDate *calendarDate;
@property (nonatomic, weak) id<CalendarDelegate> delegate;
@property (nonatomic, weak) id<CalendarDataSource> datasource;


@property (nonatomic, assign) NSInteger originX;
@property (nonatomic, assign) NSInteger originY;

//改变月时的动画
@property (nonatomic, assign) UIViewAnimationOptions nextMonthAnimation;
@property (nonatomic, assign) UIViewAnimationOptions prevMonthAnimation;

@end



@protocol CalendarDelegate <NSObject>

-(void)dayChangedToDate:(NSDate *)selectedDate;

@optional

-(void)setHeightNeeded:(NSInteger)heightNeeded;
-(void)setMonthLabel:(NSString *)monthLabel;
-(void)setEnabledForPrevMonthButton:(BOOL)enablePrev nextMonthButton:(BOOL)enableNext;

@end



@protocol CalendarDataSource <NSObject>

-(BOOL)isDataForDate:(NSDate *)date;
-(BOOL)canSwipeToDate:(NSDate *)date;

@end
