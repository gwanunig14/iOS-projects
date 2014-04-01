//
//  TJFAppDelegate.m
//  Day2 Class
//
//  Created by T.J. Mercer on 4/1/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "TJFAppDelegate.h"

#import "TJFRootViewController.h"

@implementation TJFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.rootViewController = [[TJFRootViewController alloc] init];
    
    self.window.backgroundColor = [UIColor blueColor];
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
