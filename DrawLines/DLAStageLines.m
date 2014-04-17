//
//  DLAStage.m
//  DrawLines
//
//  Created by T.J. Mercer on 4/15/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "DLAStageLines.h"

@implementation DLAStageLines

-(void)doTouch:(NSSet *)touches
{
    UITouch * touch = [touches allObjects][0];
    CGPoint location = [touch locationInView:self];
    [self.lines lastObject][@"points"][1] = [NSValue valueWithCGPoint:location];
    NSLog(@"Touch X %f Y %f", location.x, location.y);
    [self setNeedsDisplay];
}

@end
