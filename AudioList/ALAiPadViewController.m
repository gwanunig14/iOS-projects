//
//  ALAiPadViewController.m
//  AudioList
//
//  Created by T.J. Mercer on 5/8/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "ALAiPadViewController.h"
#import "ALASoundCloudRequest.h"
#import "ALAiPadTableView.h"
#import "ALAiPadDataView.h"

@interface ALAiPadViewController ()<UISplitViewControllerDelegate>

@end

@implementation ALAiPadViewController
{
    ALAiPadTableView * listVC;
    ALAiPadDataView * detailVC;
    UINavigationController * nc;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        detailVC = [[ALAiPadDataView alloc]initWithNibName:nil bundle:nil];
        
        nc = [[UINavigationController alloc]initWithRootViewController:detailVC];
        
        listVC = [[ALAiPadTableView alloc]initWithStyle:UITableViewStylePlain];
        
        self.viewControllers = @[listVC, nc];
        
        self.delegate = self;
        
        [ALASoundCloudRequest updateData];
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

-(void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc
{
    barButtonItem.title = @"List";
    detailVC.navigationItem.leftBarButtonItem = barButtonItem;
    detailVC.navigationController.navigationBarHidden = NO;
}

-(void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    nc.navigationItem.leftBarButtonItem = barButtonItem;
    nc.navigationBarHidden = YES;
    
}

@end
