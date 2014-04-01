//
//  TJFRootViewController.m
//  Day2 Class
//
//  Created by T.J. Mercer on 4/1/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "TJFRootViewController.h"

@interface TJFRootViewController ()

@end

@implementation TJFRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    CGRect rect = CGRectMake(30, 30, 160, 200);
    
    UIView *redView = [[UIView alloc] initWithFrame: rect];
    
    redView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:redView];
    
    
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
