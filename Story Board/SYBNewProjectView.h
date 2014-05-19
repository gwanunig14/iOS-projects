//
//  SYBNewProjectView.h
//  Story Board
//
//  Created by T.J. Mercer on 5/16/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SYBNewProjectViewDelegate;

@interface SYBNewProjectView : UIViewController

@property (nonatomic,assign) id<SYBNewProjectViewDelegate> delegate;

-(void)addSubviews;

@end

@protocol SYBNewProjectViewDelegate <NSObject>

-(void)newProjectAdded;

@end
