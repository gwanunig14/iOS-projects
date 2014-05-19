//
//  SYBNewProjectView.m
//  Story Board
//
//  Created by T.J. Mercer on 5/16/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SYBNewProjectView.h"
#import "SYBData.h"

@interface SYBNewProjectView ()

@end

@implementation SYBNewProjectView
{
    UITextField * projectName;
    UIButton * createProject;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.view.backgroundColor = [UIColor greenColor];
    }
    return self;
}

-(void)addSubviews
{
    int h = self.view.frame.size.height;
    int w = self.view.frame.size.width;
    
    projectName = [[UITextField alloc]initWithFrame:CGRectMake(20, h/4, w-40, 40)];
    projectName.backgroundColor=[UIColor blueColor];
    projectName.placeholder = @"Project Name";
    [self.view addSubview:projectName];
    
    createProject = [[UIButton alloc]initWithFrame:CGRectMake(20, h*0.75, w-40, 40)];
    createProject.backgroundColor = [UIColor redColor];
    [createProject addTarget:self action:@selector(addProject) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:createProject];
}

-(void)addProject
{
    if (projectName.text == nil)
    {
        return;
    }
    
    NSMutableDictionary * project = [@{projectName.text:@{}}mutableCopy];
    
    [[SYBData mainData] addNewProject:project];
    
    [self.delegate newProjectAdded];
}

@end
