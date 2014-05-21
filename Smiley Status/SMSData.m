//
//  SMSData.m
//  Smiley Status
//
//  Created by T.J. Mercer on 5/19/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SMSData.h"

@implementation SMSData
{
    NSArray * bigYellowSmileys;
    
    NSArray * littleYellowSmileys;
    NSArray * littleRedSmileys;
}

+(SMSData *)mainData
{
    static dispatch_once_t create;
    static SMSData * singleton=nil;
    
    dispatch_once (&create, ^{
        singleton = [[SMSData alloc]init];
    });
    
    return singleton;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.colors = @[@"colors_1",
                        @"colors_2",
                        @"colors_3",
                        @"colors_4",
                        @"colors_5",
                        @"colors_6",
                        @"colors_7",
                        @"colors_8",
                        @"colors_9"];
        
        bigYellowSmileys = @[@"yellow_1",
                             @"yellow_2",
                             @"yellow_3",
                             @"yellow_4",
                             @"yellow_5",
                             @"yellow_6",
                             @"yellow_7",
                             @"yellow_8",
                             @"yellow_9"];
        
        littleYellowSmileys = @[@"smilies_1",
                          @"smilies_2",
                          @"smilies_3",
                          @"smilies_4",
                          @"smilies_5",
                          @"smilies_6",
                          @"smilies_7",
                          @"smilies_8",
                          @"smilies_9"];
        
        littleRedSmileys = @[@"angry_1",
                       @"angry_2",
                       @"angry_3",
                       @"angry_4",
                       @"angry_5",
                       @"angry_6",
                       @"angry_7",
                       @"angry_8",
                       @"angry_9"];
        
        self.bigSmileys = @[bigYellowSmileys,
                            bigYellowSmileys,
                            bigYellowSmileys,
                            bigYellowSmileys,
                            bigYellowSmileys,
                            bigYellowSmileys,
                            bigYellowSmileys,
                            bigYellowSmileys,
                            bigYellowSmileys];
        
        self.littleSmileys = @[littleYellowSmileys,
                               littleRedSmileys,
                               littleYellowSmileys,
                               littleYellowSmileys,
                               littleYellowSmileys,
                               littleYellowSmileys,
                               littleYellowSmileys,
                               littleYellowSmileys,
                               littleYellowSmileys];
        
        
    }
    return self;
}

@end
