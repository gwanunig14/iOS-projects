//
//  CARWheel.m
//  Car
//
//  Created by T.J. Mercer on 4/1/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "CARWheel.h"

@implementation CARWheel

- (id)init
{
    self = [super init];
    if (self)
    {
        self.tirePressure = 30;
        
        self.flat = NO;
        
        self.backgroundColor = [UIColor darkGrayColor];
        self.layer.cornerRadius = 10;
        
    }
    return self;
}

@end
