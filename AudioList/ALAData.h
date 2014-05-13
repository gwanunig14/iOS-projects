//
//  ALAData.h
//  AudioList
//
//  Created by T.J. Mercer on 5/8/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ALATrack.h"
#import "ALAUser.h"
#import "ALAPlaylist.h"

@interface ALAData : NSObject

+(ALAData *)mainData;

-(void)addNewTrack:(ALATrack *)track;
-(NSArray *)allTracks;

-(void)addNewUser:(ALAUser *)user;
-(NSArray *)allUsers;

-(void)addNewPlaylist:(ALAPlaylist *)playlist;
-(NSArray *)allPlaylists;

@end
