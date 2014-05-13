//
//  ALAPlaylist.h
//  AudioList
//
//  Created by T.J. Mercer on 5/12/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "ALADictionary.h"

@interface ALAPlaylist : ALADictionary

+(id)newPlaylist;

@property (nonatomic) NSMutableArray * tracks;

@end
