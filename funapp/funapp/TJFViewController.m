//
//  TJFViewController.m
//  funapp
//
//  Created by T.J. Mercer on 3/31/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "TJFViewController.h"

@interface TJFViewController ()

@end

@implementation TJFViewController

- (void)viewDidLoad

{
    [super viewDidLoad];
	
}

- (void)didReceiveMemoryWarning

{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ButtonPressed:(id)sender {
    
    self.mylabel.text = @"T.J.";

}
@end
