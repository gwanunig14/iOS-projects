//
//  TDLCell.m
//  ToBeDone
//
//  Created by Jo Albright on 4/9/14.
//  Copyright (c) 2014 Jo Albright. All rights reserved.
//

#import "TDLCell.h"
#import "MOVE.h"



@implementation TDLCell
{
    UIButton * lowButton;
    UIButton * medButton;
    UIButton * highButton;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        self.bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width - 20, 40)];
        self.bgView.layer.cornerRadius = 6;
        
        [self.contentView addSubview:self.bgView];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 200, 30)];
        self.nameLabel.textColor = [UIColor whiteColor];
        self.nameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
        
        [self.bgView addSubview:self.nameLabel];
        
        self.strikeThrough = [[UIView alloc] initWithFrame:CGRectMake(5, 21, self.frame.size.width - 30, 2)];
        self.strikeThrough.backgroundColor = [UIColor whiteColor];
        self.strikeThrough.alpha = 0;
        [self.bgView addSubview:self.strikeThrough];
        
        self.circleButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 50, 10, 20, 20)];
        self.circleButton.backgroundColor = [UIColor whiteColor];
        self.circleButton.layer.cornerRadius = 10;
        
        [self.bgView addSubview:self.circleButton];
         
    }
    return self;
}

-(void)resetLayout
{
//    if (self.swiped)
//    {
//        [self createButtons];
//        self.swiped = YES;
//    }else{
    self.bgView.frame = CGRectMake(10, 0, self.frame.size.width - 20, 40);
    [lowButton removeFromSuperview];
    [medButton removeFromSuperview];
    [highButton removeFromSuperview];
    self.swiped = NO;
//    }
}

- (void) createButtons
{
    lowButton = [[UIButton alloc] initWithFrame:CGRectMake(170, 0, 40, 40)];
    lowButton.tag = 1;
    lowButton.alpha = 0;
    lowButton.backgroundColor = YELLOW_COLOR;
    lowButton.layer.cornerRadius = lowButton.frame.size.width / 2.0;
    [lowButton addTarget:self action:@selector(pressPriorityButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:lowButton];
    
    medButton = [[UIButton alloc] initWithFrame:CGRectMake(220, 0, 40, 40)];
    medButton.tag = 2;
    medButton.alpha = 0;
    medButton.backgroundColor = ORANGE_COLOR;
    medButton.layer.cornerRadius = medButton.frame.size.width / 2.0;
    [medButton addTarget:self action:@selector(pressPriorityButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:medButton];
    
    highButton = [[UIButton alloc] initWithFrame:CGRectMake(270, 0, 40, 40)];
    highButton.tag = 3;
    highButton.alpha = 0;
    highButton.backgroundColor = RED_COLOR;
    highButton.layer.cornerRadius = highButton.frame.size.width / 2.0;
    [highButton addTarget:self action:@selector(pressPriorityButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:highButton];
}

- (void)showCircleButtons
{
    [self createButtons];
    
    [MOVE animateView:lowButton properties:@{@"alpha":@1,@"duration":@0.2,@"delay":@0.3}];
    [MOVE animateView:medButton properties:@{@"alpha":@1,@"duration":@0.2,@"delay":@0.2}];
    [MOVE animateView:highButton properties:@{@"alpha":@1,@"duration":@0.2,@"delay":@0.1}];
}

-(void)hideCircleButtons
{
    
    [MOVE animateView:lowButton properties:@{@"alpha":@0,@"duration":@0.2,@"delay":@0,@"remove":@YES}];
    [MOVE animateView:medButton properties:@{@"alpha":@0,@"duration":@0.2,@"delay":@0.1,@"remove":@YES}];
    [MOVE animateView:highButton properties:@{@"alpha":@0,@"duration":@0.2,@"delay":@0.2,@"remove":@YES}];
}

-(void) pressPriorityButton:(id)sender
{
    UIButton * button = (UIButton *)sender;
    [self.delegate setItemPriority:(int)button.tag withItem:self];
}

-(void)showDeleteButton
{
    highButton = [[UIButton alloc] initWithFrame:CGRectMake(270, 0, 40, 40)];
    highButton.alpha = 0;
    highButton.backgroundColor = RED_COLOR;
    highButton.layer.cornerRadius = highButton.frame.size.width / 2.0;
    [highButton addTarget:self action:@selector(pressDeleteButton) forControlEvents:UIControlEventTouchUpInside];
    [highButton setTitle:@"X" forState:UIControlStateNormal];
    highButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:60];
    highButton.titleLabel.textAlignment = (NSTextAlignmentRight);
    [self.contentView addSubview:highButton];
    
    [MOVE animateView:highButton properties:@{@"alpha":@1,@"duration":@0.2,@"delay":@0.3}];
}

- (void)pressDeleteButton
{
    [self.delegate deleteItem:self];
}

-(void)hideDeleteButton
{
    [MOVE animateView:highButton properties:@{@"alpha":@0,@"duration":@0.0,@"delay":@0.2,@"remove":@YES}];
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
