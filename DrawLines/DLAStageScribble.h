//
//  DLAStageScribble.h
//  DrawLines
//
//  Created by T.J. Mercer on 4/15/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLAStageScribble : UIView

@property (nonatomic) UIColor * scribbleColor;
@property (nonatomic) float scribbleSize;
@property (nonatomic) NSMutableArray * lines;

-(void)clearStage;
-(void)undoStage;

@end
