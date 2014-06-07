//
//  MGDViewController.m
//  MusicGrid
//
//  Created by T.J. Mercer on 6/6/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "MGDViewController.h"
#import "MGDData.h"

@interface MGDViewController ()

@end

@implementation MGDViewController
{
    UIImageView * albumCover;
    UIView * menu;
    
    float albumCount;
    float doneStack;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    albumCover = [[UIImageView alloc]initWithFrame:CGRectMake(40, (SCREEN_HEIGHT / 2) - ((SCREEN_WIDTH - 80)/2), SCREEN_WIDTH - 80, SCREEN_WIDTH - 80)];
    albumCover.backgroundColor = [UIColor blackColor];
    [self.view addSubview:albumCover];
    
    menu = [[UIView alloc]initWithFrame:CGRectMake(-100, 0, 100, SCREEN_HEIGHT)];
    menu.backgroundColor = [UIColor blueColor];
    [self.view addSubview:menu];
    
    UIButton * rated = [[UIButton alloc]initWithFrame:CGRectMake(20, 20, 60, 20)];
    [rated setTitle:@"Rate" forState:UIControlStateNormal];
    [rated addTarget:self action:@selector(oldAlbums) forControlEvents:UIControlEventTouchUpInside];
    [menu addSubview:rated];
    
    UIButton * unrated = [[UIButton alloc]initWithFrame:CGRectMake(100, 20, 60, 20)];
    [unrated setTitle:@"Rate" forState:UIControlStateNormal];
    [unrated addTarget:self action:@selector(ratingsScreen) forControlEvents:UIControlEventTouchUpInside];
    [menu addSubview:unrated];
    
    UIButton * friends = [[UIButton alloc]initWithFrame:CGRectMake(100, 20, 60, 20)];
    [friends setTitle:@"Rate" forState:UIControlStateNormal];
    [friends addTarget:self action:@selector(friends) forControlEvents:UIControlEventTouchUpInside];
    [menu addSubview:friends];
    
    UISwipeGestureRecognizer * swipeUp = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAlbum:)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeUp];
    
    UISwipeGestureRecognizer * swipeDown = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAlbum:)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeDown];
    
    UISwipeGestureRecognizer * swipeLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAlbum:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer * swipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAlbum:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
    
    // Do any additional setup after loading the view.
}

- (void)swipeAlbum:(UISwipeGestureRecognizer *)gesture
{
    albumCount = [[] albumsForLater count];
    
    doneStack = [unRated count];
    
    switch (gesture.direction)
    {
        case 1: //right
        {
            [UIView animateWithDuration:0.5 animations:^{
                menu.frame = CGRectMake(0, 0, 100, SCREEN_HEIGHT);
                NSLog(@"swiped");
                
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
            
        case 2: //left
        {
            if (menu.frame.origin.x == -100)
            {
                UIImageView * newAlbum = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH + 40, (SCREEN_HEIGHT / 2) - ((SCREEN_WIDTH - 80)/2), SCREEN_WIDTH - 80, SCREEN_WIDTH - 80)];
                newAlbum.backgroundColor = [UIColor blackColor];
                [self.view addSubview:newAlbum];
                
                [UIView animateWithDuration:.5 animations:^{
                    albumCover.frame = CGRectMake(-(SCREEN_WIDTH - 80), (SCREEN_HEIGHT / 2) - ((SCREEN_WIDTH - 80)/2), SCREEN_WIDTH - 80, SCREEN_WIDTH - 80);
                    
                    newAlbum.frame = CGRectMake(40, (SCREEN_HEIGHT / 2) - ((SCREEN_WIDTH - 80)/2), SCREEN_WIDTH - 80, SCREEN_WIDTH - 80);
                    albumCover.backgroundColor = [UIColor blackColor];
                    
                    [albumsForLater addObject:[NSString stringWithFormat:@"Album Number %f",albumCount + 1]];
                } completion:^(BOOL finished) {
                    [albumCover removeFromSuperview];
                    albumCover = newAlbum;
                }];
            }else{
                
                [UIView animateWithDuration:0.5 animations:^{
                    menu.frame = CGRectMake(-100, 0, 100, SCREEN_HEIGHT);
                } completion:^(BOOL finished) {
                    
                }];
                
            }
        }
            break;
            
        case 4: //up
        {
            [UIView animateWithDuration:.5 animations:^{
                albumCover.frame = CGRectMake(40, - (SCREEN_WIDTH -80), SCREEN_WIDTH - 80, SCREEN_WIDTH - 80);
                
                [unRated addObject:[NSString stringWithFormat:@"Album Number %f",doneStack + 1]];
            } completion:^(BOOL finished) {
                [albumCover removeFromSuperview];
            }];
        }
            break;
            
        case 8://down
        {
            UIImageView * newAlbum = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH + 40, (SCREEN_HEIGHT / 2) - ((SCREEN_WIDTH - 80)/2), SCREEN_WIDTH - 80, SCREEN_WIDTH - 80)];
            newAlbum.backgroundColor = [UIColor blackColor];
            [self.view addSubview:newAlbum];
            
            [UIView animateWithDuration:.5 animations:^{
                albumCover.frame = CGRectMake(40, (SCREEN_HEIGHT + 40), SCREEN_WIDTH - 80, SCREEN_WIDTH - 80);
                
                newAlbum.frame = CGRectMake(40, (SCREEN_HEIGHT / 2) - ((SCREEN_WIDTH - 80)/2), SCREEN_WIDTH - 80, SCREEN_WIDTH - 80);
                } completion:^(BOOL finished) {
                [albumCover removeFromSuperview];
                albumCover = newAlbum;
            }];
        }
            break;
        default:
            break;
    }
    
    NSLog(@"%@",albumsForLater);
    NSLog(@"%@",unRated);

}

-(void)oldAlbums
{
    
}

-(void)ratingsScreen
{
    
}

-(void)friends
{
    
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
