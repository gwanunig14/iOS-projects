//
//  TAPTopViewController.h
//  TouchApp
//
//  Created by T.J. Mercer on 5/7/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TAPTopViewControllerDelegate;

@interface TAPTopViewController : UIViewController

@property (nonatomic,assign) id<TAPTopViewControllerDelegate> delegate;

@end

@protocol TAPTopViewControllerDelegate <NSObject>

-(void)updateRedScore:(NSInteger)redScore andBlueScore:(NSInteger)blueScore;

@end
