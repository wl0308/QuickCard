//
//  AllBarViewController.m
//  QuickCard
//
//  Created by administrator on 15/10/21.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "AllBarViewController.h"
#import "LoginVC.h"
#import "WorkSpaceViewController.h"
#import "PublicViewController.h"
#import "AddressBookTableVC.h"
#import "MyTableViewController.h"
@interface AllBarViewController ()

@end

@implementation AllBarViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSMutableArray *VCs = [NSMutableArray arrayWithCapacity:4];
    
   
    UIStoryboard *spaceWorkSB = [UIStoryboard storyboardWithName:@"WorkSpace" bundle:[NSBundle mainBundle]];
    UIStoryboard *publicSB = [UIStoryboard storyboardWithName:@"Public" bundle:[NSBundle mainBundle]];
    UIStoryboard *AddressBookSB = [UIStoryboard storyboardWithName:@"AddressBook" bundle:[NSBundle mainBundle]];
    UIStoryboard *MySB = [UIStoryboard storyboardWithName:@"Storyboard" bundle:[NSBundle mainBundle]];
    
   
    UINavigationController *workspaceVC = [spaceWorkSB instantiateViewControllerWithIdentifier:@"workspaceID"];
    UINavigationController *publicVC = [publicSB instantiateViewControllerWithIdentifier:@"publicID"];
    UINavigationController *addressBookVC = [AddressBookSB instantiateViewControllerWithIdentifier:@"addressBookID"];
    UINavigationController *myVC = [MySB instantiateViewControllerWithIdentifier:@"mytableID"];
                                 
    
    [VCs addObject:workspaceVC];
    [VCs addObject:publicVC];
    [VCs addObject:addressBookVC];
    [VCs addObject:myVC];
    
    [self setViewControllers:VCs animated:NO];
    
    NSArray *tabBarItemsArr = self.tabBar.items;
    
    
    UITabBarItem *item1 = [tabBarItemsArr objectAtIndex:0];
    item1.image = [[UIImage imageNamed:@"tabbar_discover"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item1.selectedImage = [[UIImage imageNamed:@"tabbar_discoverHL"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item1.title = @"工作台";
    
    UITabBarItem *item2 = [tabBarItemsArr objectAtIndex:1];
    item2.image = [[UIImage imageNamed:@"tabbar_mainframe"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.selectedImage = [[UIImage imageNamed:@"tabbar_mainframeHL"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.title = @"公告";
    
    UITabBarItem *item3 = [tabBarItemsArr objectAtIndex:2];
    item3.image = [[UIImage imageNamed:@"tabbar_contacts"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item3.selectedImage = [[UIImage imageNamed:@"tabbar_contactsHL"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item3.title = @"联系人";
    
    
    UITabBarItem *item4 = [tabBarItemsArr objectAtIndex:3];
    item4.image = [[UIImage imageNamed:@"tabbar_me"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item4.selectedImage = [[UIImage imageNamed:@"tabbar_meHL"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item4.title = @"我";
    
   //改变背景颜色
    
    UIView *view = [[UIView alloc] initWithFrame:self.tabBar.bounds];
    view.backgroundColor = [UIColor whiteColor];
    [self.tabBar insertSubview:view atIndex:0];
    self.tabBar.opaque = YES;
    
    
    
}




@end
