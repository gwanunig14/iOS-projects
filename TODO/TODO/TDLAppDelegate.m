//
//  TDLAppDelegate.m
//  TODO
//
//  Created by T.J. Mercer on 4/2/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "TDLAppDelegate.h"

#import "TDLTableViewController.h"

@implementation TDLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    TDLTableViewController * rootViewController = [[TDLTableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    UINavigationController * navController = [[UINavigationController alloc]initWithRootViewController:rootViewController];

    self.window.rootViewController = navController;
    
    self.window.backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];
    return YES;

}



@end
