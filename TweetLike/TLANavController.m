//
//  TLANavController.m
//  TweetLike
//
//  Created by T.J. Mercer on 4/23/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "TLANavController.h"
#import "TLATableViewController.h"

@interface TLANavController () <UITextViewDelegate>

@end

@implementation TLANavController
{
    TLATableViewController * TVC;
    UITextView * tweetIt;
    UIButton * addNewTweet;
    UIButton * submitTweet;
    UIButton * cancelTweet;
    UIView * blueBox;
    UIView * newForm;
    UIImageView * logo;
}

- (void)newItem:(UIButton *)sender
{
    [newForm addSubview:tweetIt];
    [newForm addSubview:submitTweet];
    [newForm addSubview:cancelTweet];
    [UIView animateWithDuration:0.4 animations:^{
      blueBox.frame=self.view.frame;
        newForm.frame=blueBox.frame;
      tweetIt.alpha = 1.0;
      submitTweet.alpha = 1.0;
      cancelTweet.alpha = 1.0;
      addNewTweet.alpha = 0.0;
  }];
    [UIImageView animateWithDuration:0.4 animations:^{
        logo.frame = CGRectMake(105, SCREEN_HEIGHT/2 - 120, 120, 40);
    }];
    [addNewTweet removeFromSuperview];
}

- (void)cancelButtonPushed
{
    [newForm addSubview:addNewTweet];
    addNewTweet.alpha = 0.0;
    [UIView animateWithDuration:0.4 animations:^{
        addNewTweet.alpha = 1.0;
        blueBox.frame = self.navigationBar.frame;
        newForm.frame=blueBox.frame;
        tweetIt.alpha = 0.0;
        submitTweet.alpha = 0.0;
        cancelTweet.alpha = 0.0;
        logo.frame = CGRectMake(5, 12, 60, 20);
    }];

    [tweetIt removeFromSuperview];
    [submitTweet removeFromSuperview];
    [cancelTweet removeFromSuperview];
}

-(void)submitButtonPushed
{
    [TVC createNewTweet:tweetIt.text];
    
    tweetIt.text = @"";
    
    [self cancelButtonPushed];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    blueBox = [[UIView alloc]initWithFrame:self.navigationBar.frame];
    blueBox.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueBox];
    
    newForm = [[UIView alloc]initWithFrame:blueBox.frame];
    newForm.backgroundColor = [UIColor clearColor];
    [blueBox addSubview:newForm];
    
    addNewTweet = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 80, (self.navigationBar.frame.size.height - 30)/2, 160, 30)];
    addNewTweet.layer.cornerRadius = 15;
    addNewTweet.backgroundColor = [UIColor whiteColor];
    [addNewTweet addTarget:self action:@selector(newItem:) forControlEvents:UIControlEventTouchUpInside];
    [addNewTweet setTitleColor:(UIColor.blueColor) forState:UIControlStateNormal];
    [addNewTweet setTitle:@"Add New" forState:UIControlStateNormal];
    addNewTweet.titleLabel.textAlignment = NSTextAlignmentCenter;
    //        addNewTweet.titleLabel.textColor = [UIColor blueColor];
    [newForm addSubview:addNewTweet];
    
    submitTweet = [[UIButton alloc]initWithFrame:CGRectMake(20, SCREEN_HEIGHT/2+70, 80, 25)];
    submitTweet.backgroundColor = [UIColor greenColor];
    submitTweet.alpha = 0.0;
    submitTweet.layer.cornerRadius = 12.5;
    [submitTweet addTarget:self action:@selector(submitButtonPushed) forControlEvents:UIControlEventTouchUpInside];
    [submitTweet setTitle:@"New Tweet" forState:UIControlStateNormal];
    submitTweet.titleLabel.textColor = [UIColor whiteColor];
    
    cancelTweet = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-100, SCREEN_HEIGHT/2+70, 80, 25)];
    cancelTweet.backgroundColor =[UIColor redColor];
    cancelTweet.alpha = 0.0;
    cancelTweet.layer.cornerRadius = 12.5;
    [cancelTweet addTarget:self action:@selector(cancelButtonPushed) forControlEvents:UIControlEventTouchUpInside];
    [cancelTweet setTitle:@"CANCEL" forState:UIControlStateNormal];
    cancelTweet.titleLabel.textColor = [UIColor whiteColor];
    
    logo = [[UIImageView alloc]initWithFrame:CGRectMake(5, 12, 60, 20)];
    logo.image = [UIImage imageNamed:@"logo"];
    [newForm addSubview:logo];
    
    tweetIt = [[UITextView alloc]initWithFrame:CGRectMake(20, SCREEN_HEIGHT/2-60, SCREEN_WIDTH - 40, 120)];
    tweetIt.alpha = 0.0;
    tweetIt.backgroundColor = [UIColor whiteColor];
    tweetIt.layer.cornerRadius = 30;
    tweetIt.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addTableViewController:(TLATableViewController *)viewController
{
    TVC = viewController;
    
    [self pushViewController:viewController animated:NO];
    
    if ([TVC isTweetItemsEmpty])
    {
        [self newItem:nil];
    }
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.2 animations:^{
        newForm.frame = CGRectMake(0, -100, SCREEN_WIDTH, self.view.frame.size.height);
    }];
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
