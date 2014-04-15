//
//  SCGCircle.m
//  Squares
//
//  Created by T.J. Mercer on 4/11/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SCGCircle.h"

@implementation SCGCircle
{
    UIColor * dotColor;
    float dotWidth;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        dotColor = [UIColor blackColor];
        
        dotWidth = frame.size.width/2;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    float dotXY = (self.frame.size.width - dotWidth) / 2;
    
    CGContextAddEllipseInRect(context, CGRectMake(dotXY, dotXY, dotWidth, dotWidth));
    
    [dotColor set];
    
    CGContextFillPath(context);
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
//    asks for color from V while giving position of tapped circle
    dotColor = [self.delegate circleTappedWithPosition:self.position];
    
//    redraws layer with the -drawRect method above
    [self setNeedsDisplay];
    
    NSLog(@"my postion is col %d, row %d", (int)self.position.x,(int)self.position.y);
}

@end
