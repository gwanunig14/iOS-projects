//
//  SLFTableViewController.m
//  Selfy
//
//  Created by T.J. Mercer on 4/21/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SLFTableViewController.h"

#import "SLFTableViewCell.h"

#import <Parse/Parse.h>

@interface SLFTableViewController ()

@end

@implementation SLFTableViewController
{
    UIView * header;
    NSMutableArray * allPictures;
    UIButton * settings;
    UIButton * newUser;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        self.tableView.rowHeight = self.tableView.frame.size.width + 100;
        header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
//        self.tableView.tableHeaderView = header;
        [self.view addSubview:header];
        
        settings = [[UIButton alloc]initWithFrame:CGRectMake(5, 5, 30, 30)];
        settings.layer.cornerRadius = 15;
        settings.backgroundColor = [UIColor redColor];
        [header addSubview:settings];
        
        newUser = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-35, 5, 30, 30)];
        newUser.layer.cornerRadius = 15;
        newUser.backgroundColor = [UIColor redColor];
        [newUser setTitle:@"New" forState:UIControlStateNormal];
        [newUser addTarget:self action:@selector(createCell) forControlEvents:UIControlEventTouchUpInside];
        newUser.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:8];
        [header addSubview:newUser];
        
        allPictures = [@[
                         @{   @"image" : @"http://distilleryimage7.ak.instagram.com/6756ea06a44b11e2b62722000a1fbc10_7.jpg",
                              @"caption" : @"This is a selfy!",
                              @"user_id" : @"3n2mb23bnm",
                              @"avatar" : @"https://media.licdn.com/mpr/mpr/shrink_200_200/p/4/005/036/354/393842f.jpg",
                              @"selfy_id" : @"hjk2l32bn1"
                            }
                        ] mutableCopy];
       
        PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
        testObject[@"name"] = @"T.J.";
        [testObject saveInBackground];
        
        PFUser * user = [PFUser currentUser];
        user.username = @"T.J.";
        user.password = @"password";
        
        [user saveInBackground];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    testObject[@"foo"] = @"bar";
    [testObject saveInBackground];
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [allPictures count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSDictionary * pictures = pictureInfo[indexPath.row];
    
    SLFTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil)
    {
        cell = [[SLFTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.pictureInfo = allPictures[indexPath.row];
    
//    cell.imageView.image = pictures[@"photo"];
//    cell.detailTextLabel.text = pictures[@"caption"];
    return cell;
}

-(void) createCell
{
    [allPictures insertObject:@{  //the photo
                                @"photo":[UIImage imageNamed:@"sunset"],
                                //text about the photo
                                @"caption":@"Woohoo!",
                                //phototaker's name
                                @"user": @"The Internet",
                                @"avatar": [UIImage imageNamed:@"Austen"]
                                }
                      atIndex:1];
    [self.tableView reloadData];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BOOL)prefersStatusBarHidden { return YES; }

@end
