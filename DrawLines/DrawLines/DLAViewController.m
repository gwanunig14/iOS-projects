//
//  DLAViewController.m
//  DrawLines
//
//  Created by T.J. Mercer on 4/15/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "DLAViewController.h"
#import "DLAStageLines.h"
#import "DLAStageScribble.h"

@interface DLAViewController ()

@end

@implementation DLAViewController
{
    DLAStageScribble *scribbleBoard;
    UIView * colorsDrawer;
    UISlider * size;
    float lineWidth;
    UIColor * lineColor;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.view.backgroundColor = [UIColor blackColor];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    lineColor = [UIColor purpleColor];
    lineWidth = 5.0;
    
//    scribbleBoard = [[DLAStageLines alloc]initWithFrame:self.view.frame];
    [self toggleStage];
//    [self.view addSubview:scribbleBoard];
    
    colorsDrawer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    [self.view addSubview:colorsDrawer];
    
    NSArray * colors = @[
                         [UIColor colorWithRed:0.251f green:0.251f blue:0.251f alpha:1.0f],
                         [UIColor colorWithRed:0.008f green:0.353f blue:0.431f alpha:1.0f],
                         [UIColor colorWithRed:0.016f green:0.604f blue:0.671f alpha:1.0f],
                         [UIColor colorWithRed:1.000f green:0.988f blue:0.910f alpha:1.0f],
                         [UIColor colorWithRed:1.000f green:0.298f blue:0.153f alpha:1.0f]
                         ];
    
    float buttonWidth = SCREEN_WIDTH / [colors count];
    
    for (UIColor * color in colors)
    {
        int index = [colors indexOfObject:color];
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(buttonWidth * index, 0, buttonWidth, 40)];
        button.backgroundColor = color;
        [button addTarget:self action:@selector(changeColor:) forControlEvents:UIControlEventTouchUpInside];
        [colorsDrawer addSubview:button];
    }
    
    size = [[UISlider alloc]initWithFrame:CGRectMake(20, SCREEN_HEIGHT - 60, 280, 23)];
    size.minimumValue = 1.0;
    size.maximumValue = 20.0;
    size.value = lineWidth;
    [size addTarget:self action:@selector(changeSize:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:size];
    
    UISwitch * toggleButton = [[UISwitch alloc]initWithFrame:CGRectMake(10, 60, 25, 25)];
    toggleButton.layer.cornerRadius = 12.5;
    toggleButton.backgroundColor = [UIColor clearColor];
    [toggleButton addTarget:self action:@selector(toggleStage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:toggleButton];
    
    UIButton * undoButton = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH * 0.8)-45, 60, 40, 40)];
    undoButton.layer.cornerRadius = 20;
    undoButton.backgroundColor = [UIColor yellowColor];
    [undoButton addTarget:self action:@selector(undoStage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:undoButton];
    
    UIButton * clearButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH -45, 60, 40, 40)];
    clearButton.layer.cornerRadius = 20;
    clearButton.backgroundColor = [UIColor redColor];
    [clearButton addTarget:self action:@selector(clearStage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clearButton];
    
}

-(void)undoStage
{
    [scribbleBoard undoStage];
}

-(void)clearStage
{
    [scribbleBoard clearStage];
}

-(void)toggleStage
{
    NSMutableArray * lines = scribbleBoard.lines;
    
    
    [scribbleBoard removeFromSuperview];
    if ([scribbleBoard isMemberOfClass:[DLAStageScribble class]])
    {
        scribbleBoard = [[DLAStageLines alloc] initWithFrame:self.view.frame];
    } else {
        scribbleBoard = [[DLAStageScribble alloc] initWithFrame:self.view.frame];
    }
    
    scribbleBoard.scribbleSize = lineWidth;
    scribbleBoard.scribbleColor = lineColor;
    
    if (lines != nil) scribbleBoard.lines = lines;
    
    [self.view insertSubview:scribbleBoard atIndex:0];
}

- (void)changeSize:(UISlider *)sender;
{
    scribbleBoard.scribbleSize = lineWidth = sender.value;
}

-(void)changeColor:(UIButton*)sender
{
    scribbleBoard.scribbleColor = lineColor = sender.backgroundColor;
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
