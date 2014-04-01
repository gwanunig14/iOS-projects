//
//  CARBumper.m
//  Car
//
//  Created by T.J. Mercer on 4/1/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "CARBumper.h"

@implementation CARBumper

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor blackColor];
        self.layer.cornerRadius = 5;
    
    }
    return self;
}


@end
