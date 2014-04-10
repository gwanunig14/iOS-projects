//
//  TDLAppDelegate.m
//  Todo2
//
//  Created by T.J. Mercer on 4/8/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "TDLAppDelegate.h"
#import "TableViewController.h"

@implementation TDLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    self.window.rootViewController = [[TableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    self.window.backgroundColor = [UIColor whiteColor];

    [self.window makeKeyAndVisible];
    return YES;
}

@end
