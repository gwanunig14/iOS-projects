//
//  TLATableViewController.h
//  TweetLike
//
//  Created by T.J. Mercer on 4/23/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLATableViewCell;

@interface TLATableViewController : UITableViewController //<TLATableViewCellDelegate>

@property (nonatomic) NSMutableArray * allTweets;

@property (nonatomic, getter = isTweetItemsEmpty,readonly) BOOL tweetItemsEmpty;

-(void)createNewTweet:(NSString *)tweet;

@end
