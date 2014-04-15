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
    
    UIView * gameBoard;
    
    UIButton * startButton;

    UIButton * four;
    
    UIButton * eight;
    
    UIButton * twelve;
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
        
        startButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/5, (SCREEN_HEIGHT/10)-30, SCREEN_WIDTH*.6, 50)];
        startButton.backgroundColor = ORANGE_COLOR;
        startButton.layer.cornerRadius = startButton.frame.size.width / 10;        
        [startButton setTitle:@"New Game" forState:normal];
        [startButton addTarget:self action:@selector(gridSize) forControlEvents:UIControlEventTouchUpInside];
        startButton.layer.masksToBounds = YES;
        [self.view addSubview:startButton];
        
        UIButton * halfView = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH*.6)/2, 0, (SCREEN_WIDTH*.6)/2, 50)];
        halfView.backgroundColor = BLUE_COLOR;
        [halfView addTarget:self action:@selector(gridSize) forControlEvents:UIControlEventTouchUpInside];
        [startButton addSubview:halfView];
        
        
//        gameBoard = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//        gameBoard.backgroundColor = [UIColor clearColor];
//        [self.view addSubview:gameBoard];
        
        startButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20];
        
        [self.view addSubview:startButton];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    four = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/2)-40, (SCREEN_HEIGHT/5)-35, 80, 80)];
    four.backgroundColor = BLUE_COLOR;
    four.tag = 4;
    four.layer.cornerRadius = four.frame.size.width/10;
    [four addTarget:self action:@selector(resetGame:) forControlEvents:UIControlEventTouchUpInside];
    [four setTitle:@"4" forState:normal];
    
    eight = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/2)-80, (SCREEN_HEIGHT/5)+45, 160, 160)];
    eight.backgroundColor = [UIColor blackColor];
    eight.tag = 8;
    eight.layer.cornerRadius = eight.frame.size.width/10;
    [eight addTarget:self action:@selector(resetGame:) forControlEvents:UIControlEventTouchUpInside];
    [eight setTitle:@"8" forState:normal];
    
    twelve = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH/2)-120, (SCREEN_HEIGHT/5)+205, 240, 240)];
    twelve.backgroundColor = ORANGE_COLOR;
    twelve.tag = 12;
    twelve.layer.cornerRadius = twelve.frame.size.width/10;
    [twelve addTarget:self action:@selector(resetGame:) forControlEvents:UIControlEventTouchUpInside];
    [twelve setTitle:@"12" forState:normal];
    
   
}

-(void) gridSize
{
    [startButton setTitle:@"New Game" forState:normal];
    [self.view addSubview:four];
    
    [self.view addSubview:eight];
    
    [self.view addSubview:twelve];
    
    [gameBoard removeFromSuperview];

}

-(void) resetGame: (id) sender
{
    NSLog(@"button pressed");
    
    [startButton setTitle:@"Restart" forState:normal];
    
    int boardHeight = SCREEN_HEIGHT-(SCREEN_HEIGHT/5);
    
    gameBoard = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT/5, SCREEN_WIDTH, boardHeight)];
    gameBoard.backgroundColor = [UIColor clearColor];

    
    [self.view addSubview:gameBoard];
    
    UIButton * button = (UIButton *)sender;

    gameSize = button.tag;

    float circleWidth = SCREEN_WIDTH / gameSize;
    float squareWidth = circleWidth/1.5;
    float squareOffset = circleWidth - (circleWidth / 2 );

// create squares
    for (int sRow = 0; sRow < gameSize - 1; sRow++)
    {
        for (int sCol = 0; sCol < gameSize - 1; sCol++)
        {
            float squareX = squareOffset + (circleWidth * sCol);
            float squareY = squareOffset + (circleWidth * sRow) + ((boardHeight - SCREEN_WIDTH) / 2);
            
//            float squareX = ((circleWidth - squareWidth) * 1.5) + (circleWidth * sCol);
//            float SquareY = ((circleWidth - squareWidth) * 1.5) + (circleWidth * sRow) +((SCREEN_HEIGHT - SCREEN_WIDTH) / 2);
            
            SCGSquare * square = [[SCGSquare alloc] initWithFrame:CGRectMake(squareX, squareY, circleWidth, circleWidth)];
            
            square.backgroundColor = [UIColor clearColor];
            square.layer.cornerRadius = squareWidth/4;
            NSString * key = [NSString stringWithFormat:@"c%dr%d", sCol,sRow];
            allSquares [key] = square;
            
            [gameBoard addSubview:square];
        }
    }

//create circles

    for (int row = 0; row < gameSize; row++)
    {
        for (int col = 0; col < gameSize; col++)
        {
            float circleX = circleWidth * col;
            float circleY = (circleWidth * row) + (boardHeight - SCREEN_WIDTH)/2;
            
            SCGCircle * circle = [[SCGCircle alloc] initWithFrame:CGRectMake(circleX, circleY, circleWidth, circleWidth)];
            
            circle.position = (CGPoint){col,row};
            circle.delegate=self;
            
            NSString * key = [NSString stringWithFormat:@"c%dr%d", col,row];
            tappedDots [key] = @2;
            
            [gameBoard addSubview:circle];
        }
    }
    [four removeFromSuperview];
    [eight removeFromSuperview];
    [twelve removeFromSuperview];
}

-(UIColor *)circleTappedWithPosition:(CGPoint)position
{
    //get tappedDots key from position
    NSString * key = [NSString stringWithFormat:@"c%dr%d", (int)position.x, (int)position.y];
    
    //set player num to value in tappedDots
    
    
    if ([tappedDots [key] isEqualToValue:@2]) {
        tappedDots [key] = @(playerTurn);
        
        NSLog(@"%@", tappedDots [key]);
        
        //check for square
        [self checkForSquareAroundPosition:position];
        
        UIColor * currentColor = playerColors[playerTurn];
        
        playerTurn = (playerTurn) ? 0 : 1;
        
        return currentColor;
    }else if([tappedDots [key] isEqualToValue: @(playerTurn)])
    {
        UIColor * currentColor = playerColors[playerTurn];
        return currentColor;
    }else{
        tappedDots [key] = @2;
        playerTurn = (playerTurn) ? 0 : 1;
        return [UIColor blackColor];
    }
}

//    if ([tappedDots [key] isEqualToValue:@2])
//    {
//        return currentColor;
//    } else {
//        tappedDots [key] = @2;
//        return [UIColor colorWithWhite:0.5 alpha:1.0];
//    }


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
//        for (UIColor * color in playerColors)
//        {
//            int player = [playerColors indexOfObject:color];
            
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
            
            if (currentSquare.backgroundColor != [UIColor clearColor])
            {
                return;
            } 
            //top, left, and bottom dots the same as player... then they own square
            if (topDotsSame && bottomDotsSame && leftDotsSame && [tappedDots[topLeftDot] isEqual:@(playerTurn)])
            {
                //player owns sqare
                currentSquare.backgroundColor = playerColors[playerTurn];
            }
//        }
    }
    
    if (above && right)
    {
//        for (UIColor * color in playerColors)
//        {
//            int player = [playerColors indexOfObject:color];
            
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
            
            if (currentSquare.backgroundColor != [UIColor clearColor])
            {
                return;
            }
            //top, left, and bottom dots the same as player... then they own square
            if (topDotsSame && bottomDotsSame && leftDotsSame && [tappedDots[topLeftDot] isEqual:@(playerTurn)])
            {
                //player owns sqare
                currentSquare.backgroundColor = playerColors[playerTurn];
            }
//        }
    }
    
    if (below && left)
    {
//        for (UIColor * color in playerColors)
//        {
//            int player = [playerColors indexOfObject:color];
        
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
            
            if (currentSquare.backgroundColor != [UIColor clearColor])
            {
                return;
            }
            //top, left, and bottom dots the same as player... then they own square
            if (topDotsSame && bottomDotsSame && leftDotsSame && [tappedDots[topLeftDot] isEqual:@(playerTurn)])
            {
                //player owns sqare
                currentSquare.backgroundColor = playerColors[playerTurn];
            }
//        }
    }
    
    if (below && right)
    {
//        for (UIColor * color in playerColors)
//        {
//            int player = [playerColors indexOfObject:color];
        
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
            
            if (currentSquare.backgroundColor != [UIColor clearColor])
            {
                return;
            }
            //top, left, and bottom dots the same as player... then they own square
            if (topDotsSame && bottomDotsSame && leftDotsSame && [tappedDots[topLeftDot] isEqual:@(playerTurn)])
            {
                //player owns sqare
                currentSquare.backgroundColor = playerColors[playerTurn];
            }
//        }
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
