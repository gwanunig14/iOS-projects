//
//  SMSSelectorScreen.m
//  Smiley Status
//
//  Created by T.J. Mercer on 5/19/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SMSSelectorScreen.h"
#import "STTwitter.h"
#import "SMSData.h"

@interface SMSSelectorScreen ()

@end

@implementation SMSSelectorScreen
{
    STTwitterAPI * twitter;
    
    NSMutableArray * inUse;
    NSMutableArray * senders;
    NSMutableString * sharedString;
    
    UIImageView * grid;
    UIImageView * highlightPosition;
    UIImageView * smileyToShare;
    
    UIImage * backArrow;
    
    UIButton * nextStep;
    UIButton * finalStep;
    UIButton * twitterButton;
    UIButton * facebookButton;
    
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
        
        twitter = [STTwitterAPI twitterAPIOSWithFirstAccount];
        [twitter verifyCredentialsWithSuccessBlock:^(NSString *username) {
            NSLog(@"%@",username);
        } errorBlock:^(NSError *error) {
            NSLog(@"%@",error.userInfo);
        }];
        
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
    
    smileyToShare = [[UIImageView alloc] initWithFrame:CGRectMake(68, 192, 192, 192)];
    smileyToShare.image = [UIImage imageNamed:selectedArray[nextArray]];
    [inUse addObject:smileyToShare];
    [self.view addSubview:smileyToShare];
    
    sharedString = selectedArray[nextArray];
    
    twitterButton = [[UIButton alloc] initWithFrame:CGRectMake(84, 48, 48, 48)];
    [twitterButton setImage: [UIImage imageNamed:@"sm_twitter_g"] forState:UIControlStateNormal];
    [twitterButton setImage:[UIImage imageNamed:@"sm_twitter"] forState:UIControlStateSelected];
    [twitterButton addTarget:self action:@selector(setState:) forControlEvents:UIControlEventTouchUpInside];
    [inUse addObject:twitterButton];
    [self.view addSubview:twitterButton];
    
    facebookButton = [[UIButton alloc] initWithFrame:CGRectMake(194, 48, 48, 48)];
    [facebookButton setImage: [UIImage imageNamed:@"sm_facebook_g"] forState:UIControlStateNormal];
    [facebookButton setImage:[UIImage imageNamed:@"sm_facebook"] forState:UIControlStateSelected];
    [facebookButton addTarget:self action:@selector(setState:) forControlEvents:UIControlEventTouchUpInside];
    [inUse addObject:facebookButton];
    [self.view addSubview:facebookButton];
    
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
            grid.image = [UIImage imageNamed:array[index]];
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
    NSLog(@"%@",sharedString);
    NSURL * url = [[NSURL alloc]initFileURLWithPath:sharedString];
    NSLog(@"%@", url);

    if ([senders containsObject:twitterButton]) {
        [twitter postStatusUpdate:@"I'm feeling" inReplyToStatusID:nil mediaURL:url placeID:nil latitude:nil longitude:nil uploadProgressBlock:^(NSInteger bytesWritten, NSInteger totalBytesWritten, NSInteger totalBytesExpectedToWrite) {
            NSLog(@"%@",url);
        } successBlock:^(NSDictionary *status) {
        
        } errorBlock:^(NSError *error) {
            NSLog(@"error %@", error.userInfo);
        }];
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

@end
