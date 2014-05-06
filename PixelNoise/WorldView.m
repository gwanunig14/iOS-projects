//
//  WorldView.m
//  PixelNoise
//
//  Created by T.J. Mercer on 5/5/14.
//  Copyright (c) 2014 Heidi Proske. All rights reserved.
//

#import "WorldView.h"

#import "PNAPixelSounds.h"

@interface WorldView () <UICollisionBehaviorDelegate>

@property (nonatomic) UIDynamicAnimator * animator;

@property (nonatomic) UICollisionBehavior * collider;

@end

@implementation WorldView
{
    PNAPixelSounds * sounds;
    
    UIGravityBehavior * freeFall;
    
    NSMutableArray * squares;
    
    NSArray * sparkPaths;
    
    float x;
    float y;
    
    int bigBlock;
    
    CGPoint bombOrigin;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.view.backgroundColor = [UIColor blackColor];
        
        sounds = [[PNAPixelSounds alloc]init];
        
        squares = [@[]mutableCopy];
        
        self.animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
        
        NSLog(@"world loaded");
        
        bigBlock = 20;
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.collider = [[UICollisionBehavior alloc] initWithItems:@[]];
    self.collider.collisionDelegate = self;
    self.collider.collisionMode = UICollisionBehaviorModeEverything;
    self.collider.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:self.collider];
    
    freeFall = [[UIGravityBehavior alloc]initWithItems:@[]];
    [self.animator addBehavior:freeFall];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    for (UITouch * touch in touches)
    {
        CGPoint location = [touch locationInView:self.view];
        
        x = location.x - 3;
        
        y = location.y - 3;
    
        UIView * fallingSquare = [[UIView alloc]initWithFrame:CGRectMake(x, y, bigBlock, bigBlock)];
        fallingSquare.backgroundColor = [UIColor blueColor];
        
        [self.view addSubview:fallingSquare];
        
        [freeFall addItem:fallingSquare];
        [self.collider addItem:fallingSquare];
        [squares addObject:fallingSquare];
    }
    
    
    [self.view setNeedsDisplay];

}

-(void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p
{
    bombOrigin = p;
    if ([(NSString *)identifier isEqualToString:@"floor"])
    {
                UIView * fallingSquare = (UIView *)item;
                [sounds playSoundWithName:@"jar_deny"];
                [fallingSquare removeFromSuperview];
                [self.collider removeItem:fallingSquare];
                [self throwDebris];
    }

}

-(void)throwDebris
{
    UIView * debris1 = [[UIView alloc]initWithFrame:CGRectMake(bombOrigin.x, bombOrigin.y, bigBlock/5, bigBlock/5)];
    UIView * debris2 = [[UIView alloc]initWithFrame:CGRectMake(bombOrigin.x, bombOrigin.y, bigBlock/5, bigBlock/5)];
    UIView * debris3 = [[UIView alloc]initWithFrame:CGRectMake(bombOrigin.x, bombOrigin.y, bigBlock/5, bigBlock/5)];
    UIView * debris4 = [[UIView alloc]initWithFrame:CGRectMake(bombOrigin.x, bombOrigin.y, bigBlock/5, bigBlock/5)];
    UIView * debris5 = [[UIView alloc]initWithFrame:CGRectMake(bombOrigin.x, bombOrigin.y, bigBlock/5, bigBlock/5)];
    
    debris1.backgroundColor = [UIColor yellowColor];
    debris2.backgroundColor = [UIColor yellowColor];
    debris3.backgroundColor = [UIColor yellowColor];
    debris4.backgroundColor = [UIColor yellowColor];
    debris5.backgroundColor = [UIColor yellowColor];
    
    UIPushBehavior * throw1 = [[UIPushBehavior alloc]initWithItems:@[] mode:UIPushBehaviorModeInstantaneous];
    UIPushBehavior * throw2 = [[UIPushBehavior alloc]initWithItems:@[] mode:UIPushBehaviorModeInstantaneous];
    UIPushBehavior * throw3 = [[UIPushBehavior alloc]initWithItems:@[] mode:UIPushBehaviorModeInstantaneous];
    UIPushBehavior * throw4 = [[UIPushBehavior alloc]initWithItems:@[] mode:UIPushBehaviorModeInstantaneous];
    UIPushBehavior * throw5 = [[UIPushBehavior alloc]initWithItems:@[] mode:UIPushBehaviorModeInstantaneous];
    
    throw1.pushDirection = CGVectorMake(0.002, -.002);
    throw2.pushDirection = CGVectorMake(0.001, -.002);
    throw3.pushDirection = CGVectorMake(0.000, -.002);
    throw4.pushDirection = CGVectorMake(-0.001, -.002);
    throw5.pushDirection = CGVectorMake(-0.002, -.002);
    
    throw1.active = YES;
    throw2.active = YES;
    throw3.active = YES;
    throw4.active = YES;
    throw5.active = YES;
    
    [self.view addSubview:debris1];
    [self.view addSubview:debris2];
    [self.view addSubview:debris3];
    [self.view addSubview:debris4];
    [self.view addSubview:debris5];
    
    [throw1 addItem:debris1];
    [throw2 addItem:debris2];
    [throw3 addItem:debris3];
    [throw4 addItem:debris4];
    [throw5 addItem:debris5];
    
    [freeFall addItem:debris1];
    [freeFall addItem:debris2];
    [freeFall addItem:debris3];
    [freeFall addItem:debris4];
    [freeFall addItem:debris5];
    
    [self.animator addBehavior:throw1];
    [self.animator addBehavior:throw2];
    [self.animator addBehavior:throw3];
    [self.animator addBehavior:throw4];
    [self.animator addBehavior:throw5];
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
