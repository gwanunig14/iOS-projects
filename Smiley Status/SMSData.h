//
//  SMSData.h
//  Smiley Status
//
//  Created by T.J. Mercer on 5/19/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMSData : NSObject

+(SMSData *)mainData;

@property (nonatomic) NSArray * colors;

@property (nonatomic) NSArray * bigSmileys;

@property (nonatomic) NSArray * littleSmileys;

@end
