//
//  PTGViewController.m
//  Painting
//
//  Created by T.J. Mercer on 6/19/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "PTGViewController.h"

@interface PTGViewController ()

@end

@implementation PTGViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
//        self.navigationBar.tintColor = TOP_COLOR;
        [self.navigationBar setBarTintColor:[UIColor colorWithRed:87/255.0 green:87/255.0 blue:88/255.0 alpha:1]];
        
        self.navigationBar.translucent = NO;
        
        
//        UIView * bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.navigationBar.frame.size.width, self.navigationBar.frame.size.height+20)];
//        bar.backgroundColor = TOP_COLOR;
//        [self.view addSubview:bar];
        // Custom initialization
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
