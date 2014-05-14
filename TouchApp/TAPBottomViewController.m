//
//  TAPBottomViewController.m
//  TouchApp
//
//  Created by T.J. Mercer on 5/7/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "TAPBottomViewController.h"

#import "TAPData.h"

@interface TAPBottomViewController ()

@end

@implementation TAPBottomViewController

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [TAPData colorData].redScore = [TAPData colorData].redScore +1;
    NSLog(@"Red %d",[TAPData colorData].redScore);
    NSLog(@"Total %d",[TAPData colorData].allScores);
    [self.delegate updateRedScore:[TAPData colorData].redScore andBlueScore:[TAPData colorData].blueScore];
}

@end
