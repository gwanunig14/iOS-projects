//
//  DLAStageScribble.m
//  DrawLines
//
//  Created by T.J. Mercer on 4/15/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "DLAStageScribble.h"

@implementation DLAStageScribble
{
    NSMutableArray * scribbles;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        scribbles = [@[] mutableCopy];
        self.scribbleSize = 2.0;
        self.scribbleColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor blackColor];
    }

    return self;
}

//uislider that changes line width
//three buttons for three colors
//overwrite setters
//self set needs display after each selection

- (void)drawRect:(CGRect)rect
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextClearRect(context, rect);
    
    CGContextSetLineWidth(context, self.scribbleSize);
    [self.scribbleColor set];
    
    for (NSDictionary * scribble in scribbles)
    {
        CGContextSetLineWidth(context, [scribble[@"width"] floatValue]);
        [(UIColor *)scribble[@"color"] set];
        NSArray * points = scribble[@"points"];
        
        CGPoint start = [points [0] CGPointValue];
        CGContextMoveToPoint(context, start.x, start.y);
        
        for (NSValue * value in points)
        {
            // assigns a number to the points.
//            int index = [scribble indexOfObject:value];
            //sets point to the value of each points position
            CGPoint point = [value CGPointValue];
            //adds a line betwixt each new point.
//            if (index> 0)
            CGContextAddLineToPoint(context, point.x, point.y);
        }
        CGContextStrokePath(context);
    }
}

- (void)setScribbleColor:(UIColor *)scribbleColor
{
    _scribbleColor = scribbleColor;
    [self setNeedsDisplay];
}

-(void)setScribbleSize:(float)scribbleSize
{
    _scribbleSize = scribbleSize;
    [self setNeedsDisplay];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch * touch in touches)
    {
        CGPoint location =  [touch locationInView:self];
        
        [scribbles addObject:[@{
                                @"color":self.scribbleColor,
                                @"width":@(self.scribbleSize),
                                //array within an array keeps up with the changes to the points.
                                @"points" :[@[[NSValue valueWithCGPoint:location],                                              
                                              ]mutableCopy]
                                } mutableCopy]];
    }
    [self setNeedsDisplay];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch * touch in touches)
    {
        CGPoint location =  [touch locationInView:self];
//        add a new point for every logged point when you move your finger
//        [[scribbles lastObject] addObject:[NSValue valueWithCGPoint:location]];
        [[scribbles lastObject][@"points"] addObject:[NSValue valueWithCGPoint:location]];
    }
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch * touch in touches)
    {
        CGPoint location =  [touch locationInView:self];
        [[scribbles lastObject][@"points"]addObject:[NSValue valueWithCGPoint:location]];
    }
    [self setNeedsDisplay];
}

@end
