//
//  CARRootViewController.m
//  Car
//
//  Created by T.J. Mercer on 4/1/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "CARRootViewController.h"

@interface CARRootViewController ()

@end

@implementation CARRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CARWheel * wheel1 = [[CARWheel alloc] init];
    wheel1.frame = CGRectMake(40, 65, 40, 80);
    wheel1.tirePressure = 24;
    [self.view addSubview:wheel1];
    CARWheel * wheel2 = [[CARWheel alloc] init];
    wheel2.frame = CGRectMake(40, 325, 40, 80);
    wheel2.tirePressure = 28;
    [self.view addSubview:wheel2];
    CARWheel * wheel3 = [[CARWheel alloc] init];
    wheel3.frame = CGRectMake(230, 65, 40, 80);
    [self.view addSubview:wheel3];
    CARWheel * wheel4 = [[CARWheel alloc] init];
    wheel4.frame = CGRectMake(230, 325, 40, 80);
    [self.view addSubview:wheel4];
    
    
    CARBumper *bumper1 = [[CARBumper alloc] init];
    bumper1.frame = CGRectMake(50, 40, 210, 20);
    [self.view addSubview:bumper1];
    CARBumper *bumper2 = [[CARBumper alloc] init];
    bumper2.frame = CGRectMake(40, 410, 230, 40);
    [self.view addSubview:bumper2];
    
    
    CARWindow *window1 = [[CARWindow alloc] init];
    window1.frame = CGRectMake(60, 150, 5, 70);
    [self.view addSubview:window1];
    CARWindow *window2 = [[CARWindow alloc] init];
    window2.frame = CGRectMake(60, 235, 5, 85);
    [self.view addSubview:window2];
    CARWindow *window3 = [[CARWindow alloc] init];
    window3.frame = CGRectMake(250, 150, 5, 70);
    [self.view addSubview:window3];
    CARWindow *window4 = [[CARWindow alloc] init];
    window4.frame = CGRectMake(250, 235, 5, 85);
    [self.view addSubview:window4];
    

    CARGasPedal *gas =[[CARGasPedal alloc] init];
    gas.frame = CGRectMake(150, 170, 20, 30);
    [self.view addSubview:gas];
    [gas setTitle:@"GO" forState:UIControlStateNormal];
    [gas addTarget:self action:@selector(pressGasPedal) forControlEvents:UIControlEventTouchUpInside];
    
    CARBrake *brake = [[CARBrake alloc] init];
    brake.frame = CGRectMake(125, 170, 20, 30);
    [self.view addSubview:brake];
    [brake setTitle:@"STOP" forState:UIControlStateNormal];
    [brake addTarget:self action:@selector(pressBrake) forControlEvents:UIControlEventTouchUpInside];
    
    CARIgnition *start = [[CARIgnition alloc] init];
    start.frame = CGRectMake(110, 120, 40, 40);
    [self.view addSubview:start];
    [start setTitle:@"START" forState:UIControlStateNormal];
    [start addTarget:self action:@selector(pressIgnition) forControlEvents:UIControlEventTouchUpInside];
    
    start.titleLabel.font = [UIFont boldSystemFontOfSize:10];
    [start.titleLabel setTextColor: [UIColor purpleColor]];
    
    gas.titleLabel.font = [UIFont boldSystemFontOfSize:7];
    [gas.titleLabel setTextColor: [UIColor redColor]];
    brake.titleLabel.font = [UIFont boldSystemFontOfSize:7];
    [brake.titleLabel setTextColor: [UIColor greenColor]];
    
}

- (void)pressGasPedal

{
    NSLog(@"pressed gas");
}

- (void)pressBrake

{
    NSLog(@"pressed brake");
}

- (void)pressIgnition

{
    NSLog(@"pressed start");
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
