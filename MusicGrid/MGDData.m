//
//  MGDData.m
//  MusicGrid
//
//  Created by T.J. Mercer on 6/7/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "MGDData.h"

@implementation MGDData

+(MGDData *)mainData
{
    static dispatch_once_t create;
    static MGDData * singleton=nil;
    
    dispatch_once (&create, ^{
        singleton = [[MGDData alloc]init];
    });
    
    return singleton;
}

-(id)init
{
    self = [super init];
    if (self)
    {
        self.albumsForLater = [@{}mutableCopy];
        self.unRated = [@{}mutableCopy];
        self.ratedAlbums = [@{}mutableCopy];
        self.used = @{};
        self.startUp = [@{@"u2":@{@"cover": [UIImage imageNamed:@"joshuatree"]},
                          @"daft punk":@{@"cover": [UIImage imageNamed:@"Daftpunk"]},
                          @"Guy Clark":@{@"cover": [UIImage imageNamed:@"guyclark"]}}mutableCopy];
        self.token = @"";
    }
    return self;
}

@end
