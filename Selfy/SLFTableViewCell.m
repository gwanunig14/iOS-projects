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
        personalPhoto = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 280, 280)];
        personalPhoto.backgroundColor = [UIColor lightGrayColor];
        [personalPhoto setContentMode:UIViewContentModeScaleAspectFit];
        
        userPhoto = [[UIImageView alloc]initWithFrame:CGRectMake(20, 320, 40, 40)];
        userPhoto.layer.cornerRadius = 20;
        userPhoto.layer.masksToBounds = YES;
        
        photoCaption = [[UILabel alloc]initWithFrame:CGRectMake(80, 320, 220, 40)];
        photoCaption.textColor = [UIColor darkGrayColor];
        
        [self addSubview:personalPhoto];
        [self addSubview:userPhoto];
        [self addSubview:photoCaption];
    }
    return self;
}

- (void)setPictureInfo:(NSDictionary *)pictureInfo
{
    _pictureInfo = pictureInfo;

    
    NSURL * imageURL = [NSURL URLWithString:pictureInfo[@"image"]];
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage * image = [UIImage imageWithData:imageData];
    
    personalPhoto.image = image;
    
    photoCaption.text = pictureInfo [@"caption"];
    
    NSURL * avatarURL = [NSURL URLWithString:pictureInfo[@"avatar"]];
    NSData * avatarData = [NSData dataWithContentsOfURL:avatarURL];
    UIImage * avatar = [UIImage imageWithData:avatarData];
    
    userPhoto.image = avatar;
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
