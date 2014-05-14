//
//  DPAPondViewController.m
//  DigitalPond
//
//  Created by T.J. Mercer on 5/14/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "DPAPondViewController.h"

#import "DPARipple.h"

@interface DPAPondViewController ()

@end

@implementation DPAPondViewController

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
    // Do any additional setup after loading the view from its nib.
    
    NSLog(@"hello");
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self createRipplesWithTouches:touches];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self createRipplesWithTouches:touches];
}

-(void)createRipplesWithTouches:(NSSet *)touches
{
    for (UITouch * touch in touches)
    {
        CGPoint location = [touch locationInView:self.view];
        
        DPARipple * ripple = [[DPARipple alloc]initWithFrame:CGRectMake(location.x, location.y, 0, 0)];
        
        ripple.rippleCount = 3;
        ripple.rippleLifeTime = 15.0;
        [self.view addSubview:ripple];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
