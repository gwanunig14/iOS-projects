//
//  ALAiPadDataView.m
//  AudioList
//
//  Created by T.J. Mercer on 5/8/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "ALAiPadDataView.h"
#import "ALAData.h"

@interface ALAiPadDataView () <AVAudioPlayerDelegate>

@end

@implementation ALAiPadDataView
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
    
    songName = [[UILabel alloc]initWithFrame:CGRectMake(20, 100, self.view.frame.size.width - 40, 20)];
    
    albumCover = [[UIImageView alloc]initWithFrame:CGRectMake(20, 190, self.view.frame.size.width - 40, self.view.frame.size.height - 210)];
    [albumCover setContentMode:UIViewContentModeScaleAspectFill];
    
    playCount = [[UILabel alloc]initWithFrame:CGRectMake(20, 130, self.view.frame.size.width - 40, 20)];
    
    isLiked = [[UILabel alloc]initWithFrame:CGRectMake(20, 160, 300, 20)];
    
//    songName.text = [ALAData mainData].musicData[0][@"name"];
//    [self.view addSubview:songName];
//    
//    albumCover.image = [ALAData mainData].musicData[0][@"image"];
//    [self.view addSubview:albumCover];
//    
//    playCount.text = [[ALAData mainData].musicData[0][@"playCount"] stringValue];
//    [self.view addSubview:playCount];
//    
//    isLiked.text = [ALAData mainData].musicData[0][@"liked"];
//    [self.view addSubview:isLiked];
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
//    NSLog(@"%@",[ALAData mainData].musicData[index][@"name"]);
//    
//    songName.text = [ALAData mainData].musicData[index][@"name"];
//    
//    albumCover.image = [ALAData mainData].musicData[index][@"image"];
//    
//    playCount.text = [[ALAData mainData].musicData[index][@"playCount"] stringValue];
//    
//    isLiked.text = [ALAData mainData].musicData[index][@"liked"];
//    
//    [self playSoundWithName:[ALAData mainData].musicData[index][@"audio"]];
//    [self displayNewInfo];
}

-(void)displayNewInfo
{
    [self.view addSubview:songName];
    [self.view addSubview:albumCover];
    [self.view addSubview:playCount];
    [self.view addSubview:isLiked];
    NSLog(@"text says %@",playCount.text);
    [self.view setNeedsDisplay];

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
