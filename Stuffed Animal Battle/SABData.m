//
//  SABData.m
//  Stuffed Animal Battle
//
//  Created by T.J. Mercer on 5/18/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SABData.h"

@implementation SABData

+(SABData *)mainData
{
    static dispatch_once_t create;
    static SABData * singleton=nil;
    
    dispatch_once (&create, ^{
        singleton = [[SABData alloc]init];
    });
    
    return singleton;
}

-(void)setPlayer2Life:(float)player2Life
{
    NSLog(@"set %f", self.player2Life);
    if (self.player2Life < 100)
    {
        [self.delegate lifeLost];
    }
}

@end
