//
//  BBALevelController.m
//  BrickBreaker
//
//  Created by T.J. Mercer on 4/17/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "BBALevelController.h"

#import <AVFoundation/AVFoundation.h>

                                //used to tell when two objects touch eachother
@interface BBALevelController () <UICollisionBehaviorDelegate>

@property (nonatomic)AVAudioPlayer * player;

@property (nonatomic) UIView * paddle;

@property (nonatomic) NSMutableArray * balls;

@property (nonatomic) NSMutableArray * bricks;

//animator
@property (nonatomic) UIDynamicAnimator * animator;

//pushes the ball
@property (nonatomic) UIPushBehavior * pusher;

//handles collisions and what happens when they happen
@property (nonatomic) UICollisionBehavior * collider;

//item behavior properties. How individual objects react to each other.
@property (nonatomic) UIDynamicItemBehavior * paddleDynamicProperties;
@property (nonatomic) UIDynamicItemBehavior * ballsDynamicProperties;
@property (nonatomic) UIDynamicItemBehavior * bricksDynamicProperties;

// item attachment allows movement for the heavier objects.
@property (nonatomic) UIAttachmentBehavior * attacher;

@end

@implementation BBALevelController
{
    float paddleWidth;
    float points;
    float lives;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        lives = 3;
        self.bricks = [@[] mutableCopy];
        self.balls = [@[] mutableCopy];

        paddleWidth = 80;
        points = 0;
        
        self.view.backgroundColor = [UIColor colorWithWhite:0.1 alpha:1.0];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreen:)];
        [self.view addGestureRecognizer:tap];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)resetLevel
{
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    [self createPaddle];
    
    [self createBricks];
    
    [self.delegate lifeCount:(int)lives];
    
    
    
    
    self.ballsDynamicProperties = [self createPropertiesForItems:self.balls];
    self.ballsDynamicProperties.elasticity = 1.01;
    self.ballsDynamicProperties.resistance = 0.0;
    
    self.collider = [[UICollisionBehavior alloc] initWithItems:[self allItems]];
    self.collider.collisionDelegate = self;
    self.collider.collisionMode = UICollisionBehaviorModeEverything;
    
    self.bricksDynamicProperties = [self createPropertiesForItems:self.bricks];
    self.paddleDynamicProperties = [self createPropertiesForItems:@[self.paddle]];
    
    //    self.ballsDynamicProperties.allowsRotation = YES;
    self.ballsDynamicProperties = [self createPropertiesForItems:self.balls];
    self.ballsDynamicProperties.elasticity = 1.01;
    self.ballsDynamicProperties.resistance = 0.0;
    
    self.bricksDynamicProperties.allowsRotation = YES;
    self.bricksDynamicProperties.density = 5;
    self.bricksDynamicProperties.resistance = 0;
    self.bricksDynamicProperties.elasticity = 1.1;
    
    self.paddleDynamicProperties.density = 500000;
    self.paddleDynamicProperties.elasticity = 1.1;
    
    
    
    [self createBall];
    
//    self.collider.translatesReferenceBoundsIntoBoundary = YES;
    
}

-(void)playSoundWithName:(NSString *)soundName
{
    NSString * file = [[NSBundle mainBundle] pathForResource:soundName ofType:@"wav"];
    
    NSURL * url = [[NSURL alloc]initFileURLWithPath:file];
    
    self.player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    
    [self.player play];
}

-(void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item1 withItem:(id<UIDynamicItem>)item2 atPoint:(CGPoint)p
{
    if ([item1 isEqual:self.paddle]|| [item2 isEqual:self.paddle])
    {
        [self playSoundWithName:@"retro_click"];
    }
    
    UIView * tempBrick;
    for (UIView * brick in self.bricks)
    {
        for (UIView * ball in self.balls)
        {
            if ([item1 isEqual:ball] || [item2 isEqual:ball])
            {
                if([item1 isEqual:brick] || [item2 isEqual:brick])
                {
                if (brick.alpha == 0.5)
                    {
                        tempBrick = brick;
                        [brick removeFromSuperview];
                        [self.collider removeItem:brick];
                        points += brick.tag;
                        NSLog(@"Total Points = %f", points);
                        [self.delegate addPoints:(int)points];
                        [self pointLabelWithBrick:brick];
                    }
                brick.alpha = 0.5;
                }
            }
        }
    }
    [self.bricks removeObject:tempBrick];
    if(tempBrick != nil)
    {
        [self.bricks removeObjectIdenticalTo:tempBrick];
        [self playSoundWithName:@"electric_alert"];
    }
}

-(void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p
{
    if ([(NSString *)identifier isEqualToString:@"floor"])
    {
        UIView * ball = (UIView *)item;

        [ball removeFromSuperview];

        [self.collider removeItem:ball];
        [self.balls removeObject:ball];

        [self createBall];
        
        [self.delegate lifeCount:(int)lives];
        
        if (lives < 0)
        {
            if ([self.delegate respondsToSelector:@selector(gameDone)])
            {
                [self.delegate gameDone];
            }
        }
    }
}

-(void)createPaddle
{
    self.paddle = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - paddleWidth)/2, SCREEN_HEIGHT - 40, paddleWidth, 6)];
    
    self.paddle.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1];
    
    self.paddle.layer.cornerRadius = 3;
    
    [self.view addSubview:self.paddle];
    
    self.attacher=[[UIAttachmentBehavior alloc] initWithItem:self.paddle attachedToAnchor:CGPointMake(CGRectGetMidX(self.paddle.frame), CGRectGetMidY(self.paddle.frame))];
    [self.animator addBehavior:self.attacher];
}

-(void)pointLabelWithBrick:(UIView *)brick
{
    UILabel * label = [[UILabel alloc] initWithFrame:brick.frame];

    label.text = [NSString stringWithFormat:@"+%d",(int)brick.tag];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"HelveticaNeue" size:8];
    
    [self.view addSubview:label];
    
    [UIView animateWithDuration:0.4 animations:^{label.alpha = 0.0;
    } completion:^(BOOL finished) {
        [label removeFromSuperview];
    }];
}

-(UIDynamicItemBehavior *)createPropertiesForItems:(NSArray *)items
{
    UIDynamicItemBehavior * properties = [[UIDynamicItemBehavior alloc] initWithItems:items];
    
    properties.allowsRotation = NO;
    properties.friction = 0.0;
    
    [self.animator addBehavior:properties];

    return properties;
}

-(NSArray *)allItems
{
    NSMutableArray * items = [@[self.paddle] mutableCopy];
    
//    for (UIView * item in self.balls) [items addObject:item];
    for (UIView * item in self.bricks) [items addObject:item];
//    NSLog(@"%@", items);
    
    return items;
}

-(void)createBricks
{
    int brickCols = 15;
    int brickRows = 4;
    
    float brickWidth = (SCREEN_WIDTH - (10 *(brickCols + 1))) / brickCols;
    float brickHeight = brickWidth;
    
    for (int i = 0; i <brickCols; i++)
    {
        for (int r = 0; r < brickRows; r++)
        {
            float brickX = ((brickWidth + 10) * i) + 10;
            float brickY = ((brickHeight + 10) * r) + 10;
            
            UIView * brick = [[UIView alloc] initWithFrame:CGRectMake(brickX, brickY, brickWidth, brickHeight)];
            brick.layer.cornerRadius = brickWidth / 2;
            brick.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1.0];
            
            int random = (arc4random_uniform(5) * 50) + 50;
            
            brick.tag = random;
            
            [self.view addSubview:brick];
            [self.bricks addObject:brick];
        }
    }
}

-(void)createBall
{
    NSLog(@"%f", lives);
    lives = lives - 1;
    
    if (lives >= 0)
    {
    CGRect frame = self.paddle.frame;
    
    UIView * ball = [[UIView alloc]initWithFrame:CGRectMake(frame.origin.x - 30, frame.origin.y -45, 15, 15)];
    //uiimageview * ball = [uiimageview
    
    ball.backgroundColor = [UIColor whiteColor];
    ball.layer.cornerRadius = 7.5;
    
    [self.view addSubview:ball];

    //add balls to ball array
    [self.balls addObject:ball];
        
        [self.collider addItem:ball];
        [self.ballsDynamicProperties addItem:ball];
    
    int w = self.view.frame.size.width;
    int h = self.view.frame.size.width;
    
    [self.collider addBoundaryWithIdentifier:@"ceiling" fromPoint:CGPointMake(0,0) toPoint:CGPointMake(w, 0)];
    [self.collider addBoundaryWithIdentifier:@"leftWall" fromPoint:CGPointMake(0,0) toPoint:CGPointMake(0, h)];
    [self.collider addBoundaryWithIdentifier:@"rightWall" fromPoint:CGPointMake(w,0) toPoint:CGPointMake(w, h)];
    [self.collider addBoundaryWithIdentifier:@"floor" fromPoint:CGPointMake(0,h-20) toPoint:CGPointMake(w, h-20)];
    
    [self.animator addBehavior: self.collider];

        NSLog(@"%@", self.balls);
    
    //start ball with a push
    self.pusher = [[UIPushBehavior alloc] initWithItems:self.balls mode:UIPushBehaviorModeInstantaneous ];
    
    //vector numbers control angle and speed. if each number is the same then they fall at a forty five degree angle. X postive moves right, X negative moves left. Y positive moves down, Y negative moves up. So -2, 2 would be 45 degrees down left because numbers are the same, direction is not.
    self.pusher.pushDirection = CGVectorMake(0.03, 0.03);
    self.pusher.active = YES; // only happens once because it's instantaneous.
    [self.animator addBehavior:self.pusher];
    }
}

-(void)tapScreen:(UITapGestureRecognizer *)gr
{
    CGPoint location = [gr locationInView:self.view];
    
    self.attacher.anchorPoint = CGPointMake(location.x, self.attacher.anchorPoint.y);
}

@end
