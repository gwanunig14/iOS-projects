//
//  TAPData.m
//  TouchApp
//
//  Created by T.J. Mercer on 5/7/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "TAPData.h"

@implementation TAPData

+(TAPData *)colorData
{
    static dispatch_once_t create;
    static TAPData * singleton = nil;
    
    dispatch_once(&create, ^{
        singleton = [[TAPData alloc]init];
    });
    
    return singleton;
}

-(NSInteger)allScores
{
    _allScores = (self.redScore) + (self.blueScore);
    
    return _allScores;
}

@end
