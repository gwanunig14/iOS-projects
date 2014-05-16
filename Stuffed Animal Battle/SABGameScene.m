//
//  SABGameScene.m
//  Stuffed Animal Battle
//
//  Created by T.J. Mercer on 5/15/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SABGameScene.h"

@interface SABGameScene () <SKPhysicsContactDelegate>

@end

@implementation SABGameScene
{
    SKLabelNode * timerLabel;
    SKSpriteNode * player1HPBar;
    SKSpriteNode * player1Life;
    SKSpriteNode * player2HPBar;
    SKSpriteNode * player2Life;
    
    SKSpriteNode * buttonA;
    SKSpriteNode * buttonB;
    
    SKSpriteNode * dPadUp;
    SKSpriteNode * dPadDown;
    SKSpriteNode * dPadLeft;
    SKSpriteNode * dPadRight;
    
    SKSpriteNode * player1;
    SKSpriteNode * player2;
    
    SKEmitterNode * fireball;
    
    int fireDirection;
    int fireOrigin;
    int direction;
}

-(instancetype)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if (self)
    {
        SKPhysicsBody * scenePhysics = [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0, size.width, size.height)];
        self.physicsBody = scenePhysics;
        
        self.physicsWorld.contactDelegate = self;
        
        fireDirection = 3.0;
        fireOrigin = 26;
        direction = 1;
        
        SKSpriteNode * floor = [SKSpriteNode spriteNodeWithColor:[SKColor yellowColor] size: CGSizeMake (SCREEN_WIDTH, 30)];
        floor.position = CGPointMake(SCREEN_WIDTH/2.0, 15);
        SKPhysicsBody * floorPhysics = [SKPhysicsBody bodyWithRectangleOfSize:floor.size];
        floorPhysics.affectedByGravity = NO;
        floorPhysics.dynamic = NO;
        floor.physicsBody = floorPhysics;
        [self addChild:floor];
        
        timerLabel = [SKLabelNode node];
        timerLabel.position = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT - 30);
        timerLabel.text = @"00:00";
        timerLabel.fontColor = [SKColor greenColor];
        timerLabel.fontSize = 16;
        [self addChild:timerLabel];
        
        float barArea = ((SCREEN_WIDTH - 60)/2.0)-20;
        
        player1HPBar = [SKSpriteNode spriteNodeWithColor:[SKColor lightGrayColor] size:CGSizeMake(barArea, 20)];
        player1HPBar.position = CGPointMake((barArea+20)/2, SCREEN_HEIGHT - 20);
        [self addChild:player1HPBar];
        
        player1Life = [SKSpriteNode spriteNodeWithColor:[SKColor greenColor] size:CGSizeMake(barArea, 30)];
        player1Life.position = CGPointMake((barArea+20)/2, SCREEN_HEIGHT - 20);
        [self addChild:player1Life];
        
        player2HPBar = [SKSpriteNode spriteNodeWithColor:[SKColor lightGrayColor] size:CGSizeMake(barArea, 20)];
        player2HPBar.position = CGPointMake(SCREEN_WIDTH - (barArea+20)/2, SCREEN_HEIGHT - 20);
        [self addChild:player2HPBar];
        
        player2Life = [SKSpriteNode spriteNodeWithColor:[SKColor greenColor] size:CGSizeMake(barArea, 30)];
        player2Life.position = CGPointMake(SCREEN_WIDTH - (barArea+20)/2, SCREEN_HEIGHT - 20);
        [self addChild:player2Life];
        
        player1 = [SKSpriteNode spriteNodeWithColor:[SKColor whiteColor] size:CGSizeMake(40, 100)];
        player1.position = CGPointMake(SCREEN_WIDTH/4, 80);
        [self addChild:player1];
        SKPhysicsBody * player1Physics = [SKPhysicsBody bodyWithRectangleOfSize:player1.size];
        player1.physicsBody = player1Physics;
        
        player2 = [SKSpriteNode spriteNodeWithColor:[SKColor whiteColor] size:CGSizeMake(40, 100)];
        player2.position = CGPointMake(SCREEN_WIDTH*0.75, 80);
        player2.userData = [@{@"type":@"player2"}mutableCopy];
        [self addChild:player2];
        SKPhysicsBody * player2Physics = [SKPhysicsBody bodyWithRectangleOfSize:player2.size];
        player2.physicsBody = player2Physics;
        player2.physicsBody.contactTestBitMask = 2;
        
        buttonA = [SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(40, 40)];
        buttonA.position = CGPointMake(SCREEN_WIDTH - 40, 80);
        [self addChild:buttonA];
        
        buttonB = [SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(40, 40)];
        buttonB.position = CGPointMake(SCREEN_WIDTH - 80, 40);
        [self addChild:buttonB];
        
        dPadDown = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(30, 30)];
        dPadDown.position = CGPointMake(80, 40);
        [self addChild:dPadDown];
        
        dPadUp = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(30, 30)];
        dPadUp.position = CGPointMake(80, 120);
        [self addChild:dPadUp];
        
        dPadLeft = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(30, 30)];
        dPadLeft.position = CGPointMake(40, 80);
        [self addChild:dPadLeft];
        
        dPadRight = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(30, 30)];
        dPadRight.position = CGPointMake(120, 80);
        [self addChild:dPadRight];
        
    }
    return self;
}

-(void)update:(NSTimeInterval)currentTime
{
    
}

-(void)didBeginContact:(SKPhysicsContact *)contact
{
    NSLog(@"%@", contact);
    
    NSMutableArray * nodes = [@[]mutableCopy];
    
    if (contact.bodyA.node != nil) {[nodes addObject:contact.bodyA.node];}
    if (contact.bodyB.node != nil) {[nodes addObject:contact.bodyB.node];}
    
    for (SKNode * node in nodes)
    {
        if ([node.userData[@"type"] isEqualToString:@"fireball"])
        {
            [node removeFromParent];
            
            NSString * partPath = [[NSBundle mainBundle]pathForResource:@"explosion" ofType:@"sks"];
            SKEmitterNode * explosion = [NSKeyedUnarchiver unarchiveObjectWithFile:partPath];
            explosion.position = contact.contactPoint;
            explosion.numParticlesToEmit = 100;
            
            [self addChild:explosion];
        }
        if ([node.userData[@"type"] isEqualToString:@"fireball"])
        {
            if (player2Life.size.width >= 0)
            {
                player2Life.size = CGSizeMake(player2Life.size.width-23.1, 30);
                player2Life.position = CGPointMake(player2Life.position.x+11.55, SCREEN_HEIGHT - 20);
            } else {
                NSString * partPath = [[NSBundle mainBundle]pathForResource:@"explosion" ofType:@"sks"];
                SKEmitterNode * explosion = [NSKeyedUnarchiver unarchiveObjectWithFile:partPath];
                explosion.position = player2.position;
                explosion.numParticlesToEmit = 100;
                [player2 removeFromParent];
            }
        }
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    
    CGPoint location = [touch locationInNode:self];
    
    [self testButtonsWIthLocation:location];
}

-(void)testButtonsWIthLocation:(CGPoint)location
{
    NSArray * buttons = @[buttonA,buttonB,dPadUp,dPadDown,dPadLeft,dPadRight];
    
    for (SKNode * button in buttons)
    {
        if ([button containsPoint:location])
        {
            switch ([buttons indexOfObject:button]) {
                case 0:
                {
                    NSLog(@"fire");
                    NSString * partPath = [[NSBundle mainBundle]pathForResource:@"fireball" ofType:@"sks"];
                    SKAction * turn = [SKAction scaleXTo:direction duration:0];
                    fireball = [NSKeyedUnarchiver unarchiveObjectWithFile:partPath];
                    fireball.position = CGPointMake(player1.position.x + fireOrigin, player1.position.y);
                    SKPhysicsBody * fireballPhysics = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(10, 10)];
                    fireball.physicsBody = fireballPhysics;
                    fireballPhysics.affectedByGravity = NO;
                    fireball.physicsBody.contactTestBitMask = 1;
                    fireball.userData = [@{@"type":@"fireball"} mutableCopy];
                    [self addChild:fireball];
                    [fireball runAction:turn];
                    [fireball.physicsBody applyImpulse:CGVectorMake(fireDirection, 0)];
                }
                    break;
                case 1:
                    NSLog(@"Kick");
                    break;
                case 2:
                {
                    NSLog(@"Jump");
                    if (player1.size.height <= 50)
                    {
                        SKAction * stand1 = [SKAction scaleYTo:1 duration:0.1];
                        SKAction * stand2 = [SKAction moveToY:player1.position.y + 50 duration:0.1];
                        [player1 runAction:stand1];
                        [player1 runAction:stand2];
                    }else{
                        [player1.physicsBody applyImpulse:CGVectorMake(0.0, 100.0)];
                    }
                }
                    break;
                case 3:
                {
                    NSLog(@"Duck");
                    if (player1.size.height <= 50)
                    {
                        return;
                    }else{
                        SKAction * duck1 = [SKAction scaleYTo:0.5 duration:0.1];
                        SKAction * duck2 = [SKAction moveToY:player1.position.y - 50 duration:0.1];
                        [player1 runAction:duck1];
                        [player1 runAction:duck2];
                    }
                }
                    break;
                case 4:
                {
                    NSLog(@"Left");
                    fireDirection = -3.0;
                    direction = -1;
                    [player1.physicsBody applyImpulse:CGVectorMake(-20, 0.0)];
                    fireOrigin = -26;
                }
                    break;
                case 5:
                {
                    NSLog(@"Right");
                    fireDirection = 3.0;
                    direction = 1;
                    [player1.physicsBody applyImpulse:CGVectorMake(20, 0.0)];
                    fireOrigin = 26;
                }
                    break;
                    
                default:
                    break;
            }
        }
    }
}

@end
