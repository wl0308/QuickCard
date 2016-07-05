//
//  AppDelegate.m
//  QuickCard
//
//  Created by administrator on 15/10/9.
//  Copyright (c) 2015年 administrator. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginVC.h"
#import "AllBarViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
 
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *user_id = [user valueForKey:@"user_id"];
    
    if (user_id == nil) {
        
//        UIStoryboard *loginSB = [UIStoryboard storyboardWithName:@"Login" bundle:[NSBundle mainBundle]];
//        UINavigationController *loginVC = [loginSB instantiateViewControllerWithIdentifier:@"loginID"];
//        self.window.rootViewController = loginVC;
        
        AllBarViewController *allBarVC = [AllBarViewController new];
        self.window.rootViewController = allBarVC;

        
    }
    
    else if (user_id != nil) {
    
        AllBarViewController *allBarVC = [AllBarViewController new];
        self.window.rootViewController = allBarVC;
        
    }
  
   return YES;
    
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {

    for (UILocalNotification *noti in [[UIApplication sharedApplication] scheduledLocalNotifications]) {
        
        if ([[noti.userInfo valueForKey:@"someKey"] isEqualToString:[notification.userInfo valueForKey:@"someKey"]]) {
            
            [[UIApplication sharedApplication] cancelLocalNotification:notification];
        }
        
    }
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
