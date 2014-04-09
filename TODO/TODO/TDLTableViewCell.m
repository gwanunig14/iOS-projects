//
//  TDLTableViewCell.m
//  TODO
//
//  Created by T.J. Mercer on 4/3/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "TDLTableViewCell.h"

@implementation TDLTableViewCell
{
    UIImageView * profileImage;
    
    UILabel * profileName;
    
    UILabel * profileURL;
    

}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        profileImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 60, 60)];
        [self.contentView addSubview:profileImage];
        profileImage.layer.cornerRadius = 30;
        profileImage.layer.masksToBounds = YES;
        
        profileName = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, 200, 35)];
        [self.contentView addSubview:profileName];
        profileName.textColor = [UIColor blackColor];
        profileName.font = [UIFont fontWithName:@"helvetica" size:16];
        
        profileURL = [[UILabel alloc] initWithFrame:CGRectMake(100, 55, 200, 30)];
        [self.contentView addSubview:profileURL];
        profileURL.textColor = [UIColor blackColor];
        profileURL.font = [UIFont systemFontOfSize:16];
        profileURL.font = [UIFont fontWithName:@"helvetica" size:10];
        
    }
    return self;
   
}



- (void)setProfileInfo:(NSDictionary *)profileInfo
{
    
    NSURL * imageUrl = [NSURL URLWithString:profileInfo [@"image"]];
    
    NSData * imageData = [NSData dataWithContentsOfURL:imageUrl];

    UIImage * image = [UIImage imageWithData:imageData];
    profileImage.image = image;
    profileName.text = profileInfo [@"name"];
    profileURL.text = profileInfo [@"github"];
    
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
