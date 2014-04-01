//
//  CARWindow.m
//  Car
//
//  Created by T.J. Mercer on 4/1/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "CARWindow.h"

@implementation CARWindow

- (id)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor cyanColor];
        self.alpha = .4;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
