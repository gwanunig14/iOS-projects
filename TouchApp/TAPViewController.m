//
//  TAPViewController.m
//  TouchApp
//
//  Created by T.J. Mercer on 5/7/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "TAPViewController.h"

#import "TAPTopViewController.h"
#import "TAPBottomViewController.h"

#import "TAPData.h"

@interface TAPViewController () <TAPTopViewControllerDelegate>

@end

@implementation TAPViewController
{
    TAPTopViewController * topHalf;
    TAPBottomViewController * bottomHalf;
    UILabel * blueBoard;
    UILabel * redBoard;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [TAPData colorData].redScore = 0;
        [TAPData colorData].blueScore = 0;
        topHalf = [[TAPTopViewController alloc]initWithNibName:nil bundle:nil];
        bottomHalf.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/2);
        [self.view addSubview:topHalf.view];
        
        bottomHalf = [[TAPBottomViewController alloc]initWithNibName:nil bundle:nil];
        bottomHalf.view.frame = CGRectMake(0, self.view.frame.size.height/2, self.view.frame.size.width, self.view.frame.size.height/2);
        bottomHalf.view.backgroundColor = [UIColor redColor];
        [self.view addSubview:bottomHalf.view];

        
        blueBoard = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-75, (self.view.frame.size.height/4)-75, 150, 150)];
        blueBoard.textColor = [UIColor redColor];
        blueBoard.font = [UIFont systemFontOfSize:100];
        blueBoard.textAlignment = NSTextAlignmentCenter;
        blueBoard.text = [NSString stringWithFormat:@"%d",[TAPData colorData].blueScore];
        [self.view addSubview:blueBoard];
        
        redBoard = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-75, (self.view.frame.size.height/4)*3-75, 150, 150)];
        redBoard.textColor = [UIColor blueColor];
        redBoard.textAlignment = NSTextAlignmentCenter;
        redBoard.font = [UIFont systemFontOfSize:100];
        redBoard.text = [NSString stringWithFormat:@"%d",[TAPData colorData].redScore];
        [self.view addSubview:redBoard];
        
        topHalf.delegate=self;
        bottomHalf.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateRedScore:(NSInteger)redScore andBlueScore:(NSInteger)blueScore
{
    redBoard.text = [NSString stringWithFormat:@"%d",redScore];
    blueBoard.text = [NSString stringWithFormat:@"%d",blueScore];
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
