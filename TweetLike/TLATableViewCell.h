//
//  TLATableViewCell.h
//  TweetLike
//
//  Created by T.J. Mercer on 4/23/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol TLATableViewCellDelegate;

@interface TLATableViewCell : UITableViewCell

//@property (nonatomic, assign) id<TLATableViewCellDelegate> delegate;

@property (nonatomic) NSDictionary * tweet;

@end
