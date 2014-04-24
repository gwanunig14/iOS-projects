//
//  STANavController.m
//  Story Aids
//
//  Created by T.J. Mercer on 4/23/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "STANavController.h"

#import "STATableViewController.h"

@interface STANavController ()

@end

@implementation STANavController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        UIButton * goBack = [[UIButton alloc]initWithFrame:CGRectMake(6, 6, 32, 32)];
        goBack.backgroundColor = [UIColor greenColor];
        goBack.layer.cornerRadius = 8;
        
        UIButton * newDescription = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-60, 6, 120, 32)];
        newDescription.backgroundColor = [UIColor blueColor];
        newDescription.layer.cornerRadius = 8;
        
        UIButton * viewAll = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-38, 6, 32, 32)];
        viewAll.backgroundColor = [UIColor redColor];
        viewAll.layer.cornerRadius = 8;
        
        [self.navigationBar addSubview:goBack];
        [self.navigationBar addSubview:newDescription];
        [self.navigationBar addSubview:viewAll];
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
