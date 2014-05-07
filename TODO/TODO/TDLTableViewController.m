//
//  TDLTableViewController.m
//  TODO
//
//  Created by T.J. Mercer on 4/2/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "TDLTableViewController.h"

#import "TDLTableViewCell.h"

#import "TDLGitHubRequest.h"

#import "TDLSingleton.h"

#import "TDLSearch.h"

@implementation TDLTableViewController

{
    TDLSearch * getProfile;
    UITextField * nameField;
}

//-(void)toggleEdit
//{
////    self.tableView.editing = !self.tableView.editing;
//    [self.tableView setEditing:!self.tableView.editing animated:YES];
//    
//    [self.tableView reloadData];
//}

- (id)initWithStyle:(UITableViewStyle) style
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self)
    {
//        UIBarButtonItem * editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(toggleEdit)];
//        
//        self.navigationItem.rightBarButtonItem = editButton;
        
//       NSArray * array = @[
//  @{
//                          @"name": @"Jo Albright",
//                          @"image" : [UIImage imageNamed:@"jo"],
//                          @"github" : @"https://github.com/joalbright"
//                          },
//                      @{
//                          @"name": @"Teddy Conyers",
//                          @"image" : [UIImage imageNamed:@"Teddy"],
//                          @"github" : @"https://github.com/talented76"
//                          },
//                      @{
//                          @"name": @"Jon Fox",
//                          @"image" : [UIImage imageNamed:@"jon"],
//                          @"github" : @"https://github.com/FoxJon"
//                          },
//                      @{
//                          @"name": @"Ali Houshmand",
//                          @"image" : [UIImage imageNamed:@"ali"],
//                          @"github" : @"https://github.com/HoushmandA06"
//                          },
//                      @{
//                          @"name": @"Austen Johnson",
//                          @"image" : [UIImage imageNamed:@"austen"],
//                          @"github" : @"https://github.com/ajohnson21"
//                          },
//                      @{
//                          @"name": @"Jeff King",
//                          @"image" : [UIImage imageNamed:@"jeff"],
//                          @"github" : @"https://github.com/rampis"
//                          },
//                      @{
//                          @"name": @"T.J. Mercer",
//                          @"image" : [UIImage imageNamed:@"me"],
//                          @"github" : @"https://github.com/gwanunig14"
//                          },
//                      @{
//                          @"name": @"Jeffery Moulds",
//                          @"image" : [UIImage imageNamed:@"jeffery"],
//                          @"github" : @"https://github.com/jdmgithub"
//                          },
//                      @{
//                          @"name": @"Austin Nolan",
//                          @"image" : [UIImage imageNamed:@"austin"],
//                          @"github" : @"https://github.com/adnolan99"
//                          },
//                      @{
//                          @"name": @"Jisha Obukwelu",
//                          @"image" : [UIImage imageNamed:@"jisha"],
//                          @"github" : @"https://github.com/Jiobu"
//                          },
//                      @{
//                          @"name": @"Heidi Proshke",
//                          @"image" : [UIImage imageNamed:@"heidi"],
//                          @"github" : @"https://github.com/justagirlcoding"
//                          },
//                      @{
//                          @"name": @"Savitha Reddy",
//                          @"image" : [UIImage imageNamed:@"savitha"],
//                          @"github" : @"https://github.com/savithareddy"
//                          },
//                      @{
//                          @"name": @"Ed Salter",
//                          @"image" : [UIImage imageNamed:@"Ed"],
//                          @"github" : @"https://github.com/MadArkitekt"
//                          },
//                      @{
//                          @"name": @"Ashby Thornwell",
//                          @"image" : [UIImage imageNamed:@"ashby"],
//                          @"github" : @"https://github.com/athornwell"
//                          },
//                      @{
//                          @"name": @"Derek Weber",
//                          @"image" : [UIImage imageNamed:@"derek"],
//                          @"github" : @"https://github.com/dweber03"
//                          },
//                      @{
//                          @"name": @"John Yam",
//                          @"image" : [UIImage imageNamed:@"john"],
//                          @"github" : @"https://github.com/yamski"
//                          }
//        ];
 
        self.tableView.rowHeight = 100;
        
    }
    
    return self;

}

-(void)newUser
{
    NSLog(@"working1");
    [getProfile newUser:nameField.text textFieldShouldReturn:nameField];
    [self.tableView reloadData];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField

{
    [self newUser];
    return YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidLoad];
    
    getProfile = [[TDLSearch alloc]init];
    
    nameField = [[UITextField alloc]initWithFrame:CGRectMake(60, 12, 200, 20)];
    nameField.backgroundColor = [UIColor colorWithRed:0 green:1 blue:1 alpha:1];
    nameField.layer.cornerRadius = 5;
    nameField.textColor = [UIColor blackColor];
    nameField.placeholder = @"Type Here";
    
    nameField.delegate = self;
    
    UIBarButtonItem * submitButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(newUser)];
    self.navigationItem.rightBarButtonItem = submitButton;
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    [self.navigationController.navigationBar addSubview:nameField];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [[[TDLSingleton sharedSingleton] allListItems] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TDLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier : @"cell"];
    
    if (cell == nil) cell = [[TDLTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    cell.index = indexPath.row;
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * listItem = [[TDLSingleton sharedSingleton] allListItems][indexPath.row];
    
    NSLog(@"%@",listItem);
    
    UIViewController * webController = [[UIViewController alloc] init];
    
    UIWebView * webView = [[UIWebView alloc] init];
    
    webController.view= webView;
    
    [self.navigationController pushViewController:webController animated:YES];
    
    NSURL * url = [NSURL URLWithString:listItem[@"github"]];
                   
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
                   
    [webView loadRequest:request];
    
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[TDLSingleton sharedSingleton] removeListItemAtIndex:indexPath.row];
    
    TDLTableViewCell * cell = (TDLTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.alpha  = 0;
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}
                       
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
                       
//-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
//{
//    if (sourceIndexPath == destinationIndexPath) return;
//    
//    NSDictionary * sourceItem = [self getListItem:sourceIndexPath.row];
//    
//    NSDictionary * toItem = [self getListItem:destinationIndexPath.row];
//    
//    [listItems removeObjectIdenticalTo:sourceItem];
////    [listItems removeObjectAtIndex:[listItems indexOfObject:sourceItem]];
//    [listItems insertObject:sourceItem atIndex:[listItems indexOfObject:toItem]];
//    
//    [self saveData];
//    
//}

@end
