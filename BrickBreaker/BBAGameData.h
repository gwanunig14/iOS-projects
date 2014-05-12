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

+(BBAGameData *)mainData;

@property (nonatomic, readonly) NSInteger topScore;

@property (nonatomic) NSInteger currentScore;

-(NSArray *)gameScores;

@end
