//
//  DLAStage.m
//  DrawLines
//
//  Created by T.J. Mercer on 4/15/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "DLAStageLines.h"

@implementation DLAStageLines
{
    NSMutableArray *lines;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //keeps up with the lines by using the two points on the lines.
        lines = [@[] mutableCopy];
        
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();

    //empties the background so the background doesn't keep redrawing the background.
//    CGContextClearRect(context, rect);
    [self.scribbleColor set];
    CGContextSetLineWidth(context, self.scribbleSize);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    for (NSArray * line in lines)
    {
        
        //creates start and end as the two touched points.
        CGPoint start = [line[0] CGPointValue];
        CGPoint end = [line[1] CGPointValue];
    
        //adds the two points for the line to the dictionary.
        CGContextMoveToPoint(context, start.x, start.y);
        CGContextAddLineToPoint(context, end.x, end.y);
        
        //connects the dots with a line. fill path will fill space between lines.
        CGContextStrokePath(context);
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch * touch in touches)
    {
        CGPoint location = [touch locationInView:self];
        
        //adds the points for the two ends of the lines.
        [lines addObject:[@{
                                @"color":self.scribbleColor,
                                @"width":@(self.scribbleSize),
                                //array within an array keeps up with the changes to the points.
                                @"points" :[@[[NSValue valueWithCGPoint:location],
                                              [NSValue valueWithCGPoint:location]
                                              ]mutableCopy]
                                } mutableCopy]];
       
        NSLog(@"Touch X %f Y %f", location.x, location.y);
    }
    [self setNeedsDisplay];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch * touch in touches)
    {
        CGPoint location = [touch locationInView:self];
        
        //tells the second number in the last object on the array to move as you move it.
        [lines lastObject][@"points"][1] = [NSValue valueWithCGPoint:location];
        
        NSLog(@"Touch X %f Y %f", location.x, location.y);
    }
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch * touch in touches)
    {
        CGPoint location = [touch locationInView:self];
        [lines lastObject] [1] = [NSValue valueWithCGPoint:location];
        NSLog(@"Touch X %f Y %f", location.x, location.y);
    }
    [self setNeedsDisplay];
}

@end
