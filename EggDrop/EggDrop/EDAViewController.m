//
//  EDAViewController.m
//  EggDrop
//
//  Created by T.J. Mercer on 5/22/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "EDAViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface EDAViewController ()

@end

@implementation EDAViewController
{
    CMMotionManager * mManager;
    BOOL eggIsFalling;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    mManager = [[CMMotionManager alloc]init];
    
    [mManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
       
        float roll = motion.attitude.roll * 10;
//        float y = motion.userAcceleration.y;
        
        if (!eggIsFalling)self.egg.frame = CGRectOffset(self.egg.frame, roll, 0);
        
        float eggMidX = CGRectGetMidX(self.egg.frame);
        float spoonMidX = CGRectGetMidX(self.spoon.frame);
        
        if (fabs(spoonMidX - eggMidX) > self.egg.frame.size.width/2&& !eggIsFalling)
        {
            eggIsFalling = YES;
            
//            self.egg.frame = CGRectOffset(self.egg.frame, self.egg.frame.size.width/4, self.egg.frame.size.height/4);
            
            float x = self.egg.frame.origin.x + self.egg.frame.size.width/4.0;
            float y = self.egg.frame.origin.y + self.egg.frame.size.height/4;
            float w = self.egg.frame.size.width/2;
            float h = self.egg.frame.size.height/2;
            
            self.egg.frame = CGRectMake(x, y, w, h);
            
//            [UIView animateWithDuration:0.3 animations:^{
//                self.egg.transform = CGAffineTransformScale(CGAffineTransformIdentity, .25, .25);
//            
//            }];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%f",self.spoon.frame.origin.x);
    for (UITouch * touch in touches)
    {
        [self moveSpoonTo:touch];
    }
}

-(void)moveSpoonTo:(UITouch *)touch
{
    CGPoint location = [touch locationInView:self.view];
    
    float x = location.x - (self.spoon.frame.size.width/2);
    float y = self.spoon.frame.origin.y;
    float w = self.spoon.frame.size.width;
    float h = self.spoon.frame.size.height;
    float hY = self.spoon.frame.origin.y + (h/2);
    
    CGRect spoonHandle = CGRectMake(x, hY, w, h);
    
    if (CGRectContainsPoint(spoonHandle, location))
    {
        self.spoon.frame = CGRectMake(x, y, w, h);
    }else{
        return;
    }
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch * touch in touches)
    {
        [self moveSpoonTo:touch];
    }
}

@end
