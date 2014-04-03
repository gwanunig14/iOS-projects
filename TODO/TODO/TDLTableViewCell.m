//
//  TDLTableViewCell.m
//  TODO
//
//  Created by T.J. Mercer on 4/3/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "TDLTableViewCell.h"

@implementation TDLTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
    }
    return self;
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 60, 60)];
    UILabel * nameList = [[UILabel alloc] init];
    UILabel * gitList = [[UILabel alloc] init];
}



- (void)setProfileInfo:(NSDictionary *)profileInfo
{
    
    UILabel * nameList  = [[UILabel alloc] init];
    UILabel * gitList  = [[UILabel alloc] init];
    
    imageView.image = profileInfo [@"image"];
    imageView.layer.cornerRadius = 30;
    imageView.layer.masksToBounds = YES;
    nameList.text = profileInfo [@"name"];
    gitList.text = profileInfo [@"github"];
    
    [self.contentView addSubview:imageView];
    [self.contentView addSubview:nameList];
    [self.contentView addSubview:gitList];
    
    _profileInfo = profileInfo;

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
