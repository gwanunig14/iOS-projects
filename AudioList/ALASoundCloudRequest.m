//
//  ALASoundCloudRequest.m
//  AudioList
//
//  Created by T.J. Mercer on 5/10/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#define CLIENT_ID @"be7a3bde02983f2430f1ba394011db5e"

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
        
        for (NSDictionary * playlist in scInfo)
        {
            //create a new plalist and set things like playlist title
            
            for (NSDictionary * trackInfo in playlist[@"tracks"])
            {
                if (!trackInfo[@"streamable"]) continue;
                ALATrack * track = [ALATrack newTrack];
                track[@"title"] = trackInfo[@"title"];
                track[@"url"] = trackInfo[@"stream_url"];
                
                [[ALAData mainData] addNewTrack:track];
            }
        }
        
        NSLog(@"%@",[[ALAData mainData] allTracks]);
    }];
}

@end
