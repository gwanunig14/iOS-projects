//
//  LOTAppDelegate.m
//  LotsOfTabs
//
//  Created by T.J. Mercer on 5/13/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "LOTAppDelegate.h"

@implementation LOTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    ////// version 1 : uitabbarcontroller
    
    UITabBarController * tbc = [[UITabBarController alloc]init];
    UITableViewController * tvc = [[UITableViewController alloc]init];
    UIViewController * vc = [[UIViewController alloc]init];
    
    [tbc setViewControllers:@[tvc,vc] animated:YES];
    
    tvc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"tvc" image:nil tag:0];
    vc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"vc" image:nil tag:1];
    
//    self.window.rootViewController = tbc;
    
    ////// version 2 : uitoolbar in uinavigation controller
    
    UINavigationController * nc = [[UINavigationController alloc]init];
    
    nc.toolbarHidden = NO;
    
    UIBarButtonItem * button1 = [[UIBarButtonItem alloc]initWithTitle:@"Tracks" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    UIBarButtonItem * button2 = [[UIBarButtonItem alloc]initWithTitle:@"Playlists" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    UIBarButtonItem * flexible = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    [nc.toolbar setItems:@[flexible, button1, flexible, button2, flexible] animated:YES];
    
    self.window.rootViewController = nc;
    
    
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
