//
//  LPAViewController.m
//  LilPlayA
//
//  Created by T.J. Mercer on 5/13/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "LPAViewController.h"

#import <AVFoundation/AVFoundation.h>

@interface LPAViewController ()

@end

@implementation LPAViewController
{
    AVAudioPlayer * player;
    UIView * progressDot;
    UIView * progressBar;
    UISlider * volume;
    NSTimer * timer;
    UIButton * playButton;
    UIButton * pauseButton;
    int xpoint;
    int ypoint;
    float playTime;
    float length;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
//        if (error != nil) {
//            NSLog(@"%@", error);
//        }
        
        int w = [UIScreen mainScreen].bounds.size.width;
        int h = [UIScreen mainScreen].bounds.size.height;
        
        playButton = [[UIButton alloc]initWithFrame:CGRectMake(10, (h-50)/2, 50, 50)];
        playButton.layer.cornerRadius = playButton.frame.size.width/2;
        playButton.backgroundColor = [UIColor greenColor];
        [playButton setTitle:@"PLAY" forState:UIControlStateNormal];
//        [playButton setImage: [UIImage imageNamed:@"button-play.png"] forState:UIControlStateNormal];
        [self.view addSubview:playButton];
        
        pauseButton = [[UIButton alloc]initWithFrame:CGRectMake(10, (h-50)/2, 50, 50)];
        pauseButton.layer.cornerRadius = pauseButton.frame.size.width/2;
        pauseButton.backgroundColor = [UIColor greenColor];
        pauseButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [pauseButton setTitle:@"PAUSE" forState:UIControlStateNormal];
        
        UIButton * stopButton = [[UIButton alloc]initWithFrame:CGRectMake(w-120, (h-50)/2, 50, 50)];
        stopButton.layer.cornerRadius = stopButton.frame.size.width/2;
        stopButton.backgroundColor = [UIColor redColor];
        [stopButton setTitle:@"STOP" forState:UIControlStateNormal];
        [self.view addSubview:stopButton];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, (unsigned long)NULL), ^{
            NSURL * url = [NSURL URLWithString: @"https://api.soundcloud.com/tracks/147445565/download?client_id=2d87025c8392069f828c446b965862e3"];
            
            NSData * data = [NSData dataWithContentsOfURL:url];
            
            NSLog(@"finised");
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                player = [[AVAudioPlayer alloc]initWithData:data error:nil];
                
                [playButton addTarget:self action:@selector(playSong) forControlEvents:UIControlEventTouchUpInside];
                    NSLog(@"play");
                
                [pauseButton addTarget:self action:@selector(pauseSong) forControlEvents:UIControlEventTouchUpInside];
                
                [stopButton addTarget:self action:@selector(stopSong) forControlEvents:UIControlEventTouchUpInside];
                
                length = player.duration;
                NSLog(@"%f",length);
                playTime = 60;
                
                player.volume = 0.5;
                
                NSLog(@"volume %f",player.volume);
                
                volume = [[UISlider alloc]initWithFrame:CGRectMake(70, h-64, w-140, 4)];
                volume.backgroundColor = [UIColor blackColor];
                [volume addTarget:self action:@selector(changeVolume:) forControlEvents:UIControlEventValueChanged];
                volume.value = player.volume;
                [self.view addSubview:volume];
            });
            
        });
        
        progressBar = [[UIView alloc] initWithFrame:CGRectMake(70, h-32, w-140, 4)];
        progressBar.backgroundColor = [UIColor darkGrayColor];
        [self.view addSubview:progressBar];
        
//        timer = [[NSTimer alloc]init];
        
        
    }
    return self;
}

-(void)playSong
{
    [player play];
    
    [playButton removeFromSuperview];
    [self.view addSubview:pauseButton];
    
    timer=[NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(moveDot) userInfo:nil repeats:YES];
}

-(void)pauseSong
{
    [player pause];
    [timer invalidate];
    [pauseButton removeFromSuperview];
    [self.view addSubview:playButton];
}

-(void)stopSong
{
    [self pauseSong];
    player.currentTime = 0;
}

-(void)changeVolume: (UISlider *)sender
{
    player.volume = sender.value;
}

-(void)moveDot
{
    NSLog(@"playtime %f",player.currentTime);
    if (xpoint == 0)
    {
        NSLog(@"ball position %f",((([UIScreen mainScreen].bounds.size.width -140)/length)*(playTime)));
        playTime =((([UIScreen mainScreen].bounds.size.width -140)/length)*player.currentTime)+60;
        [progressDot removeFromSuperview];
        progressDot = [[UIView alloc] initWithFrame:CGRectMake(playTime, ([UIScreen mainScreen].bounds.size.height)-40, 20, 20)];
        progressDot.layer.cornerRadius = progressDot.frame.size.width/2;
        progressDot.backgroundColor = [UIColor blueColor];
        [progressDot isFirstResponder];
        [self.view addSubview:progressDot];
    }else{
        [progressDot removeFromSuperview];
        progressDot = [[UIView alloc] initWithFrame:CGRectMake(xpoint, ([UIScreen mainScreen].bounds.size.height)-40, 20, 20)];
        progressDot.layer.cornerRadius = progressDot.frame.size.width/2;
        progressDot.backgroundColor = [UIColor blueColor];
        [progressDot isFirstResponder];
        [self.view addSubview:progressDot];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch * touch in touches)
    {
        CGPoint touchLocation = [touch locationInView:self.view];
        if (fabs(touchLocation.y - progressBar.frame.origin.y)<10)
        {
            [timer invalidate];
            [self pauseSong];
        }
//        if (fabs(touchLocation.x - volumeBar.frame.origin.x)<10)
//        {
//            if (touchLocation.y <= 60) {
//                ypoint = 60;
//            }else if(touchLocation.y >=[UIScreen mainScreen].bounds.size.width-80)
//            {
//                ypoint = [UIScreen mainScreen].bounds.size.width-80;
//            } else{
//                ypoint = touchLocation.y;
//                //            NSLog(@"used touches %f",touchLocation.x);
//            }
//            [self changeVolume];
//        }
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
//    NSLog(@"%@",touches);
    for (UITouch * touch in touches)
    {
        CGPoint touchLocation = [touch locationInView:self.view];
        if (fabs(touchLocation.y - progressBar.frame.origin.y)<10)
        {
        if (touchLocation.x <= 60) {
            xpoint = 60;
        }else if(touchLocation.x >=[UIScreen mainScreen].bounds.size.width-80)
        {
            xpoint = [UIScreen mainScreen].bounds.size.width-80;
        } else{
            xpoint = touchLocation.x;
//            NSLog(@"used touches %f",touchLocation.x);
        }
    }
//        if (fabs(touchLocation.x - volumeBar.frame.origin.x)<10)
//        {
//            if (touchLocation.y <= 60) {
//                ypoint = 60;
//            }else if(touchLocation.y >=[UIScreen mainScreen].bounds.size.width-80)
//            {
//                ypoint = [UIScreen mainScreen].bounds.size.width-80;
//            } else{
//                ypoint = touchLocation.y;
//                //            NSLog(@"used touches %f",touchLocation.x);
//            }
//            [self changeVolume];
//        }
    [self moveDot];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch * touch in touches)
    {
        CGPoint touchLocation = [touch locationInView:self.view];
        if (fabs(touchLocation.y - progressBar.frame.origin.x)<10)
        {
            if (touchLocation.x <= 60) {
                xpoint = 60;
            }else if(touchLocation.x >=[UIScreen mainScreen].bounds.size.width-81)
            {
                xpoint = [UIScreen mainScreen].bounds.size.width-81;
            } else {
                xpoint = touchLocation.x;
            //            NSLog(@"used touches %f",touchLocation.x);
            }
            player.currentTime = (length/([UIScreen mainScreen].bounds.size.width - 140))*(xpoint-60);
            NSLog(@"moved %i",xpoint);
            NSLog(@"moved %f",player.currentTime);
            xpoint = 0;
//        ((([UIScreen mainScreen].bounds.size.width -140)/length)*player.currentTime)+60
        }
        
//        if (fabs(touchLocation.x - volumeBar.frame.origin.x)<10)
//        {
//            if (touchLocation.y <= 60) {
//                ypoint = 60;
//            }else if(touchLocation.y >=[UIScreen mainScreen].bounds.size.width-80)
//            {
//                ypoint = [UIScreen mainScreen].bounds.size.width-80;
//            } else{
//                ypoint = touchLocation.y;
//                //            NSLog(@"used touches %f",touchLocation.x);
//            }
//            [self changeVolume];
//        }
    }
    
//    [self playSong];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
