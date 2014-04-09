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

@implementation TDLTableViewController

{
    NSMutableArray *listItems;
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
        
        listItems = [@[] mutableCopy];
        
        [self loadListItems];
 
        self.tableView.rowHeight = 100;
        
        UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
        header.backgroundColor = [UIColor blackColor];
        
        self.tableView.tableHeaderView = header;
        
        nameField = [[UITextField alloc]initWithFrame:CGRectMake(20, 20, 280, 30)];
        nameField.backgroundColor = [UIColor colorWithRed:0 green:1 blue:1 alpha:1];
        nameField.layer.cornerRadius = 5;
        nameField.textColor = [UIColor blackColor];
        nameField.placeholder = @"Type Here";
        
        nameField.delegate = self;
        
        [header addSubview:nameField];
        
        UIButton * submitButton = [[UIButton alloc] initWithFrame:CGRectMake(115, 70, 100, 30)];
        submitButton.layer.cornerRadius = 10;
        [submitButton addTarget:self action:@selector(newUser)forControlEvents:UIControlEventTouchUpInside];
        [submitButton setTitle:@"Submit" forState:UIControlStateNormal];
        submitButton.backgroundColor = [UIColor darkGrayColor];
        [header addSubview:submitButton];
        
    }
    
    return self;

}

-(void)newUser
{
    NSString * username = nameField.text;
    
    nameField.text = @"";
    
//    [listItems addObject:@{
//                           @"name": username,
//                           @"image" : [UIImage imageNamed:@"default"],
//                           @"github" : [NSString stringWithFormat:@"https://github.com/%@", username]
//                           }];

    NSDictionary * userInfo = [TDLGitHubRequest getUserWithUsername:username];
    
    if ([[userInfo allKeys] count] == 3)
    {
        [listItems addObject:userInfo];
    }else {
        NSLog(@"not enough data");
        
        UIAlertView * alertview = [[UIAlertView alloc] initWithTitle:@"Fail" message:@"Unable to Add User" delegate:self cancelButtonTitle:@"Try Something Else" otherButtonTitles: nil];
        
        [alertview show];
        
    }
    
    [nameField resignFirstResponder];
    
    [self.tableView reloadData];
    
    [self saveData];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField

{
    [self newUser];
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
    
    cell.profileInfo = [self getListItem:indexPath.row];
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    NSDictionary * listItem = [self getListItem:indexPath.row];
    
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
//    [listItems removeObjectAtIndex:indexPath.row];
    
    NSDictionary * listItem = [self getListItem:indexPath.row];
    
    [listItems removeObjectIdenticalTo:listItem];
    
//    [self.tableView reloadData];
    
    TDLTableViewCell * cell = (TDLTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.alpha  = 0;
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    NSLog(@"%@", listItems);
    
    [self saveData];
}
                       
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
                       
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    if (sourceIndexPath == destinationIndexPath) return;
    
    NSDictionary * sourceItem = [self getListItem:sourceIndexPath.row];
    
    NSDictionary * toItem = [self getListItem:destinationIndexPath.row];
    
    [listItems removeObjectIdenticalTo:sourceItem];
//    [listItems removeObjectAtIndex:[listItems indexOfObject:sourceItem]];
    [listItems insertObject:sourceItem atIndex:[listItems indexOfObject:toItem]];
    
    [self saveData];
    
}

- (NSDictionary *)getListItem:(NSInteger)row

{
    NSArray * reverseArray = [[listItems reverseObjectEnumerator] allObjects];
    return reverseArray[row];
}

-(void)saveData
{
    NSString *path = [self listArchivePath];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:listItems];
    [data writeToFile:path options:NSDataWritingAtomic error:nil];
}

- (NSString *)listArchivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = documentDirectories[0];
    return [documentDirectory stringByAppendingPathComponent:@"listdata.data"];
}

-(void)loadListItems
{
    NSString *path = [self listArchivePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        listItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    }
}
@end
