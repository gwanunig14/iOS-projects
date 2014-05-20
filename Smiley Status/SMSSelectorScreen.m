//
//  SMSSelectorScreen.m
//  Smiley Status
//
//  Created by T.J. Mercer on 5/19/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SMSSelectorScreen.h"

#import "SMSData.h"

@interface SMSSelectorScreen ()

@end

@implementation SMSSelectorScreen
{
    NSMutableArray * inUse;
    NSMutableArray * senders;
    
    UIImageView * grid;
    UIImageView * highlightPosition;
    
    UIImage * backArrow;
    
    UIButton * nextStep;
    UIButton * finalStep;
    
    int rows;
    int cols;
    int nextArray;
    int finalArray;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        senders = [@[]mutableCopy];
        
        nextArray = 0;
        finalArray = -1;
        
        inUse = [@[]mutableCopy];
        
        nextStep = [[UIButton alloc]initWithFrame:CGRectMake(242, 496, 64, 48)];
        [nextStep setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
        [nextStep addTarget:self action:@selector(pullSmileys) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:nextStep];
        
        finalStep = [[UIButton alloc]initWithFrame:CGRectMake(242, 496, 64, 48)];
        [finalStep setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
        [finalStep addTarget:self action:@selector(shareWindow) forControlEvents:UIControlEventTouchUpInside];
        
        UIImage * arrow = [UIImage imageNamed:@"arrow"];
        backArrow = [UIImage imageWithCGImage:arrow.CGImage scale:arrow.scale orientation: UIImageOrientationUpMirrored];
        
        rows = 3;
        cols = 3;
        
        [self createSquaresWithArray:[SMSData mainData].colors];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)pullSmileys
{
    [nextStep removeFromSuperview];

    [self.view addSubview:finalStep];

    if (finalArray == -1) {
        [self createSquaresWithArray:[SMSData mainData].littleSmileys[nextArray]];
    }else{
        [self createSquaresWithArray:[SMSData mainData].littleSmileys[finalArray]];
    }

    finalArray = nextArray;
    
    UIButton * backToColors = [[UIButton alloc] initWithFrame:CGRectMake(36, 496, 56, 48)];
    backToColors.tag = 0;
    [backToColors addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [inUse addObject:backToColors];
    [backToColors setImage:backArrow forState:UIControlStateNormal];
    [self.view addSubview:backToColors];
}

-(void)shareWindow
{
    [finalStep removeFromSuperview];
    [self removeThings];
    
    NSArray * selectedArray = [SMSData mainData].bigSmileys[finalArray];
    
    UIImageView * smileyToShare = [[UIImageView alloc] initWithFrame:CGRectMake(68, 192, 192, 192)];
    smileyToShare.image = selectedArray[nextArray];
    [inUse addObject:smileyToShare];
    [self.view addSubview:smileyToShare];
    
    UIButton * twitter = [[UIButton alloc] initWithFrame:CGRectMake(84, 48, 48, 48)];
    [twitter setImage: [UIImage imageNamed:@"sm_twitter_g"] forState:UIControlStateNormal];
    [twitter setImage:[UIImage imageNamed:@"sm_twitter"] forState:UIControlStateSelected];
    [twitter addTarget:self action:@selector(setState:) forControlEvents:UIControlEventTouchUpInside];
    [inUse addObject:twitter];
    [self.view addSubview:twitter];
    
    UIButton * google = [[UIButton alloc] initWithFrame:CGRectMake(139, 48, 48, 48)];
    [google setImage: [UIImage imageNamed:@"sm_google_g"] forState:UIControlStateNormal];
    [google setImage:[UIImage imageNamed:@"sM_google"] forState:UIControlStateSelected];
    [google addTarget:self action:@selector(setState:) forControlEvents:UIControlEventTouchUpInside];
    [inUse addObject:google];
    [self.view addSubview:google];
    
    UIButton * facebook = [[UIButton alloc] initWithFrame:CGRectMake(194, 48, 48, 48)];
    [facebook setImage: [UIImage imageNamed:@"sm_facebook_g"] forState:UIControlStateNormal];
    [facebook setImage:[UIImage imageNamed:@"sm_facebook"] forState:UIControlStateSelected];
    [facebook addTarget:self action:@selector(setState:) forControlEvents:UIControlEventTouchUpInside];
    [inUse addObject:facebook];
    [self.view addSubview:facebook];
    
    UIButton * backToSmileys = [[UIButton alloc] initWithFrame:CGRectMake(36, 496, 56, 48)];
    [backToSmileys addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    backToSmileys.tag = 1;
    [inUse addObject:backToSmileys];
    [backToSmileys setImage:backArrow forState:UIControlStateNormal];
    [self.view addSubview:backToSmileys];
    
    UIButton * share = [[UIButton alloc]initWithFrame:CGRectMake(242, 496, 64, 40)];
    [share setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
    [share addTarget:self action:@selector(shareStuff) forControlEvents:UIControlEventTouchUpInside];
    [inUse addObject:share];
    [self.view addSubview:share];
}

-(void)setState:(UIButton *)sender
{
    sender.selected = (sender.selected) ? 0 : 1;
    
    if ([sender isSelected])
    {
        [senders addObject:sender];
    } else {
        [senders removeObject:sender];
    }
}

-(void)createSquaresWithArray:(NSArray *)array;
{
    [self removeThings];
    [inUse removeAllObjects];
    
    for (int r = 0; r < cols; r++)
    {
        for (int i = 0; i < rows; i++)
        {
            float squareX = (64 * i) +68;
            float squareY = (64 * r) +192;
            
            int index = i+(r*3);
            
            grid = [[UIImageView alloc] initWithFrame:CGRectMake(squareX, squareY, 56, 56)];
            grid.image = array[index];
            
            grid.tag = [inUse count];
            
            [inUse addObject:grid];
            
            [self.view addSubview:grid];
            
            finalArray = -1;
        }
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    
    CGPoint location = [touch locationInView:self.view];

    [self buttonsWIthLocation:location];
}

-(void)buttonsWIthLocation:(CGPoint)location
{
    for (UIImageView * selection in inUse)
         {
             if (CGRectContainsPoint(selection.frame, location))
                 {
                     [highlightPosition removeFromSuperview];
                     
                     UIImage * highlight = [UIImage imageNamed:@"squares"];

                     highlightPosition = [[UIImageView alloc]initWithFrame:CGRectMake(selection.frame.origin.x-8, selection.frame.origin.y-8, 72, 72)];
                     highlightPosition.image = highlight;
                     
                     nextArray = (int)selection.tag;
                     
                     [self.view insertSubview:highlightPosition atIndex:0];
                 }
         }
}

-(void)back:(UIButton *)sender
{
    if (sender.tag == 1)
    {
        [self pullSmileys];
    } else {
        [self createSquaresWithArray:[SMSData mainData].colors];
        [finalStep removeFromSuperview];
        [self.view addSubview:nextStep];
    }
}

-(void)removeThings
{
    [highlightPosition removeFromSuperview];
    
    for (UIImageView * deadObject in inUse)
    {
        [deadObject removeFromSuperview];
    }
}

-(void)shareStuff
{
    NSLog(@"%@",senders);
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

@end
