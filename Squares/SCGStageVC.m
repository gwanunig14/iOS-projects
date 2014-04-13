//
//  SCGstageVC.m
//  Squares
//
//  Created by T.J. Mercer on 4/11/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SCGStageVC.h"
#import "SCGSquare.h"

@interface SCGStageVC ()

@end

@implementation SCGStageVC

{
    int gameSize;
    
    NSArray * playerColors;
    
    int playerTurn;
    
    NSMutableDictionary * tappedDots;
    
    NSMutableDictionary * allSquares;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

        playerColors = @[BLUE_COLOR,ORANGE_COLOR];

        playerTurn = 0;
        
        tappedDots = [@{} mutableCopy];
        
        allSquares = [@{} mutableCopy];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    gameSize = 15;
    
    float circleWidth = SCREEN_WIDTH / gameSize;
    float squareWidth = circleWidth * .75;
    
    // create squares
    for (int sRow = 0; sRow < gameSize - 1; sRow++)
    {
        for (int sCol = 0; sCol < gameSize - 1; sCol++)
        {
            float squareX = ((squareWidth) * 0.75) + (circleWidth * sCol);
            float SquareY = ((squareWidth) * 0.75) + (circleWidth * sRow) +((SCREEN_HEIGHT - SCREEN_WIDTH) / 2);

//            float squareX = ((circleWidth - squareWidth) * 1.5) + (circleWidth * sCol);
//            float SquareY = ((circleWidth - squareWidth) * 1.5) + (circleWidth * sRow) +((SCREEN_HEIGHT - SCREEN_WIDTH) / 2);
            
            SCGSquare * square = [[SCGSquare alloc] initWithFrame:CGRectMake(squareX, SquareY, squareWidth, squareWidth)];
            
            square.backgroundColor = [UIColor lightGrayColor];
            square.layer.cornerRadius = squareWidth/4;
            NSString * key = [NSString stringWithFormat:@"c%dr%d", sCol,sRow];
            allSquares [key] = square;
            
            [self.view addSubview:square];
        }
    }
    
    //create circles
    for (int row = 0; row < gameSize; row++)
    {
        for (int col = 0; col < gameSize; col++)
        {
            float circleX = circleWidth * col;
            float circleY = (circleWidth * row) + (SCREEN_HEIGHT - SCREEN_WIDTH)/2;
            
            SCGCircle * circle = [[SCGCircle alloc] initWithFrame:CGRectMake(circleX, circleY, circleWidth, circleWidth)];
            
            circle.position = (CGPoint){col,row};
            circle.delegate=self;
            
            NSString * key = [NSString stringWithFormat:@"c%dr%d", col,row];
            tappedDots [key] = @2;
            
            [self.view addSubview:circle];
        }
    
    }
}

-(UIColor *)circleTappedWithPosition:(CGPoint)position
{
    //get tappedDots key from position
    NSString * key = [NSString stringWithFormat:@"c%dr%d", (int)position.x, (int)position.y];
    
    //set player num to value in tappedDots
    tappedDots [key] = @(playerTurn);
    
    NSLog(@"%@", tappedDots [key]);
    
    //check for square
    [self checkForSquareAroundPosition:position];
    
    UIColor * currentColor = playerColors[playerTurn];

    playerTurn = (playerTurn) ? 0 : 1;
    
//    if ([tappedDots [key] isEqualToValue:@2])
//    {
//        return currentColor;
//    } else {
//        tappedDots [key] = @2;
//        return [UIColor colorWithWhite:0.5 alpha:1.0];
//    }

    return currentColor;
}

-(void)checkForSquareAroundPosition:(CGPoint)position
{
//    tappedDots = @{
//      @"r0c0": @0,
//      @"r0c1": @1,
//      @"r0c2":@2
//      };
    
//    x = col and y = row
    int pX = position.x;
    int pY = position.y;
    
    BOOL above = (pY > 0);
    BOOL below = (pY < gameSize - 1);
    BOOL left = (pX > 0);
    BOOL right = (pX < gameSize - 1);
    
    if (above && left)
    {
        for (UIColor * color in playerColors)
        {
            int player = [playerColors indexOfObject:color];
            
            // -1,-1 0,-1 -1,0 0,0
            
            NSString * topLeftDot = [NSString stringWithFormat:@"c%dr%d", pX-1,pY-1];
            NSString * topRightDot = [NSString stringWithFormat:@"c%dr%d", pX,pY-1];
            NSString * bottomLeftDot = [NSString stringWithFormat:@"c%dr%d", pX-1,pY];
            NSString * bottomRightDot = [NSString stringWithFormat:@"c%dr%d", pX,pY];
            
            //checks if dots are the same
            BOOL topDotsSame = ([tappedDots[topLeftDot] isEqualToValue:tappedDots[topRightDot]]);
            BOOL bottomDotsSame = ([tappedDots[bottomLeftDot] isEqualToValue:tappedDots[bottomRightDot]]);
            BOOL leftDotsSame = ([tappedDots[topLeftDot] isEqualToValue:tappedDots[bottomLeftDot]]);
            SCGSquare * currentSquare = allSquares [topLeftDot];
            
            if (currentSquare.backgroundColor != [UIColor lightGrayColor])
            {
                return;
            } 
            //top, left, and bottom dots the same as player... then they own square
            if (topDotsSame && bottomDotsSame && leftDotsSame && [tappedDots[topLeftDot] isEqual:@(player)])
            {
                //player owns sqare
                currentSquare.backgroundColor = color;
            }
        }
    }
    
    if (above && right)
    {
        for (UIColor * color in playerColors)
        {
            int player = [playerColors indexOfObject:color];
            
            // -1,-1 0,-1 -1,0 0,0
            
            NSString * topLeftDot = [NSString stringWithFormat:@"c%dr%d", pX,pY-1];
            NSString * topRightDot = [NSString stringWithFormat:@"c%dr%d", pX+1,pY-1];
            NSString * bottomLeftDot = [NSString stringWithFormat:@"c%dr%d", pX,pY];
            NSString * bottomRightDot = [NSString stringWithFormat:@"c%dr%d", pX+1,pY];
            
            //checks if dots are the same
            BOOL topDotsSame = ([tappedDots[topLeftDot] isEqualToValue:tappedDots[topRightDot]]);
            BOOL bottomDotsSame = ([tappedDots[bottomLeftDot] isEqualToValue:tappedDots[bottomRightDot]]);
            BOOL leftDotsSame = ([tappedDots[topLeftDot] isEqualToValue:tappedDots[bottomLeftDot]]);
            SCGSquare * currentSquare = allSquares [topLeftDot];
            
            if (currentSquare.backgroundColor != [UIColor lightGrayColor])
            {
                return;
            }
            //top, left, and bottom dots the same as player... then they own square
            if (topDotsSame && bottomDotsSame && leftDotsSame && [tappedDots[topLeftDot] isEqual:@(player)])
            {
                //player owns sqare
                currentSquare.backgroundColor = color;
            }
        }
    }
    
    if (below && left)
    {
        for (UIColor * color in playerColors)
        {
            int player = [playerColors indexOfObject:color];
            
            // -1,-1 0,-1 -1,0 0,0
            
            NSString * topLeftDot = [NSString stringWithFormat:@"c%dr%d", pX-1,pY];
            NSString * topRightDot = [NSString stringWithFormat:@"c%dr%d", pX,pY];
            NSString * bottomLeftDot = [NSString stringWithFormat:@"c%dr%d", pX-1,pY+1];
            NSString * bottomRightDot = [NSString stringWithFormat:@"c%dr%d", pX,pY+1];
            
            //checks if dots are the same
            BOOL topDotsSame = ([tappedDots[topLeftDot] isEqualToValue:tappedDots[topRightDot]]);
            BOOL bottomDotsSame = ([tappedDots[bottomLeftDot] isEqualToValue:tappedDots[bottomRightDot]]);
            BOOL leftDotsSame = ([tappedDots[topLeftDot] isEqualToValue:tappedDots[bottomLeftDot]]);
            
            SCGSquare * currentSquare = allSquares [topLeftDot];
            
            if (currentSquare.backgroundColor != [UIColor lightGrayColor])
            {
                return;
            }
            //top, left, and bottom dots the same as player... then they own square
            if (topDotsSame && bottomDotsSame && leftDotsSame && [tappedDots[topLeftDot] isEqual:@(player)])
            {
                //player owns sqare
                currentSquare.backgroundColor = color;
            }
        }
    }
    
    if (below && right)
    {
        for (UIColor * color in playerColors)
        {
            int player = [playerColors indexOfObject:color];
            
            // -1,-1 0,-1 -1,0 0,0
            
            NSString * topLeftDot = [NSString stringWithFormat:@"c%dr%d", pX,pY];
            NSString * topRightDot = [NSString stringWithFormat:@"c%dr%d", pX+1,pY];
            NSString * bottomLeftDot = [NSString stringWithFormat:@"c%dr%d", pX,pY+1];
            NSString * bottomRightDot = [NSString stringWithFormat:@"c%dr%d", pX+1,pY+1];
            
            //checks if dots are the same
            BOOL topDotsSame = ([tappedDots[topLeftDot] isEqualToValue:tappedDots[topRightDot]]);
            BOOL bottomDotsSame = ([tappedDots[bottomLeftDot] isEqualToValue:tappedDots[bottomRightDot]]);
            BOOL leftDotsSame = ([tappedDots[topLeftDot] isEqualToValue:tappedDots[bottomLeftDot]]);
            
            SCGSquare * currentSquare = allSquares [topLeftDot];
            
            if (currentSquare.backgroundColor != [UIColor lightGrayColor])
            {
                return;
            }
            //top, left, and bottom dots the same as player... then they own square
            if (topDotsSame && bottomDotsSame && leftDotsSame && [tappedDots[topLeftDot] isEqual:@(player)])
            {
                //player owns sqare
                currentSquare.backgroundColor = color;
            }
        }
    }
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

- (BOOL)prefersStatusBarHidden { return YES; }

@end
