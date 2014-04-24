//
//  TLATableViewCell.m
//  TweetLike
//
//  Created by T.J. Mercer on 4/23/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "TLATableViewCell.h"

@implementation TLATableViewCell
{
UILabel * text;

UILabel * likes;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UIImageView * heart = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 20, 20)];
        heart.image = [UIImage imageNamed:@"heart"];
        [self addSubview:heart];
        
        likes = [[UILabel alloc]initWithFrame:CGRectMake(40, 20, 60, 20)];
        likes.textColor = [UIColor redColor];
        likes.textAlignment = NSTextAlignmentCenter;
        
        text = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, 200, 60)];
        text.lineBreakMode =  NSLineBreakByWordWrapping;
        text.numberOfLines = 0;
        text.font = [UIFont systemFontOfSize:13];
//        self.tweets.tex = NSTextLayoutSectionOrientation;
        
        [self.contentView addSubview:likes];
        [self.contentView addSubview:text];
    }
    return self;
}

-(void)setTweet:(NSDictionary *)tweet
{
    _tweet = tweet;
    
    likes.text = [tweet[@"likes"] stringValue];
    text.text = tweet[@"text"];
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
