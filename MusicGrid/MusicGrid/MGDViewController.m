//
//  MGDViewController.m
//  MusicGrid
//
//  Created by T.J. Mercer on 6/6/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "MGDViewController.h"
#import "MGDAlbumList.h"
#import "MGDRatingScreen.h"
#import "MGDData.h"

@interface MGDViewController ()

@end

@implementation MGDViewController
{
    MGDAlbumList * albums;
    
    UIImageView * albumCover;
    UIImageView * backAlbum;
    UIView * menu;
    UITextView * error;
    
    float albumCount;
    float doneStack;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    backAlbum = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2)-170, 80, 150, 150)];
//    backAlbum.backgroundColor = [UIColor blackColor];
    backAlbum.image = [UIImage imageNamed:@"Yes"];
//    backAlbum.image = [MGDData mainData].suggestions[1][@"cover"];
    backAlbum.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:backAlbum];
    
    albumCover = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2)-75, 200, 250, 250)];
//    albumCover.backgroundColor = [UIColor blackColor];
    albumCover.image = [UIImage imageNamed:@"Yes"];
//    albumCover.image = [MGDData mainData].suggestions[0][@"cover"];
    albumCover.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:albumCover];
    
//    albumCover = [[UIImageView alloc]initWithFrame:CGRectMake(40, (SCREEN_HEIGHT / 2) - ((SCREEN_WIDTH - 80)/2), SCREEN_WIDTH - 80, SCREEN_WIDTH - 80)];
//    albumCover.backgroundColor = [UIColor blackColor];
//    albumCover.image = [UIImage imageNamed:@"Yes"];
//    albumCover.contentMode = UIViewContentModeScaleAspectFit;
//    [self.view addSubview:albumCover];
    
    menu = [[UIView alloc]initWithFrame:CGRectMake(-200, 0, 200, SCREEN_HEIGHT)];
    menu.backgroundColor = [UIColor blueColor];
    [self.view addSubview:menu];
    
    error = [[UITextView alloc]initWithFrame:CGRectMake(80, 100, SCREEN_WIDTH - 160, SCREEN_HEIGHT - 200)];
    error.textAlignment =  NSTextAlignmentCenter;
    error.textContainerInset = UIEdgeInsetsMake(100, 10, SCREEN_HEIGHT-300, 10);
    error.backgroundColor = [UIColor redColor];
    
    UIButton * rated = [[UIButton alloc]initWithFrame:CGRectMake(20, 100, 160, 20)];
    [rated setTitle:@"Old Listens" forState:UIControlStateNormal];
    rated.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [rated addTarget:self action:@selector(oldAlbums) forControlEvents:UIControlEventTouchUpInside];
    [menu addSubview:rated];
    
    UIButton * unrated = [[UIButton alloc]initWithFrame:CGRectMake(20, 200, 160, 20)];
    [unrated setTitle:@"Rate Previous" forState:UIControlStateNormal];
    unrated.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [unrated addTarget:self action:@selector(ratingsScreen) forControlEvents:UIControlEventTouchUpInside];
    [menu addSubview:unrated];
    
    UIButton * later = [[UIButton alloc]initWithFrame:CGRectMake(20, 300, 160, 20)];
    [later setTitle:@"Saved Suggestions" forState:UIControlStateNormal];
    later.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [later addTarget:self action:@selector(later) forControlEvents:UIControlEventTouchUpInside];
    [menu addSubview:later];
    
    UIButton * friends = [[UIButton alloc]initWithFrame:CGRectMake(20, 400, 160, 20)];
    [friends setTitle:@"Friends" forState:UIControlStateNormal];
    friends.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [friends addTarget:self action:@selector(friends) forControlEvents:UIControlEventTouchUpInside];
    [menu addSubview:friends];
    
    UIButton * options = [[UIButton alloc]initWithFrame:CGRectMake(20, 500, 160, 20)];
    [options setTitle:@"Options" forState:UIControlStateNormal];
    options.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [options addTarget:self action:@selector(optionsAct) forControlEvents:UIControlEventTouchUpInside];
    [menu addSubview:options];
    
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
    albumCount = [[[MGDData mainData].albumsForLater allKeys] count];
    
    doneStack = [[[MGDData mainData].unRated allKeys] count];
    
    switch (gesture.direction)
    {
        case 1: //right
        {
            [UIView animateWithDuration:0.5 animations:^{
                menu.frame = CGRectMake(0, 0, 200, SCREEN_HEIGHT);
                NSLog(@"swiped");
                
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
            
        case 2: //left
        {
            if (menu.frame.origin.x == -200)
            {
                UIImageView * newAlbum = [[UIImageView alloc]initWithFrame:CGRectMake(-150, 80, 150, 150)];
//                newAlbum.backgroundColor = [UIColor blackColor];
                newAlbum.image = [UIImage imageNamed:@"Yes"];
//                newAlbum.image = albumCover.image = [MGDData mainData].suggestions[2][@"cover"];;
                newAlbum.contentMode = UIViewContentModeScaleAspectFit;
                [self.view insertSubview:newAlbum atIndex:0];
                
                [UIView animateWithDuration:.5 animations:^{
                    albumCover.frame = CGRectMake(-(SCREEN_WIDTH/2)-75, 200, SCREEN_WIDTH - 80, SCREEN_WIDTH - 80);
                    
                    backAlbum.frame = CGRectMake((SCREEN_WIDTH/2)-75, 200, 250, 250);
                    
                    newAlbum.frame = CGRectMake((SCREEN_WIDTH/2)-170, 80, 150, 150);
//                    albumCover.backgroundColor = [UIColor blackColor];
                    
                    [[MGDData mainData].albumsForLater setObject:[@{@"cover":albumCover.image}mutableCopy] forKey:[NSString stringWithFormat:@"Album Number %0.f",albumCount + 1]];
                } completion:^(BOOL finished) {
                    [albumCover removeFromSuperview];
                    albumCover = backAlbum;
                    backAlbum = newAlbum;
                }];
            }else{
                
                [UIView animateWithDuration:0.5 animations:^{
                    menu.frame = CGRectMake(-200, 0, 100, SCREEN_HEIGHT);
                } completion:^(BOOL finished) {
                    
                }];
                
            }
        }
            break;
            
        case 4: //up
        {
            [UIView animateWithDuration:.5 animations:^{
                albumCover.frame = CGRectMake(40, - (SCREEN_WIDTH -80), SCREEN_WIDTH - 80, SCREEN_WIDTH - 80);
                
                [[MGDData mainData].unRated setObject:[@{@"cover":albumCover.image}mutableCopy] forKey:[NSString stringWithFormat:@"Album Number %0.f",doneStack + 1]];
            } completion:^(BOOL finished) {
                [albumCover removeFromSuperview];
            }];
        }
            break;
            
        case 8://down
        {
            UIImageView * newAlbum = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH + 40, (SCREEN_HEIGHT / 2) - ((SCREEN_WIDTH - 80)/2), SCREEN_WIDTH - 80, SCREEN_WIDTH - 80)];
            newAlbum.backgroundColor = [UIColor blackColor];
            newAlbum.image = [UIImage imageNamed:@"Yes"];
//            newAlbum.image = albumCover.image = [MGDData mainData].suggestions[2][@"cover"];;
            newAlbum.contentMode = UIViewContentModeScaleAspectFit;
            [self.view insertSubview:newAlbum atIndex:0];
            
            [UIView animateWithDuration:.5 animations:^{
                
                albumCover.frame = CGRectMake(SCREEN_WIDTH + (SCREEN_WIDTH/2)-75, 200, SCREEN_WIDTH - 80, SCREEN_WIDTH - 80);
                
                backAlbum.frame = CGRectMake((SCREEN_WIDTH/2)-75, 200, 250, 250);
                
                newAlbum.frame = CGRectMake((SCREEN_WIDTH/2)-170, 80, 150, 150);
                //                    albumCover.backgroundColor = [UIColor blackColor];
                
                newAlbum.frame = CGRectMake(40, (SCREEN_HEIGHT / 2) - ((SCREEN_WIDTH - 80)/2), SCREEN_WIDTH - 80, SCREEN_WIDTH - 80);
                } completion:^(BOOL finished) {
                [albumCover removeFromSuperview];
                albumCover = backAlbum;
                backAlbum = newAlbum;
            }];
        }
            break;
        default:
            break;
    }

}

-(void)oldAlbums
{
    if ([[[MGDData mainData].ratedAlbums allKeys] count] != 0)
    {
        albums = [[MGDAlbumList alloc]initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
        [MGDData mainData].used = [MGDData mainData].ratedAlbums;
        UINavigationController * nc = [[UINavigationController alloc]initWithRootViewController:albums];
        nc.navigationBarHidden = YES;
        [self.navigationController presentViewController:nc animated:YES completion:^{
            [menu removeFromSuperview];
            [albumCover removeFromSuperview];
        }];

    }else{
        error.text = @"You haven't rated anything yet. \n Listen to Some Music";
        [self.view addSubview:error];
    }
    
}

-(void)ratingsScreen
{
    if ([[[MGDData mainData].unRated allKeys] count] != 0)
    {
        MGDRatingScreen * stars = [[MGDRatingScreen alloc]init];
        UINavigationController * nc = [[UINavigationController alloc]initWithRootViewController:stars];
        nc.navigationBarHidden = YES;
        [self.navigationController presentViewController:nc animated:YES completion:^{
            [menu removeFromSuperview];
            [albumCover removeFromSuperview];
        }];
    }else{
        error.text = @"You've been thorough \n There are no albums you need to rate";
        [self.view addSubview:error];
    }
    
}

-(void)later
{
    if ([[[MGDData mainData].albumsForLater allKeys] count] != 0)
    {
        albums = [[MGDAlbumList alloc]initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
        [MGDData mainData].used = [MGDData mainData].albumsForLater;
        UINavigationController * nc = [[UINavigationController alloc]initWithRootViewController:albums];
        nc.navigationBarHidden = YES;
        [self.navigationController presentViewController:nc animated:YES completion:^{
            [menu removeFromSuperview];
            [albumCover removeFromSuperview];
        }];
    }else{
        error.text = @"You've listend to everything \n You have no delayed suggestions";
        [self.view addSubview:error];
    }
}

-(void)friends
{
    error.text = @"This doesn't work yet";
    [self.view addSubview:error];
}

-(void)optionsAct
{
    error.text = @"This will let you log out and choose your player. \nSpotify will be the default";
    [self.view addSubview:error];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [error removeFromSuperview];
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
