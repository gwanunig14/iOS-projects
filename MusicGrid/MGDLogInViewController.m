//
//  MGDLogInViewController.m
//  MusicGrid
//
//  Created by T.J. Mercer on 6/7/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "MGDLogInViewController.h"
#import "MGDViewController.h"
#import "MGDFirstRating.h"
#import "MGDRequest.h"
#import "MGDData.h"

@interface MGDLogInViewController ()

@end

@implementation MGDLogInViewController
{
    UITextField * name;
    UITextField * userName;
    UITextField * password;
    
    UIImageView * civilWars;
    UIImageView * skrillex;
    UIImageView * katy;
    
    UIButton * logIn;
    UIButton * signUp;
    UIButton * sendInfo;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        userName = [[UITextField alloc]initWithFrame:CGRectMake(50, 150, 250, 40)];
        userName.placeholder = @"UserName";
        userName.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:userName];
        
        password = [[UITextField alloc]initWithFrame:CGRectMake(50, 220, 250, 40)];
        password.placeholder = @"Password";
        password.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:password];
        
        logIn = [[UIButton alloc]initWithFrame:CGRectMake(50, 290, 100, 40)];
        logIn.backgroundColor = [UIColor greenColor];
        [logIn addTarget:self action:@selector(logInAct) forControlEvents:UIControlEventTouchUpInside];
        [logIn setTitle:@"LogIn" forState:UIControlStateNormal];
        [self.view addSubview:logIn];
        
        signUp = [[UIButton alloc]initWithFrame:CGRectMake(200, 290, 100, 40)];
        signUp.backgroundColor = [UIColor greenColor];
        [signUp addTarget:self action:@selector(signUpAct) forControlEvents:UIControlEventTouchUpInside];
        [signUp setTitle:@"New User" forState:UIControlStateNormal];
        [self.view addSubview:signUp];
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

-(void)logInAct
{
    NSLog(@"hi");
    MGDViewController * music = [[MGDViewController alloc]init];
    UINavigationController * nc = [[UINavigationController alloc]initWithRootViewController:music];
    nc.navigationBarHidden = YES;
    [self.navigationController presentViewController:nc animated:YES completion:^{
        NSLog(@"hi");
    }];
}

-(void)signUpAct
{
    name = [[UITextField alloc]initWithFrame:CGRectMake(50, 80, 250, 40)];
    name.placeholder = @"E-Mail";
    name.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:name];
    
    [UIView animateWithDuration:0.5 animations:^{
        signUp.alpha = 0.0;
        logIn.frame = CGRectMake(50, 290, 250, 40);
    } completion:^(BOOL finished) {
        [signUp removeFromSuperview];
        sendInfo = [[UIButton alloc]initWithFrame:CGRectMake(50, 290, 250, 40)];
        [sendInfo setTitle:@"Sign Up" forState:UIControlStateNormal];
        [sendInfo addTarget:self action:@selector(newUser) forControlEvents:UIControlEventTouchUpInside];
        sendInfo.backgroundColor = [UIColor greenColor];
        [self.view addSubview:sendInfo];
        [logIn removeFromSuperview];
    }];
    
    [MGDData mainData].unRated = [MGDData mainData].startUp;
}

-(void)submit
{
    if ([userName.text length] != 0) {
        if ([password.text length] != 0) {
            MGDRequest * request = [[MGDRequest alloc]init];
            NSDictionary * login = @{@"user": @{@"email": name.text,
                                                @"password": password.text,
                                                @"token":[MGDData mainData].token}};
            [request sendDictionary:login andString:@"login"];
            MGDFirstRating * stars = [[MGDFirstRating alloc]init];
            [self.navigationController pushViewController:stars animated:YES];
        }
    }
    MGDFirstRating * stars = [[MGDFirstRating alloc]init];
    [self.navigationController pushViewController:stars animated:YES];
}

-(void)newUser
{
    if ([userName.text length] != 0) {
        if ([name.text length] != 0) {
            if ([password.text length] != 0) {
                MGDRequest * request = [[MGDRequest alloc]init];
                NSDictionary * login = @{@"user": @{@"name": userName.text,
                                                    @"email": name.text,
                                                    @"password": password.text}};
                [request sendDictionary:login andString:@"create"];
                MGDFirstRating * stars = [[MGDFirstRating alloc]init];
                [self.navigationController pushViewController:stars animated:YES];
            }
        }
    }
    MGDFirstRating * stars = [[MGDFirstRating alloc]init];
    [self.navigationController pushViewController:stars animated:YES];
}

@end
