//
//  ALAiPadDataView.h
//  AudioList
//
//  Created by T.J. Mercer on 5/8/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ALAiPadDataView : UIViewController

@property (nonatomic) NSInteger index;

@property (nonatomic, strong) AVAudioPlayer *player;

@end
