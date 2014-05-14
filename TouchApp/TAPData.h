//
//  TAPData.h
//  TouchApp
//
//  Created by T.J. Mercer on 5/7/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TAPData : NSObject

+(TAPData *)colorData;

@property (nonatomic) NSInteger blueScore;
@property (nonatomic) NSInteger redScore;
@property (nonatomic) NSInteger allScores;

@end
