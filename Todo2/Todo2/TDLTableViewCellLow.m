//
//  TDLTableViewCellLow.m
//  Todo2
//
//  Created by T.J. Mercer on 4/8/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "TDLTableViewCellLow.h"

@implementation TDLTableViewCellLow

{
    UILabel *todoItem;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor greenColor];
        self.alpha = .4;
        todoItem = [[UILabel alloc]initWithFrame:CGRectMake(100, 20, 200, 35)];
        [self.contentView addSubview:todoItem];
        todoItem.textColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setTodoInfoLow:(NSDictionary *)todoInfo
{
    todoItem.text = todoInfo [@""];
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