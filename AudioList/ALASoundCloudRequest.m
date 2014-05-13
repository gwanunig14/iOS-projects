//
//  ALASoundCloudRequest.m
//  AudioList
//
//  Created by T.J. Mercer on 5/10/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#define CLIENT_ID @"client_id=be7a3bde02983f2430f1ba394011db5e"

#define USER_NAME @"gwanunig14"

#define SC_API @"https://api.soundcloud.com"

#import "ALASoundCloudRequest.h"

#import "ALAData.h"

@implementation ALASoundCloudRequest

+(void)updateData
{
    NSURL * requestURL = [NSURL URLWithString:[NSString stringWithFormat: @"%@/users/%@/playlists.json?%@",SC_API,USER_NAME,CLIENT_ID]];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:requestURL];
    
    NSOperationQueue * queue= [[NSOperationQueue alloc]init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSArray *scInfo = [NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        
        NSLog(@"%@",scInfo);
        
        for (NSDictionary * playlistInfo in scInfo)
        {
            NSLog(@"PLAYLIST %@",playlistInfo);
            
            //create a new plalist and set things like playlist title
            
            ALAPlaylist * playlist = [ALAPlaylist newPlaylist];
            playlist[@"title"] = playlistInfo[@"title"];
            [[ALAData mainData] addNewPlaylist:playlist];
            
            for (NSDictionary * trackInfo in playlistInfo[@"tracks"])
            {
                ALATrack * track = [ALATrack newTrack];
                track.playlist = playlist;

                if (!trackInfo[@"streamable"]) continue;
                
                track[@"title"] = trackInfo[@"title"];
                track[@"url"] = trackInfo[@"stream_url"];
                
                [playlist.tracks addObject:track];
                
                ALAUser * user = [ALAUser newUser];
                user[@"name"] = trackInfo[@"user"][@"username"];
                track.user = user;
                [[ALAData mainData] addNewUser:user];
                [[ALAData mainData] addNewTrack:track];
                
                NSLog(@"here is the playlists%@",track.playlist);
                NSLog(@"here is the user%@",track.user);
            }
        }
        
        NSNotificationCenter * nCenter = [NSNotificationCenter defaultCenter];
        
        [nCenter postNotificationName:@"dataUpdated" object:nil];
        
    }];
}

@end
