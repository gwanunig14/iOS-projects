//
//  MGAViewController.m
//  MyGame
//
//  Created by T.J. Mercer on 6/10/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "MGAViewController.h"

#import <GameKit/GameKit.h>

@interface MGAViewController () <GKGameCenterControllerDelegate>

@end

@implementation MGAViewController
{
    GKLocalPlayer * player;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    player = [GKLocalPlayer localPlayer];
    
    if (!player.isAuthenticated) {
        MGAViewController * selfCopy = self;
        
        [player setAuthenticateHandler:^(UIViewController * viewController, NSError * error)
        {
            if (viewController) [selfCopy presentViewController:viewController animated:YES completion:nil];
            else [selfCopy playerReady];
        }];
    };
}

-(void)playerReady
{
    [player loadDefaultLeaderboardIdentifierWithCompletionHandler:^(NSString *leaderboardIdentifier, NSError *error) {
        
    }];
    
    [GKLeaderboard loadLeaderboardsWithCompletionHandler:^(NSArray *leaderboards, NSError *error) {
        for (GKLeaderboard * leaderboard in leaderboards) {
            NSLog(@"%@",leaderboard.identifier);
        }
    }];
    
    GKScore * scoreReporter = [[GKScore alloc]initWithLeaderboardIdentifier:@"blank"];
    
    scoreReporter.value = 20;
    scoreReporter.context = 0;
    
    [GKScore reportScores:@[scoreReporter] withCompletionHandler:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showLeaderBoard:(id)sender
{
    GKGameCenterViewController * gkVC = [[GKGameCenterViewController alloc]init];
    
    [gkVC setLeaderboardIdentifier:@"blank"];
    [gkVC setGameCenterDelegate:self];
    
    [self presentViewController:gkVC animated:YES completion:nil];
}

-(void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController
{
//    [self dismissViewControllerAnimated:YES completion:nil]
}
@end
