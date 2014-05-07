//
//  BBASingleton.m
//  BrickBreaker
//
//  Created by T.J. Mercer on 5/6/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "BBAGameData.h"

@interface BBAGameData ()

@end

@implementation BBAGameData

+(BBAGameData *)mainData
{
    static dispatch_once_t create;
    static BBAGameData * singleton = nil;
    
    dispatch_once (&create  , ^{
        singleton = [[BBAGameData alloc]init];
    });

    return singleton;
}

-(void)addPoints:(int)points
{
    //    NSLog(@"%f", currentPoints);
    _currentpoints += points;
}

@end
