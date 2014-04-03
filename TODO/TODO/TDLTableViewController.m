//
//  TDLTableViewController.m
//  TODO
//
//  Created by T.J. Mercer on 4/2/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "TDLTableViewController.h"

@implementation TDLTableViewController

{
    NSArray *listItems;
    NSArray *listImages;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    
    {
        
        listItems = @[@"Jo Albright",
                      @"Teddy Conyers",
                      @"Jon Fox",
                      @"Ali Houshmand",
                      @"Austen Johnson",
                      @"Jeff King",
                      @"T.J. Mercer",
                      @"Jeffery Moulds",
                      @"Austin Nolan",
                      @"Jisha Obukwelu",
                      @"Heidi Proske",
                      @"Savitha Reddy",
                      @"Ed Salter",
                      @"Ashby Thornwell",
                      @"Derek Weber",
                      @"John Yam"];
        
        listImages = @[[UIImage imageNamed:@"jo"],
                       [UIImage imageNamed:@"teddy"],
                       [UIImage imageNamed:@"jon"],
                       [UIImage imageNamed:@"ali"],
                       [UIImage imageNamed:@"austen"],
                       [UIImage imageNamed:@"jeff"],
                       [UIImage imageNamed:@"me"],
                       [UIImage imageNamed:@"jeffery"],
                       [UIImage imageNamed:@"austin"],
                       [UIImage imageNamed:@"jisha"],
                       [UIImage imageNamed:@"heidi"],
                       [UIImage imageNamed:@"savitha"],
                       [UIImage imageNamed:@"ed"],
                       [UIImage imageNamed:@"ashby"],
                       [UIImage imageNamed:@"derek"],
                       [UIImage imageNamed:@"john"]];
        
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
        
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier : @"cell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]init];
    }
    
    int index = [indexPath row];
    
    cell.textLabel.text = listItems[index];
    
    cell.imageView.image = listImages[index];
    
    UIView * header = [[UIView alloc] initWithFrame:CGRectMake(15, 0, 300, 48)];
    
    UIView * footer = [[UIView alloc] initWithFrame:CGRectMake(15, 0, 300, 48)];
    
    header.backgroundColor = [UIColor grayColor];
    footer.backgroundColor = [UIColor blackColor];
    
    self.tableView.tableHeaderView = header;
    self.tableView.tableFooterView = footer;
    
    UILabel * titleHeader = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 300, 30)];
    UILabel * titleFooter = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 300, 30)];
    
    titleHeader.text = @"Class";
    titleHeader.textColor = [UIColor whiteColor];
    titleFooter.text = @"End";
    titleFooter.textColor = [UIColor whiteColor];
    
    [header addSubview:titleHeader];
    [footer addSubview:titleFooter];
    
    return cell;
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

@end
