//
//  SABViewController.m
//  Stuffed Animal Battle
//
//  Created by T.J. Mercer on 5/15/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SABViewController.h"
#import "SABData.h"
#import "SABGameScene.h"

#import <SpriteKit/SpriteKit.h>

@interface SABViewController () <SABDelegate>

@end

@implementation SABViewController
{
    UILabel * timerLabel;
    UIButton * buttonA;
    UIButton * buttonB;
    
    UIButton * player1HPBar;
    UIButton * player1Life;
    UIButton * player2HPBar;
    UIButton * player2Life;
    
    UIButton * dPadUp;
    UIButton * dPadDown;
    UIButton * dPadLeft;
    UIButton * dPadRight;
    
    SKView * skView;
    SABGameScene * skScene;
    SABData * data;
}

-(id)init
{
    self = [super init];
    if (self)
    {
        data.delegate = self;
        
        [SABData mainData].player2Life = 100;
        
        skView = [[SKView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [self.view addSubview:skView];
        
        skScene = [[SABGameScene alloc]initWithSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
        
        skView.showsFPS = YES;
        skView.showsNodeCount = YES;
        
        [skView presentScene:skScene];
        
        timerLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-20, 20, 42, 30)];
        timerLabel.text = @"00:00";
        timerLabel.textColor = [UIColor greenColor];
        timerLabel.font = [UIFont systemFontOfSize:16];
        [self.view addSubview:timerLabel];
        
        float barArea = ((SCREEN_WIDTH - 60)/2.0)-20;
        
        player1HPBar = [[UIButton alloc]initWithFrame:CGRectMake(20, 20, barArea, 20)];
        player1HPBar.backgroundColor= [UIColor lightGrayColor];
        [self.view addSubview:player1HPBar];
        
        player1Life = [[UIButton alloc]initWithFrame:CGRectMake(20, 15, barArea, 30)];
        player1Life.backgroundColor= [UIColor greenColor];
        [self.view addSubview:player1Life];
        
        player2HPBar = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-(barArea+20), 20, barArea, 20)];
        player2HPBar.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:player2HPBar];
        
        player2Life = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - (barArea+20), 15, barArea, 30)];
        player2Life.backgroundColor = [UIColor greenColor];
        [self.view addSubview:player2Life];
        
        buttonA = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 80, SCREEN_HEIGHT - 140, 40, 40)];
        [buttonA addTarget:self action:@selector(buttons:) forControlEvents:UIControlEventTouchUpInside];
        [buttonA setTitle:@"A" forState:UIControlStateNormal];
        buttonA.backgroundColor = [UIColor lightGrayColor];
        buttonA.layer.cornerRadius = 20;
        [self.view addSubview:buttonA];
        
        buttonB = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 120, SCREEN_HEIGHT - 80, 40, 40)];
        [buttonB addTarget:self action:@selector(buttons:) forControlEvents:UIControlEventTouchUpInside];
        [buttonB setTitle:@"B" forState:UIControlStateNormal];
        buttonB.backgroundColor = [UIColor lightGrayColor];
        buttonB.layer.cornerRadius = 20;
        [self.view addSubview:buttonB];
        
        dPadDown = [[UIButton alloc]initWithFrame:CGRectMake(80, SCREEN_HEIGHT - 40, 30, 30)];
        dPadDown.backgroundColor = [UIColor blueColor];
        [dPadDown addTarget:self action:@selector(buttons:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:dPadDown];
        
        dPadUp = [[UIButton alloc]initWithFrame:CGRectMake(80, SCREEN_HEIGHT - 120, 30, 30)];
        dPadUp.backgroundColor = [UIColor blueColor];
        [dPadUp addTarget:self action:@selector(buttons:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:dPadUp];
        
        dPadLeft = [[UIButton alloc]initWithFrame:CGRectMake(40, SCREEN_HEIGHT - 80, 30, 30)];
        dPadLeft.backgroundColor = [UIColor blueColor];
        [dPadLeft addTarget:self action:@selector(buttons:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:dPadLeft];
        
        dPadRight = [[UIButton alloc]initWithFrame:CGRectMake(120, SCREEN_HEIGHT - 80, 30, 30)];
        dPadRight.backgroundColor = [UIColor blueColor];
        [dPadRight addTarget:self action:@selector(buttons:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:dPadRight];
        
    }
    
    return self;
}

-(void)lifeLost
{
    player2Life.frame = CGRectMake(player2Life.frame.origin.x-23.1, SCREEN_HEIGHT -20, player2Life.frame.size.width-23.1, 30);
}

-(void)buttons:(UIButton *)sender
{
    NSLog(@"1");
    
    NSArray * buttons = @[buttonA,buttonB,dPadUp,dPadDown,dPadLeft,dPadRight];
    
    [skScene buttonClick:sender withArray:buttons];
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

-(BOOL)prefersStatusBarHidden {return YES;}

@end
