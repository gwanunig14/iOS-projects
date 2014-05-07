//
//  BBASingleton.h
//  BrickBreaker
//
//  Created by T.J. Mercer on 5/6/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BBAGameData.h"

@interface BBAGameData : NSObject

@property (nonatomic) float currentpoints;

+(BBAGameData *)mainData;

-(void)addPoints:(int)points;

@end
