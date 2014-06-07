//
//  BLOBMyScene.m
//  Blob
//
//  Created by T.J. Mercer on 6/3/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "BLOBMyScene.h"

@implementation BLOBMyScene
{
    SKSpriteNode * hill1;
    SKSpriteNode * hill2;
    SKSpriteNode * hill3;
}

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor blackColor];
        
        hill3 = [SKSpriteNode spriteNodeWithImageNamed:@"hill3"];
        hill3.position = CGPointMake(1024, 325);
        
        [self addChild:hill3];
        
        hill2 = [SKSpriteNode spriteNodeWithImageNamed:@"hill2"];
        hill2.position = CGPointMake(1024, 152.5);
        
        [self addChild:hill2];
        
        hill1 = [SKSpriteNode spriteNodeWithImageNamed:@"hill1"];
        hill1.position = CGPointMake(1024, 132.5);
        
        [self addChild:hill1];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
       
    }
}

-(void)update:(CFTimeInterval)currentTime
{
//    hill1.position = CGPointMake(hill1.position.x -30, hill1.position.y);
//    hill2.position = CGPointMake(hill2.position.x -20, hill2.position.y);
//    hill3.position = CGPointMake(hill3.position.x -10, hill3.position.y);
//    
    if (hill1.position.x < -1275) {
        hill1.position = CGPointMake(1024, hill1.position.y);
    }
    
    NSLog(@"%f",hill1.position.x);
}

@end
