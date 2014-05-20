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
        self.colors = @[[UIImage imageNamed:@"colors_1"],
                        [UIImage imageNamed:@"colors_2"],
                        [UIImage imageNamed:@"colors_3"],
                        [UIImage imageNamed:@"colors_4"],
                        [UIImage imageNamed:@"colors_5"],
                        [UIImage imageNamed:@"colors_6"],
                        [UIImage imageNamed:@"colors_7"],
                        [UIImage imageNamed:@"colors_8"],
                        [UIImage imageNamed:@"colors_9"]];
        
        bigYellowSmileys = @[[UIImage imageNamed:@"yellow_1"],
                             [UIImage imageNamed:@"yellow_2"],
                             [UIImage imageNamed:@"yellow_3"],
                             [UIImage imageNamed:@"yellow_4"],
                             [UIImage imageNamed:@"yellow_5"],
                             [UIImage imageNamed:@"yellow_6"],
                             [UIImage imageNamed:@"yellow_7"],
                             [UIImage imageNamed:@"yellow_8"],
                             [UIImage imageNamed:@"yellow_9"]];
        
        littleYellowSmileys = @[[UIImage imageNamed:@"smilies_1"],
                          [UIImage imageNamed:@"smilies_2"],
                          [UIImage imageNamed:@"smilies_3"],
                          [UIImage imageNamed:@"smilies_4"],
                          [UIImage imageNamed:@"smilies_5"],
                          [UIImage imageNamed:@"smilies_6"],
                          [UIImage imageNamed:@"smilies_7"],
                          [UIImage imageNamed:@"smilies_8"],
                          [UIImage imageNamed:@"smilies_9"]];
        
        littleRedSmileys = @[[UIImage imageNamed:@"angry_1"],
                       [UIImage imageNamed:@"angry_2"],
                       [UIImage imageNamed:@"angry_3"],
                       [UIImage imageNamed:@"angry_4"],
                       [UIImage imageNamed:@"angry_5"],
                       [UIImage imageNamed:@"angry_6"],
                       [UIImage imageNamed:@"angry_7"],
                       [UIImage imageNamed:@"angry_8"],
                       [UIImage imageNamed:@"angry_9"]];
        
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
