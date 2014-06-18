//
//  EXPMainViewController.m
//  Experiment
//
//  Created by T.J. Mercer on 6/9/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "EXPMainViewController.h"
#import "EXPTableViewController.h"
#import "EXPViewController.h"

@interface EXPMainViewController () <EXPTableDelegate>

@end

@implementation EXPMainViewController
{
    EXPTableViewController * table;
    EXPViewController * view;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        view = [[EXPViewController alloc]init];
        table = [[EXPTableViewController alloc]init];
        table.delegate = self;
        
        self.viewControllers = @[table,view];
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

-(void)populateWithArray:(NSMutableArray *)list
{
    view.fill = list;
    [view.collectionView reloadData];
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
