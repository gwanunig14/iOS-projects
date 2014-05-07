//
//  TDLSearchWork.m
//  TODO
//
//  Created by T.J. Mercer on 5/6/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "TDLSearch.h"
#import "TDLGitHubRequest.h"
#import "TDLSingleton.h"

@interface TDLSearch ()

@end

@implementation TDLSearch

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)newUser:(NSString *)query textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"working");
    NSDictionary * userInfo = [TDLGitHubRequest getUserWithUsername:query];
    
    if ([[userInfo allKeys] count] == 3)
    {
        [[TDLSingleton sharedSingleton] addListItem:userInfo];
        //        [listItems addObject:userInfo];
    }else {
        NSLog(@"not enough data");
        
        UIAlertView * alertview = [[UIAlertView alloc] initWithTitle:@"Fail" message:@"Unable to Add User" delegate:self cancelButtonTitle:@"Try Something Else" otherButtonTitles: nil];
        
        [alertview show];
        
    }
    
    [textField resignFirstResponder];
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
