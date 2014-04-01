//
//  TJFViewController.m
//  W1D1 App
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
}

- (IBAction)Yes:(id)sender {
    
    self.first.text = @"POW";
    
}

- (IBAction)No:(id)sender {

    self.second.text = self.textfield.text;
    
}

- (IBAction)Maybe:(id)sender {
    
    self.third.backgroundColor = [UIColor whiteColor];
    
    self.third.textColor = [UIColor blackColor];
    
    self.third.text = @"SMACK";

}


@end
