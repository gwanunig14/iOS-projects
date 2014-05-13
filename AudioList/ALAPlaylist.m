//
//  ALAPlaylist.m
//  AudioList
//
//  Created by T.J. Mercer on 5/12/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "ALAPlaylist.h"

@implementation ALAPlaylist

+(id)newPlaylist
{
    return [[ALAPlaylist alloc]init];
}

-(NSMutableArray *)tracks
{
    if (_tracks == nil) _tracks = [@[] mutableCopy];
    return _tracks;
}

@end
