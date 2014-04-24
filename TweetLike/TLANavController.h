//
//  TLANavController.h
//  TweetLike
//
//  Created by T.J. Mercer on 4/23/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLATableViewController;

@interface TLANavController : UINavigationController

-(void)addTableViewController:(TLATableViewController *)viewController;

@end
