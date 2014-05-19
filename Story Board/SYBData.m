//
//  SYBData.m
//  Story Board
//
//  Created by T.J. Mercer on 5/16/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SYBData.h"

@implementation SYBData
{
    NSMutableArray * projects;
}

+(SYBData *)mainData
{
    static dispatch_once_t create;
    static SYBData * singleton=nil;
    
    dispatch_once (&create, ^{
        singleton = [[SYBData alloc]init];
    });
    
    return singleton;
}

-(id)init
{
    self = [super init];
    if (self)
    {
        projects = [@[@{@"title": @"Gods and Men"},
                      @{@"title": @"SteamPunk"}
                      ]mutableCopy];
    }
    return self;
}

-(void)addNewProject:(NSMutableDictionary *)project
{
    [projects addObject:project];
}

-(NSArray *)allProjects
{
    return [projects copy];
}

@end
