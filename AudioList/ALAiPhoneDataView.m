//
//  ALAViewController.m
//  AudioList
//
//  Created by T.J. Mercer on 5/8/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "ALAiPhoneDataView.h"
#import "ALAData.h"


@interface ALAiPhoneDataView () <AVAudioPlayerDelegate>

@end

@implementation ALAiPhoneDataView
{
    UILabel * songName;
    UILabel * playCount;
    UILabel * isLiked;
    UIImageView * albumCover;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
}

-(void)playSoundWithName:(NSString *)soundName
{
//    NSString * file = [[NSBundle mainBundle] pathForResource:soundName ofType:@"mp3"];
//    
//    NSLog(@"%@", soundName);
    
    NSURL * url = [[NSURL alloc]initFileURLWithPath:soundName];
    
    self.player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    
    self.player.delegate = self;
    
    [self.player play];
    
    NSLog(@"playing");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setIndex:(NSInteger)index
{
//    _index = index;
//    
//    songName = [[UILabel alloc]initWithFrame:CGRectMake(20, 100, self.view.frame.size.width - 40, 20)];
//    songName.text = [ALAData mainData].musicData[index][@"name"];
//    [self.view addSubview:songName];
//    
//    albumCover = [[UIImageView alloc]initWithFrame:CGRectMake(20, 190, self.view.frame.size.width - 40, self.view.frame.size.height - 210)];
//    albumCover.image = [ALAData mainData].musicData[index][@"image"];
//    [albumCover setContentMode:UIViewContentModeScaleAspectFill];
//    [self.view addSubview:albumCover];
//    
//    playCount = [[UILabel alloc]initWithFrame:CGRectMake(20, 130, self.view.frame.size.width - 40, 20)];
//    playCount.text = [[ALAData mainData].musicData[index][@"playCount"] stringValue];
//    [self.view addSubview:playCount];
//    
//    isLiked = [[UILabel alloc]initWithFrame:CGRectMake(20, 160, self.view.frame.size.width - 40, 20)];
//    isLiked.text = [ALAData mainData].musicData[index][@"liked"];
//    [self.view addSubview:isLiked];
//    
//    [self playSoundWithName:[ALAData mainData].musicData[index][@"audio"]];
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
