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
{
    NSArray * colors;
    NSMutableArray * backgrounds;
    int currentBackgound;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.view.multipleTouchEnabled = YES;
        
        colors = @[
                   [UIColor colorWithRed:0.349f green:0.894f blue:0.553f alpha:1.0f],
                   [UIColor colorWithRed:0.945f green:0.337f blue:0.149f alpha:1.0f],
                   [UIColor colorWithRed:0.914f green:0.090f blue:0.420f alpha:1.0f],
                   [UIColor colorWithRed:0.255f green:0.075f blue:0.780f alpha:1.0f],
                   [UIColor colorWithRed:0.298f green:0.729f blue:0.867f alpha:1.0f]
                   ];
        
        backgrounds = [@[] mutableCopy];
        currentBackgound = 0;
        
        UIView * swipeArea = [[UIView alloc]initWithFrame:CGRectMake(20, 460, 280, 50)];
        swipeArea.backgroundColor= [UIColor colorWithWhite:0.0 alpha:0.1];
        [self.view addSubview:swipeArea];
        
        UISwipeGestureRecognizer * swipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
        swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
        
        UISwipeGestureRecognizer * swipeLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
        swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
        
        [swipeArea addGestureRecognizer:swipeRight];
        [swipeArea addGestureRecognizer:swipeLeft];
        // Custom initialization
    }
    return self;
}

-(void)swipe:(UISwipeGestureRecognizer *)gesture
{
    float w = self.view.frame.size.width;
    float h = self.view.frame.size.height;
    
    NSLog(@"%@",gesture);
    
    int direction = (gesture.direction == 1) ? 1 : -1;
    
    currentBackgound += direction;
    if (currentBackgound == [colors count]) currentBackgound = 0;
    if (currentBackgound == -1) currentBackgound = (int)[colors count] - 1;
    
    UIView * presentingBGView = [[UIView alloc]initWithFrame:CGRectMake((w * -direction), 0, w, h)];
    presentingBGView.backgroundColor = colors[currentBackgound];
    [backgrounds addObject:presentingBGView];
    [self.view insertSubview:presentingBGView atIndex:0];
    
    for (UIView * view in backgrounds)
    {
        [UIView animateWithDuration:1.0 animations:^{
            view.frame = CGRectMake(view.frame.origin.x + (w * direction), 0, w, h);
        } completion:^(BOOL finished) {
            if (index == 0)
            {
            [view removeFromSuperview];
            [backgrounds removeObject:view];
            }
        }];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidLoad];
    
    UIView * bgView = [[UIView alloc]initWithFrame:self.view.frame];
    bgView.backgroundColor = colors[currentBackgound];
    [self.view insertSubview:bgView atIndex:0];
    [backgrounds addObject:bgView];
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
    NSMutableArray * otherColors = [colors mutableCopy];
    [otherColors removeObjectAtIndex:currentBackgound];
    
    for (UITouch * touch in touches)
    {
        int random = arc4random_uniform((int)[otherColors count]);
        
        CGPoint location = [touch locationInView:self.view];
        
        DPARipple * ripple = [[DPARipple alloc]initWithFrame:CGRectMake(location.x, location.y, 0, 0)];
        
        ripple.tintColor = otherColors[random];
        
        ripple.rippleCount = (int)[otherColors count];
        ripple.rippleLifeTime = 10.0;
        [self.view addSubview:ripple];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
