//
//  PNAWorld2.m
//  PixelNoise
//
//  Created by T.J. Mercer on 5/6/14.
//  Copyright (c) 2014 Heidi Proske. All rights reserved.
//

#import "PNAWorld2.h"
#import "PNAPixelSounds.h"

@interface PNAWorld2 () <UICollisionBehaviorDelegate>

@property (nonatomic) UIDynamicAnimator * animator;
@property (nonatomic) UIGravityBehavior  * gravity;
@property (nonatomic) UICollisionBehavior * collision;
@property (nonatomic) UIDynamicItemBehavior * shardBehavior;
@property (nonatomic) UICollisionBehavior * shardCollision;

@end

@implementation PNAWorld2
{
    NSArray * colors;
    NSArray * splatterDirections;
    PNAPixelSounds * sounds;
//    UIView * w ater;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        sounds = [[PNAPixelSounds alloc]init];
        
//        int y = .5;
        splatterDirections = @[
                               [NSValue valueWithCGPoint:CGPointMake(0.075, -.5)],
                               [NSValue valueWithCGPoint:CGPointMake(0.05, -.5)],
                               [NSValue valueWithCGPoint:CGPointMake(0.025, -.5)],
                               [NSValue valueWithCGPoint:CGPointMake(-0.025,-.5)],
                               [NSValue valueWithCGPoint:CGPointMake(-0.05, -.5)],
                               [NSValue valueWithCGPoint:CGPointMake(-0.075, -.5)]
                               ];
        
        self.animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
        
        self.gravity = [[UIGravityBehavior alloc]init];
        [self.animator addBehavior: self.gravity];
        
        self.collision = [[UICollisionBehavior alloc] init];
        self.collision.translatesReferenceBoundsIntoBoundary = YES;
        self.collision.collisionDelegate = self;
        
        self.shardBehavior = [[UIDynamicItemBehavior alloc]init];
        self.shardBehavior.density = 25;
        [self.animator addBehavior:self.shardBehavior];
        
        self.shardCollision = [[UICollisionBehavior alloc] init];
        self.shardCollision.translatesReferenceBoundsIntoBoundary = YES;
        self.shardCollision.collisionDelegate = self;
        [self.animator addBehavior:self.shardCollision];
        
        [self.animator addBehavior:self.collision];
        
        colors = @[[UIColor redColor],
                   [UIColor orangeColor],
                   [UIColor yellowColor],
                   [UIColor greenColor],
                   [UIColor blueColor],
                   [UIColor purpleColor]];
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch * touch in touches)
        [self createBlockWithLocation:[touch locationInView:self.view]];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch * touch in touches)
        [self createBlockWithLocation:[touch locationInView:self.view]];
}

-(void)createBlockWithLocation:(CGPoint)location
{
//    for (UIColor * color in colors)
//    {
//        UIView * block = [[UIView alloc]initWithFrame:CGRectMake(location.x, location.y, 10, 10)];
//        block.backgroundColor = color;
//        [self.view addSubview:block];
//        [self.gravity addItem:block];
//        [self.collision addItem:block];
//    }
    
//    for (int i = 0; i <[colors count]; i++)
//    {
        UIView * block = [[UIView alloc]initWithFrame:CGRectMake(location.x, location.y, 10, 10)];
//        UIColor * color = [colors objectAtIndex:i];
        block.backgroundColor = [UIColor blackColor];
        [self.view addSubview:block];
        [self.gravity addItem:block];
        [self.collision addItem:block];
//    }
}

-(void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p
{
    if ([behavior isEqual:self.collision])
    {
        UIView * block = (UIView *)item;
        [self createShardsWithLocation:p];
        [block removeFromSuperview];
        [self.collision removeItem:block];
        [sounds playSoundWithName:@"drip"];
    }
    if ([behavior isEqual:self.shardCollision]) {
        UIView * collidedShard = (UIView *)item;
        [self.gravity removeItem:collidedShard];
        [self.shardBehavior removeItem:collidedShard];
        [self.shardCollision removeItem:collidedShard];
        [collidedShard removeFromSuperview];
    }
}

-(void)createShardsWithLocation:(CGPoint)location
{
    for (NSValue * pointValue in splatterDirections)
    {
//        for (UIColor * color in colors)
//        {
            CGPoint direction = [pointValue CGPointValue];
            UIView * shard = [[UIView alloc]initWithFrame:CGRectMake(location.x, location.y-10, 5, 5)];
            shard.backgroundColor = [UIColor blueColor];
            [self.view addSubview:shard];
            
            UIPushBehavior * pusher = [[UIPushBehavior alloc]initWithItems:@[shard] mode:UIPushBehaviorModeInstantaneous];
            [self.animator addBehavior:pusher];
            [self.gravity addItem:shard];
            [self.shardBehavior addItem:shard];
            [self.shardCollision addItem:shard];
            pusher.pushDirection = CGVectorMake(direction.x, direction.y);
//        }
    }
}

@end
