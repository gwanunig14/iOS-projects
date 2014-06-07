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

@property (nonatomic) NSMutableArray * albumsForLater;
@property (nonatomic) NSMutableArray * unRated;

@end
