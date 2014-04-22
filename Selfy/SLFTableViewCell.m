//
//  SLFTableViewCell.m
//  Selfy
//
//  Created by T.J. Mercer on 4/21/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SLFTableViewCell.h"

@implementation SLFTableViewCell
{
    UIImageView * personalPhoto;
    UILabel * photoCaption;
    UIImageView * userPhoto;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        personalPhoto = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, SCREEN_WIDTH-10, 100)];
        [personalPhoto setContentMode:UIViewContentModeScaleAspectFit];
        
        userPhoto = [[UIImageView alloc]initWithFrame:CGRectMake(5, 110, 15, 15)];
        userPhoto.layer.cornerRadius = 7.5;
        userPhoto.layer.masksToBounds = YES;
        
        photoCaption = [[UILabel alloc]initWithFrame:CGRectMake(22, 110, SCREEN_WIDTH-23, 15)];
        
        [self addSubview:personalPhoto];
        [self addSubview:userPhoto];
        [self addSubview:photoCaption];
    }
    return self;
}

- (void)setProfileInfo:(NSDictionary *)profileInfo
{
    personalPhoto.image = profileInfo [@"photo"];
    photoCaption.text = profileInfo [@"caption"];
    userPhoto.image = profileInfo [@"avatar"];
    
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
