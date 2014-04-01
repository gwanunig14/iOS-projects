//
//  TJFViewController.h
//  W1D1 App
//
//  Created by T.J. Mercer on 3/31/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJFViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *first;

@property (weak, nonatomic) IBOutlet UITextField *textfield;

@property (weak, nonatomic) IBOutlet UILabel *second;

@property (weak, nonatomic) IBOutlet UILabel *third;

- (IBAction)Yes:(id)sender;

- (IBAction)No:(id)sender;

- (IBAction)Maybe:(id)sender;

@end
