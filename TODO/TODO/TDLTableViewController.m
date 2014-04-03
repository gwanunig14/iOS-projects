//
//  TDLTableViewController.m
//  TODO
//
//  Created by T.J. Mercer on 4/2/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "TDLTableViewController.h"

#import "TDLTableViewCell.h"

@implementation TDLTableViewController

{
    NSArray *listItems;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    
    {
        
       listItems = @[@{
                          @"name": @"Jo Albright",
                          @"image" : [UIImage imageNamed:@"jo"],
                          @"github" : @"https://github.com/joalbright"
                          },
                      @{
                          @"name": @"Teddy Conyers",
                          @"image" : [UIImage imageNamed:@"Teddy"],
                          @"github" : @"https://github.com/talented76"
                          },
                      @{
                          @"name": @"Jon Fox",
                          @"image" : [UIImage imageNamed:@"jon"],
                          @"github" : @"https://github.com/FoxJon"
                          },
                      @{
                          @"name": @"Ali Houshmand",
                          @"image" : [UIImage imageNamed:@"ali"],
                          @"github" : @"https://github.com/HoushmandA06"
                          },
                      @{
                          @"name": @"Austen Johnson",
                          @"image" : [UIImage imageNamed:@"austen"],
                          @"github" : @"https://github.com/ajohnson21"
                          },
                      @{
                          @"name": @"Jeff King",
                          @"image" : [UIImage imageNamed:@"jeff"],
                          @"github" : @"https://github.com/rampis"
                          },
                      @{
                          @"name": @"T.J. Mercer",
                          @"image" : [UIImage imageNamed:@"me"],
                          @"github" : @"https://github.com/gwanunig14"
                          },
                      @{
                          @"name": @"Jeffery Moulds",
                          @"image" : [UIImage imageNamed:@"jeffery"],
                          @"github" : @"https://github.com/jdmgithub"
                          },
                      @{
                          @"name": @"Austin Nolan",
                          @"image" : [UIImage imageNamed:@"austin"],
                          @"github" : @"https://github.com/adnolan99"
                          },
                      @{
                          @"name": @"Jisha Obukwelu",
                          @"image" : [UIImage imageNamed:@"jisha"],
                          @"github" : @"https://github.com/Jiobu"
                          },
                      @{
                          @"name": @"Heidi Proske",
                          @"image" : [UIImage imageNamed:@"heidi"],
                          @"github" : @"https://github.com/justagirlcoding"
                          },
                      @{
                          @"name": @"Savitha Reddy",
                          @"image" : [UIImage imageNamed:@"savitha"],
                          @"github" : @"https://github.com/savithareddy"
                          },
                      @{
                          @"name": @"Ed Salter",
                          @"image" : [UIImage imageNamed:@"Ed"],
                          @"github" : @"https://github.com/MadArkitekt"
                          },
                      @{
                          @"name": @"Ashby Thornwell",
                          @"image" : [UIImage imageNamed:@"ashby"],
                          @"github" : @"https://github.com/athornwell"
                          },
                      @{
                          @"name": @"Derek Weber",
                          @"image" : [UIImage imageNamed:@"derek"],
                          @"github" : @"https://github.com/dweber03"
                          },
                      @{
                          @"name": @"John Yam",
                          @"image" : [UIImage imageNamed:@"john"],
                          @"github" : @"https://github.com/yamski"
                          }];
 
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
        self.tableView.rowHeight = 100;
        
        UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
        header.backgroundColor = [UIColor blackColor];
        
        self.tableView.tableHeaderView = header;
        
        UITextField * nameField = [[UITextField alloc]initWithFrame:CGRectMake(20, 20, 280, 30)];
        nameField.backgroundColor = [UIColor colorWithRed:0 green:1 blue:1 alpha:1];
        nameField.layer.cornerRadius = 5;
        nameField.textColor = [UIColor blackColor];
        
        [header addSubview:nameField];
        
        UIButton * submitButton = [[UIButton alloc] initWithFrame:CGRectMake(115, 70, 100, 30)];
        submitButton.layer.cornerRadius = 10;
        [submitButton setTitle:@"New User" forState:UIControlStateNormal];
        submitButton.backgroundColor = [UIColor darkGrayColor];
        [header addSubview:submitButton];
        
    }
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    

    
    return [listItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TDLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier : @"cell"];
    
    if (cell == nil) cell = [[TDLTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    int index = indexPath.row;
    
    NSDictionary * listItem = listItems[index];
    
    cell.profileInfo = listItem;
    
//    cell.textLabel.text = listItem[@"name"];
    
//    cell.imageView.image = listItem[@"image"];
    
    
    UIView * footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 48)];
    
    
//    header.backgroundColor = [UIColor grayColor];
    footer.backgroundColor = [UIColor blackColor];
    
    self.tableView.tableFooterView = footer;
    
    UILabel * titleFooter = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 300, 30)];
    
//    titleHeader.text = @"Class";
//    titleHeader.textColor = [UIColor whiteColor];
    titleFooter.text = @"End";
    titleFooter.textColor = [UIColor cyanColor];
    
//    [header addSubview:titleHeader];
    [footer addSubview:titleFooter];
    
    return cell;
}



@end
