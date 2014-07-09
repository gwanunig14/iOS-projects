//
//  PTGTableViewCell.m
//  Painting
//
//  Created by T.J. Mercer on 6/19/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "PTGTableViewCell.h"

@implementation PTGTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
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
