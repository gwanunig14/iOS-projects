//
//  DLAAppDelegate.m
//  DrawLines
//
//  Created by T.J. Mercer on 4/15/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "DLAAppDelegate.h"

#import "DLAViewController.h"

@implementation DLAAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.rootViewController = [[DLAViewController alloc]initWithNibName:nil bundle:nil];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}
@end
