//
//  EXPTableViewController.h
//  Experiment
//
//  Created by T.J. Mercer on 6/9/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EXPTableDelegate;

@interface EXPTableViewController : UITableViewController

@property (nonatomic, assign)id<EXPTableDelegate> delegate;

@end

@protocol EXPTableDelegate <NSObject>

-(void)populateWithArray:(NSMutableArray *)list;

@end
