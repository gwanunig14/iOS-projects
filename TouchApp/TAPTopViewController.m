//
//  TAPTopViewController.m
//  TouchApp
//
//  Created by T.J. Mercer on 5/7/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "TAPTopViewController.h"



#import "TAPData.h"

@interface TAPTopViewController ()

@end

@implementation TAPTopViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor blueColor];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [TAPData colorData].blueScore=[TAPData colorData].blueScore+1;
    NSLog(@"Blue %d",[TAPData colorData].blueScore);
    NSLog(@"Total %d",[TAPData colorData].allScores);
    
    [self.delegate updateRedScore:[TAPData colorData].redScore andBlueScore:[TAPData colorData].blueScore];
}



@end
