//
//  AppDelegate.m
//  AccountManager
//
//  Created by fengweiru on 2018/7/12.
//  Copyright © 2018年 fengweiru. All rights reserved.
//

#import "AppDelegate.h"
#import "HomePageViewController.h"
#import "PasswordInputViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) NSUserDefaults *user;

@end

@implementation AppDelegate

- (NSUserDefaults *)user
{
    if (!_user) {
        _user = [[NSUserDefaults alloc] initWithSuiteName:@"group.account1"];
    }
    return _user;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self initUserDefaultData];
    
    if ([[self.user objectForKey:@"passwordOpen"] boolValue]) {
        PasswordInputViewController *vc = [[PasswordInputViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        self.window.rootViewController = nav;
    } else {
        HomePageViewController *vc = [[HomePageViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        self.window.rootViewController = nav;
    }

    return YES;
}

- (void)initUserDefaultData
{
    if ([self.user objectForKey:@"passwordOpen"] == nil) {
        [self.user setObject:[NSNumber numberWithBool:false] forKey:@"passwordOpen"];
    }
    if ([self.user objectForKey:@"fingerprintOrFaceOpen"] == nil) {
        [self.user setObject:[NSNumber numberWithBool:false] forKey:@"fingerprintOrFaceOpen"];
    }
    if ([self.user objectForKey:@"passwordHidden"] == nil) {
        [self.user setObject:[NSNumber numberWithBool:false] forKey:@"passwordHidden"];
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.

}

@end
