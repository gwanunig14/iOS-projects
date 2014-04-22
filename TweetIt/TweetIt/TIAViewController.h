//
//  TIAViewController.h
//  TweetIt
//
//  Created by T.J. Mercer on 4/21/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TIAViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;

@property (nonatomic) NSDictionary * tweet;

@end
