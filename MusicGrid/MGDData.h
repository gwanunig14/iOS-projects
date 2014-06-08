//
//  MGDData.h
//  MusicGrid
//
//  Created by T.J. Mercer on 6/7/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGDData : NSObject

+(MGDData *)mainData;

@property (nonatomic) NSMutableDictionary * albumsForLater;
@property (nonatomic) NSMutableDictionary * unRated;
@property (nonatomic) NSMutableDictionary * ratedAlbums;
@property (nonatomic) NSDictionary * used;
@property (nonatomic) NSMutableDictionary * startUp;
@property (nonatomic) NSString * token;
@property (nonatomic) float requestCount;

@end
