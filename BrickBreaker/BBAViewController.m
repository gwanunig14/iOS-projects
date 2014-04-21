//
//  BBAViewController.m
//  BrickBreaker
//
//  Created by T.J. Mercer on 4/17/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "BBAViewController.h"

#import "BBALevelController.h"

@interface BBAViewController () <BBALevelDelegate>

@end

@implementation BBAViewController
{
    BBALevelController * level;
    UIButton * startButton;
    UIView * header;
    UILabel * tally;
    UILabel * tries;
    
    float currentPoints;
    float currentLives;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        currentPoints = 0;
        currentLives = 0;
        
        level = [[BBALevelController alloc] initWithNibName:nil bundle:nil];
        
        [self. view addSubview:level.view];
        
        startButton = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2)-(SCREEN_HEIGHT/4), SCREEN_HEIGHT/4, SCREEN_HEIGHT/2, SCREEN_HEIGHT/2)];
        startButton.backgroundColor = [UIColor grayColor];
        startButton.layer.cornerRadius = SCREEN_HEIGHT/4;
        [startButton setTitle:@"START" forState:UIControlStateNormal];
        startButton.titleLabel.textColor = [UIColor blackColor];
        [startButton addTarget:self action:@selector(startGame) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:startButton];
        
        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        topScore = [[userDefaults objectForKey:@"topScore"] intValue];
        
        header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
        header.backgroundColor = [UIColor blackColor];
    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)startGame
{
    level = [[BBALevelController alloc] initWithNibName:nil bundle:nil];
    level.delegate = self;
    
    level.view.frame = CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT - 20);
    [self.view addSubview:level.view];
    [self.view addSubview:header];
    
    [startButton removeFromSuperview];
    [level resetLevel];
    
    tally = [[UILabel alloc] initWithFrame:CGRectMake(5, 2.5, 60, 15)];
    tally.textColor = [UIColor whiteColor];
    tally.textAlignment = NSTextAlignmentRight;
    tally.text = @"0";
    [header addSubview:tally];
    
    tries = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-65, 2.5, 60, 15)];
    tries.textColor = [UIColor whiteColor];
    tries.text = [NSString stringWithFormat:@"%.f", currentLives];
    tries.textAlignment = NSTextAlignmentLeft;
    [header addSubview:tries];
}

-(void)updatePoints:(int)points
{
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@(topScore) forKey:@"topScore"];
    [userDefaults synchronize];
}

-(void)gameDone
{
    [level.view removeFromSuperview];
    [header removeFromSuperview];
    [tally removeFromSuperview];
    [tries removeFromSuperview];
    [self.view addSubview:startButton];
    
}

-(void)addPoints:(int)points
{
//    NSLog(@"%f", currentPoints);
    currentPoints += points;
    tally.text = [NSString stringWithFormat: @"%.f", currentPoints];
    [tally setNeedsDisplay];
}

-(void)lifeCount:(int)lives
{
    currentLives = lives;
    [tries setNeedsDisplay];
    tries.text = [NSString stringWithFormat:@"%.f", currentLives];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden { return YES; }
@end
