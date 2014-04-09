//
//  TDLTableViewController.m
//  Todo2
//
//  Created by T.J. Mercer on 4/8/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "TDLTableViewController.h"
#import "TDLTableViewCellLow.h"

@interface TDLTableViewController ()

@end

@implementation TDLTableViewController

{
    NSMutableArray *itemList;
    UITextField *newTODO;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        itemList = [@[] mutableCopy];
        
        self.tableView.rowHeight = 80;
        
        UIView *topBox = [[UIView alloc] initWithFrame:CGRectMake(20, 40, 320, 100)];
        self.tableView.tableHeaderView = topBox;
        
        newTODO = [[UITextField alloc] initWithFrame:CGRectMake(20, 40, 180, 30)];
        newTODO.placeholder = @"New To Do";
        newTODO.backgroundColor = [UIColor grayColor];
        newTODO.textColor = [UIColor whiteColor];
        newTODO.layer.cornerRadius =5;
        
        UIButton *lowButton = [[UIButton alloc] initWithFrame:CGRectMake(205, 40, 30, 30)];
        [lowButton addTarget:self action:@selector(lowPriority) forControlEvents:UIControlEventTouchUpInside];
        lowButton.layer.cornerRadius = 15;
        lowButton.backgroundColor = [UIColor greenColor];
        lowButton.alpha = .5;
        
        UIButton *medButton = [[UIButton alloc] initWithFrame:CGRectMake(240, 40, 30, 30)];
        [medButton addTarget:self action:@selector(medPriority) forControlEvents:UIControlEventTouchUpInside];
        medButton.layer.cornerRadius = 15;
        medButton.backgroundColor = [UIColor yellowColor];
        medButton.alpha = .5;
        
        UIButton *highButton = [[UIButton alloc] initWithFrame:CGRectMake(275, 40, 30, 30)];
        [highButton addTarget:self action:@selector(highPriority) forControlEvents:UIControlEventTouchUpInside];
        highButton.layer.cornerRadius = 15;
        highButton.backgroundColor = [UIColor redColor];
        highButton.alpha = .5;
        
        [topBox addSubview:newTODO];
        [topBox addSubview:lowButton];
        [topBox addSubview:medButton];
        [topBox addSubview:highButton];
        
    }
    return self;
}

-(void)lowPriority
{
    newTODO.text = @"";
    
    [itemList insertObject:newTODO.text atIndex:0];
    
    [newTODO resignFirstResponder];
    
    [self.tableView reloadData];    
}

-(void)medPriority
{
    NSLog(@"two");
}

-(void)highPriority
{
    NSLog(@"three");
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

- (NSInteger)tableview:(UITableView *)tableview numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%d",[itemList count]);
    return [itemList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TDLTableViewCellLow *cell = [tableView dequeueReusableCellWithIdentifier : @"cell"];
    
    if (cell == nil) cell = [[TDLTableViewCellLow alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    NSLog(@"%@",itemList[indexPath.row]);
    
    cell.textLabel.text = itemList[indexPath.row];
    
//    cell.setTodoInfoLow = itemList[indexPath.row];
    
    return cell;
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
