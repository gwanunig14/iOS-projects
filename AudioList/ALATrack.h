//
//  ALASong.h
//  AudioList
//
//  Created by T.J. Mercer on 5/10/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ALADictionary.h"

@class ALAUser;
@class ALAPlaylist;

@interface ALATrack : ALADictionary

+(id)newTrack;

@property (nonatomic) ALAUser * user;
@property (nonatomic) ALAPlaylist * playlist;

@end
