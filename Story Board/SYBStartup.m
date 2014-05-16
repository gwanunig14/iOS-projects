//
//  SYBStartup.m
//  Story Board
//
//  Created by T.J. Mercer on 5/15/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SYBStartup.h"

@interface SYBStartup ()

@end

@implementation SYBStartup

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        UIButton * newProject = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2)-100, 150, 200, 40)];
        newProject.backgroundColor = [UIColor redColor];
        newProject.layer.cornerRadius = newProject.frame.size.height/4;
        [self.view addSubview:newProject];
        
        UIButton * loadProject = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2)-100, 250, 200, 40)];
        loadProject.backgroundColor = [UIColor redColor];
        loadProject.layer.cornerRadius = loadProject.frame.size.height/4;
        [loadProject addTarget:self action:@selector(loadProjects) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:loadProject];
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
    NSLog(@"pressed");
    UIViewController * loadScreen = [[UIViewController alloc]initWithNibName:nil bundle:nil];
    loadScreen.view.backgroundColor = [UIColor blackColor];
    
    UINavigationController * loadNC = [[UINavigationController alloc]initWithRootViewController: loadScreen];
    
    [self.navigationController presentViewController:loadNC animated:YES completion:^{
        
    }];
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
