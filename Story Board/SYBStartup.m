//
//  SYBStartup.m
//  Story Board
//
//  Created by T.J. Mercer on 5/15/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SYBStartup.h"
#import "SYBNewProjectView.h"
#import "SYBProjectList.h"

@interface SYBStartup () <SYBNewProjectViewDelegate,UITextFieldDelegate>

@end

@implementation SYBStartup
{
    SYBNewProjectView * newPopUp;
    SYBProjectList * loadPopUp;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        UIButton * newProject = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2)-100, 150, 200, 40)];
        newProject.backgroundColor = [UIColor redColor];
        [newProject addTarget:self action:@selector(openNewProjectWindow) forControlEvents:UIControlEventTouchUpInside];
        newProject.layer.cornerRadius = newProject.frame.size.height/4;
        [self.view addSubview:newProject];
        
        UIButton * loadProject = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2)-100, 250, 200, 40)];
        loadProject.backgroundColor = [UIColor redColor];
        loadProject.layer.cornerRadius = loadProject.frame.size.height/4;
        [loadProject addTarget:self action:@selector(loadProjects) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:loadProject];
        
        newPopUp = [[SYBNewProjectView alloc]init];
        loadPopUp = [[SYBProjectList alloc]init];
        
        newPopUp.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)loadProjects
{
    [self popUpWindow:loadPopUp];
}

-(void)openNewProjectWindow
{
    [self popUpWindow:newPopUp];
    [newPopUp addSubviews];
}

-(void)newProjectAdded
{
    
}

-(void)popUpWindow:(UIViewController *)window
{
    window.view.frame = CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2, 1, 1);
    [self.view addSubview:window.view];
    [UIView animateWithDuration:.5 animations:^{
        window.view.frame = CGRectMake(40, 120, SCREEN_WIDTH-80, SCREEN_HEIGHT-200);
    }];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
