//
//  PNAPixelSounds.h
//  PixelNoise
//
//  Created by Heidi Proske on 5/5/14.
//  Copyright (c) 2014 Heidi Proske. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface PNAPixelSounds : NSObject <AVAudioPlayerDelegate>

@property (nonatomic, strong) AVAudioPlayer *player;
//@property (nonatomic) NSMutableArray* players;

-(void)playSoundWithName:(NSString*)soundName;

@end
