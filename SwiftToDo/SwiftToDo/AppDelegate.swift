//
//  AppDelegate.swift
//  SwiftToDo
//
//  Created by T.J. Mercer on 6/12/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        var rootVC = RootViewController()
        var navC = UINavigationController(rootViewController: rootVC)
        
        self.window!.rootViewController = navC
        // Override point for customization after application launch.
        self.window!.backgroundColor = UIColor.whiteColor()
        self.window!.makeKeyAndVisible()
        return true
    }

}

