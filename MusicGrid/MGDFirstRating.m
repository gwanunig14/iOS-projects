//
//  MGDRatingScreen.m
//  MusicGrid
//
//  Created by T.J. Mercer on 6/7/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "MGDFirstRating.h"
#import "MGDViewController.h"
#import "MGDRequest.h"
#import "MGDData.h"

@interface MGDFirstRating ()

@end

@implementation MGDFirstRating
{
    UIImageView * currentAlbum;
    
    UILabel * albumTitle;
    
    UIView * oneStar;
    UIView * twoStar;
    UIView * threeStar;
    UIView * fourStar;
    UIView * fiveStar;
    
    float artistCount;
    int index;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        index = 0;
        artistCount = 1;
        NSLog(@"%@",[MGDData mainData].token);
        
        NSLog(@"%@", [MGDData mainData].unRated);
        
        self.view.backgroundColor = [UIColor whiteColor];
        
        currentAlbum = [[UIImageView alloc]initWithFrame: CGRectMake(40, (SCREEN_HEIGHT / 2) - ((SCREEN_WIDTH - 80)/2), SCREEN_WIDTH - 80, SCREEN_WIDTH - 80)];
        currentAlbum.image = [[MGDData mainData].unRated allValues][index][@"cover"];
        [self.view addSubview:currentAlbum];
        
        albumTitle = [[UILabel alloc]initWithFrame:CGRectMake(40, 40, SCREEN_WIDTH - 80, 40)];
        albumTitle.text = [[MGDData mainData].unRated allKeys][index];
        [self.view addSubview:albumTitle];
        
        [self loadStars];
        
        UISwipeGestureRecognizer * swipeLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAlbum:)];
        swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
        [self.view addGestureRecognizer:swipeLeft];
        
        UISwipeGestureRecognizer * swipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAlbum:)];
        swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
        [self.view addGestureRecognizer:swipeRight];
        
        [[MGDData mainData].ratedAlbums setObject:[@{}mutableCopy] forKey:@"artists"];
        NSLog(@"%@",[MGDData mainData].ratedAlbums);
    }
    return self;
}

-(void)loadStars
{
    oneStar = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/6) -20, SCREEN_HEIGHT -60, 40, 40)];
    oneStar.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:oneStar];
    
    twoStar = [[UIView alloc]initWithFrame:CGRectMake(((SCREEN_WIDTH/6) * 2) - 20, SCREEN_HEIGHT -60, 40, 40)];
    twoStar.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:twoStar];
    
    threeStar = [[UIView alloc]initWithFrame:CGRectMake(((SCREEN_WIDTH/6) * 3) - 20, SCREEN_HEIGHT -60, 40, 40)];
    threeStar.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:threeStar];
    
    fourStar = [[UIView alloc]initWithFrame:CGRectMake(((SCREEN_WIDTH/6) * 4) - 20, SCREEN_HEIGHT -60, 40, 40)];
    fourStar.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:fourStar];
    
    fiveStar = [[UIView alloc]initWithFrame:CGRectMake(((SCREEN_WIDTH/6) * 5) - 20, SCREEN_HEIGHT -60, 40, 40)];
    fiveStar.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:fiveStar];
}

- (void)swipeAlbum:(UISwipeGestureRecognizer *)gesture
{
    switch (gesture.direction)
    {
        case 1: //right
        {
            if (index != 0)
            {
                index = index - 1;
                UIImageView * newAlbum = [[UIImageView alloc]initWithFrame:CGRectMake(-(SCREEN_WIDTH + 40), (SCREEN_HEIGHT / 2) - ((SCREEN_WIDTH - 80)/2), SCREEN_WIDTH - 80, SCREEN_WIDTH - 80)];
                newAlbum.image = [[MGDData mainData].unRated allValues][index][@"cover"];
                [self.view addSubview:newAlbum];
                
                [UIView animateWithDuration:.5 animations:^{
                    currentAlbum.frame = CGRectMake(-(SCREEN_WIDTH - 80), (SCREEN_HEIGHT / 2) - ((SCREEN_WIDTH - 80)/2), SCREEN_WIDTH - 80, SCREEN_WIDTH - 80);
                    
                    currentAlbum.frame = CGRectMake(40, (SCREEN_HEIGHT / 2) - ((SCREEN_WIDTH - 80)/2), SCREEN_WIDTH - 80, SCREEN_WIDTH - 80);
                    currentAlbum.backgroundColor = [UIColor blackColor];
                } completion:^(BOOL finished) {
                    [currentAlbum removeFromSuperview];
                    currentAlbum = newAlbum;
                    albumTitle.text = [[MGDData mainData].unRated allKeys][index];
                }];
            }
        }
            break;
            
        case 2: //left
        {
            if ([[[MGDData mainData].unRated allKeys] count] > index + 1)
            {
                index = index + 1;
                UIImageView * newAlbum = [[UIImageView alloc]initWithFrame: CGRectMake(SCREEN_WIDTH + 40, (SCREEN_HEIGHT / 2) - ((SCREEN_WIDTH - 80)/2), SCREEN_WIDTH - 80, SCREEN_WIDTH - 80)];
                newAlbum.image = [[MGDData mainData].unRated allValues][index][@"cover"];
                [self.view insertSubview:newAlbum atIndex:0];
                
                [UIView animateWithDuration:.5 animations:^{
                    currentAlbum.frame = CGRectMake(-(SCREEN_WIDTH - 80), (SCREEN_HEIGHT / 2) - ((SCREEN_WIDTH - 80)/2), SCREEN_WIDTH - 80, SCREEN_WIDTH - 80);
                    
                    newAlbum.frame = CGRectMake(40, (SCREEN_HEIGHT / 2) - ((SCREEN_WIDTH - 80)/2), SCREEN_WIDTH - 80, SCREEN_WIDTH - 80);
                    currentAlbum.backgroundColor = [UIColor blackColor];
                } completion:^(BOOL finished) {
                    [currentAlbum removeFromSuperview];
                    currentAlbum = newAlbum;
                    albumTitle.text = [[MGDData mainData].unRated allKeys][index];
                }];
                
            }
        }
            break;
        default:
            break;
    }
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    
    CGPoint location = [touch locationInView:self.view];
    
    [self starsWithLocation:location];
}

-(void)starsWithLocation:(CGPoint)location
{
    NSArray * stars = @[oneStar,twoStar,threeStar,fourStar,fiveStar];
    
    for (UIView * star in stars)
    {
        NSInteger goldStars;
        
        if (CGRectContainsPoint(star.frame, location))
        {
            switch ([stars indexOfObject:star]) {
                case 0:
                {
                    goldStars = 1;
                    star.backgroundColor = [UIColor yellowColor];
                }
                    break;
                case 1:
                {
                    goldStars = 2;
                    
                    for (int i = 0; i <goldStars; i++)
                    {
                        UIView * goldStar = stars[i];
                        goldStar.backgroundColor = [UIColor yellowColor];
                    }
                }
                    
                    break;
                case 2:
                {
                    goldStars = 3;
                    
                    for (int i = 0; i <goldStars; i++)
                    {
                        UIView * goldStar = stars[i];
                        goldStar.backgroundColor = [UIColor yellowColor];
                    }
                }
                    break;
                case 3:
                {
                    goldStars = 4;
                    
                    for (int i = 0; i <goldStars; i++)
                    {
                        UIView * goldStar = stars[i];
                        goldStar.backgroundColor = [UIColor yellowColor];
                    }
                }
                    break;
                case 4:
                {
                    goldStars = 5;
                    
                    for (int i = 0; i <goldStars; i++)
                    {
                        UIView * goldStar = stars[i];
                        goldStar.backgroundColor = [UIColor yellowColor];
                    }
                }
                    
                    break;
                    
                default:
                    break;
            }
            
            [[MGDData mainData].ratedAlbums[@"artists"] setObject:albumTitle.text forKey:[NSString stringWithFormat:@"artist_%0.f", artistCount]];
            
            NSLog(@"%@",[MGDData mainData].ratedAlbums);
            
            [[MGDData mainData].unRated removeObjectForKey:albumTitle.text];
            
            artistCount = artistCount + 1;
            
//            [[MGDData mainData].ratedAlbums setObject:@{@"cover":currentAlbum.image,
//                                                        @"rating":@(goldStars)}
//                                               forKey:albumTitle.text];
            
            if ([[[MGDData mainData].unRated allKeys] count] == 0)
            {
                NSLog(@"1");
                MGDViewController * music = [[MGDViewController alloc]init];
                UINavigationController * nc = [[UINavigationController alloc]initWithRootViewController:music];
                MGDRequest * request = [[MGDRequest alloc]init];
                [[MGDData mainData].ratedAlbums[@"artists"] setObject:@([MGDData mainData].requestCount) forKey:@"offset"];
//                [[MGDData mainData].ratedAlbums[@"artists"] setObject:[MGDData mainData].token forKey:@"user_token"];
                [request sendDictionary:[MGDData mainData].ratedAlbums andString:@"taste_profiles/get_three_suggestions"];
                [MGDData mainData].requestCount = [MGDData mainData].requestCount + 3;
//                [self.navigationController presentViewController:nc animated:YES completion:^{
//
//                }];
            }else if([[[MGDData mainData].unRated allKeys]count] > index)
            {
                NSLog(@"2");
                UIImageView * newAlbum = [[UIImageView alloc]initWithFrame: CGRectMake(SCREEN_WIDTH + 40, (SCREEN_HEIGHT / 2) - ((SCREEN_WIDTH - 80)/2), SCREEN_WIDTH - 80, SCREEN_WIDTH - 80)];
                newAlbum.image = [[MGDData mainData].unRated allValues][index][@"cover"];
                [self.view insertSubview:newAlbum atIndex:0];
                
                [UIView animateWithDuration:.5 animations:^{
                    currentAlbum.frame = CGRectMake(40, SCREEN_HEIGHT, SCREEN_WIDTH - 80, SCREEN_WIDTH - 80);
                    
                    newAlbum.frame = CGRectMake(40, (SCREEN_HEIGHT / 2) - ((SCREEN_WIDTH - 80)/2), SCREEN_WIDTH - 80, SCREEN_WIDTH - 80);
                    
                } completion:^(BOOL finished) {
                    [currentAlbum removeFromSuperview];
                    currentAlbum = newAlbum;
                    albumTitle.text = [[MGDData mainData].unRated allKeys][index];
                    [oneStar removeFromSuperview];
                    [twoStar removeFromSuperview];
                    [threeStar removeFromSuperview];
                    [fourStar removeFromSuperview];
                    [fiveStar removeFromSuperview];
                    
                    [self loadStars];
                }];
            } else {
                NSLog(@"3");
                NSLog(@"%d",index);
                index = (int)[[[MGDData mainData].unRated allKeys] count]-1;
                NSLog(@"%d",index);
                UIImageView * newAlbum = [[UIImageView alloc]initWithFrame: CGRectMake(-SCREEN_WIDTH - 80, (SCREEN_HEIGHT / 2) - ((SCREEN_WIDTH - 80)/2), SCREEN_WIDTH - 80, SCREEN_WIDTH - 80)];
                newAlbum.image = [[MGDData mainData].unRated allValues][index][@"cover"];
                [self.view insertSubview:newAlbum atIndex:0];
                
                [UIView animateWithDuration:.5 animations:^{
                    currentAlbum.frame = CGRectMake(40, SCREEN_HEIGHT, SCREEN_WIDTH - 80, SCREEN_WIDTH - 80);
                    
                    newAlbum.frame = CGRectMake(40, (SCREEN_HEIGHT / 2) - ((SCREEN_WIDTH - 80)/2), SCREEN_WIDTH - 80, SCREEN_WIDTH - 80);
                } completion:^(BOOL finished) {
                    [currentAlbum removeFromSuperview];
                    currentAlbum = newAlbum;
                    albumTitle.text = [[MGDData mainData].unRated allKeys][index];
                    [oneStar removeFromSuperview];
                    [twoStar removeFromSuperview];
                    [threeStar removeFromSuperview];
                    [fourStar removeFromSuperview];
                    [fiveStar removeFromSuperview];
                    
                    [self loadStars];
                }];
            }
        }
    }
    NSLog(@"%@",[MGDData mainData].ratedAlbums);
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
