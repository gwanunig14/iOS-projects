//
//  PNAViewController.m
//  PixelNoise
//
//  Created by Heidi Proske on 5/5/14.
//  Copyright (c) 2014 Heidi Proske. All rights reserved.
//

#import "PNAViewController.h"

#import "PNAPixelSounds.h"

#import "WorldView.h"

@interface PNAViewController ()

@end

@implementation PNAViewController
{
    PNAPixelSounds * sounds;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        sounds = [[PNAPixelSounds alloc]init];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    WorldView * soundWorld = [[WorldView alloc]init];
    
    [self.view addSubview:soundWorld.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden { return YES; }

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"Play Sound");
    [sounds playSoundWithName:@"click_alert"];
}

@end
