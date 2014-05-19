//
//  SABGameScene.m
//  Stuffed Animal Battle
//
//  Created by T.J. Mercer on 5/15/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SABGameScene.h"
#import "SABData.h"

@interface SABGameScene () <SKPhysicsContactDelegate>

@end

@implementation SABGameScene
{
    SKSpriteNode * player1;
    SKSpriteNode * player2;
    
    SKEmitterNode * fireball;
    
    SKTextureAtlas * atlas;
    SKTextureAtlas * danceAtlas;
    
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
        
        atlas = [SKTextureAtlas atlasNamed:@"char"];
        danceAtlas = [SKTextureAtlas atlasNamed:@"dance"];
        
        player1 = [SKSpriteNode spriteNodeWithImageNamed:atlas.textureNames[0]];
        player1.position = CGPointMake(SCREEN_WIDTH/4, 80);
        [self addChild:player1];
        SKPhysicsBody * player1Physics = [SKPhysicsBody bodyWithRectangleOfSize:player1.size];
        player1.physicsBody = player1Physics;
        
        NSMutableArray * textures = [@[]mutableCopy];
        
        for (int i = 1; i<danceAtlas.textureNames.count + 1; i++)
        {
            [textures addObject: [danceAtlas textureNamed:[NSString stringWithFormat:@"dance%d", i]]];
            NSLog(@"charframe%d", i);
        }
        
        SKAction * dance = [SKAction animateWithTextures:textures timePerFrame:0.2];
        SKAction * danceAllNight = [SKAction repeatActionForever:dance];
        [player1 runAction:danceAllNight];
        
        player2 = [SKSpriteNode spriteNodeWithImageNamed:atlas.textureNames[0]];
        player2.position = CGPointMake(SCREEN_WIDTH*0.75, 80);
        player2.userData = [@{@"type":@"player2"}mutableCopy];
        [self addChild:player2];
        SKPhysicsBody * player2Physics = [SKPhysicsBody bodyWithRectangleOfSize:player2.size];
        player2.physicsBody = player2Physics;
        player2.physicsBody.contactTestBitMask = 2;
    }
    return self;
}

-(void)update:(NSTimeInterval)currentTime
{
    
}

-(void)didBeginContact:(SKPhysicsContact *)contact
{
    NSLog(@"%f", [SABData mainData].player2Life);
    
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
            [SABData mainData].player2Life = [SABData mainData].player2Life - 5;
            
            NSLog(@"%f", [SABData mainData].player2Life);
            
            if ([SABData mainData].player2Life == 0)
            {
                NSString * partPath = [[NSBundle mainBundle]pathForResource:@"explosion" ofType:@"sks"];
                SKEmitterNode * explosion = [NSKeyedUnarchiver unarchiveObjectWithFile:partPath];
                explosion.position = player2.position;
                explosion.numParticlesToEmit = 100;
                [player2 removeFromParent];
            }
        }
    }
}

-(void)buttonClick:(UIButton *)sender withArray:(NSArray *)buttons
{
    NSLog(@"2");
    
    for (UIButton * button in buttons)
    {
        if ([button isEqual:sender])
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
//                        for (NSString * textureName in atlas.textureNames) {
//                            NSLog(@"%@",textureName);
//                        }
                        
                        NSMutableArray * textures = [@[]mutableCopy];
                        
                        for (int i = 1; i<atlas.textureNames.count + 1; i++)
                        {
                            [textures addObject: [atlas textureNamed:[NSString stringWithFormat:@"charframe%d", i]]];
                            NSLog(@"charframe%d", i);
                        }
                        
                        SKAction * setFrame2 = [SKAction animateWithTextures:textures timePerFrame:0.25];
                        
                        [player1 runAction:setFrame2];
                        
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
