//
//  SLFStartUp.m
//  Selfy
//
//  Created by T.J. Mercer on 4/22/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SLFStartUp.h"

#import <Parse/Parse.h>

@interface SLFStartUp ()

@end

@implementation SLFStartUp

{
    UITextField * userName;
    UITextField * password;
    UIButton * submit;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        userName = [[UITextField alloc]initWithFrame:CGRectMake(50, 120, SCREEN_WIDTH - 100, 40)];
        userName.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:userName];
        
        password = [[UITextField alloc]initWithFrame:CGRectMake(50, 200, SCREEN_WIDTH - 100, 40)];
        password.backgroundColor = [UIColor lightGrayColor];
        password.secureTextEntry = YES;
        [self.view addSubview:password];
        
        submit = [[UIButton alloc]initWithFrame:CGRectMake(50, 280, SCREEN_WIDTH - 100, 80)];
        [submit addTarget:self action:@selector(logIn) forControlEvents:UIControlEventTouchUpInside];
        submit.backgroundColor = [UIColor redColor];
        submit.layer.cornerRadius = 40;
        [self.view addSubview:submit];
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

-(void)logIn
{
    NSString * uName = userName.text;
    NSString * pWord = password.text;
    
    if(![uName isEqualToString:@""])
    {
    PFUser * user = [PFUser currentUser];
    user.username = uName;
    user.password = pWord;
    
    [user saveInBackground];
    }
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
