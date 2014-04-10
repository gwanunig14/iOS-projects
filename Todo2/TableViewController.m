//
//  TDLTableViewController.m
//  Todo2
//
//  Created by T.J. Mercer on 4/8/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "TableViewController.h"
#import "TDLTableViewCellLow.h"

@implementation TableViewController
{
    //everything mentioned here gets used in the entire app.
    NSMutableArray *itemList;
    //array that can be changed.
    UITextField *newTODO;
    //    where you can type things
    NSArray * priorityColors;
    //    an array(list) of the colors and the order they are to be used
    
    UIButton * lowButton;
    UIButton * medButton;
    UIButton * highButton;
    //    listed here so the buttons can be used everywhere
    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        
        priorityColors = @[TAN_COLOR,YELLOW_COLOR,ORANGE_COLOR,RED_COLOR];
        //these colors are defined in todo2-prefix.pch
        itemList = [@[
                      @{@"name":@"Wokshop App",
                        @"priority" : @3
                        },
                      @{@"name":@"Go To Blogging Thing", @"priority" : @2},
                      @{@"name":@"Learn Objective-C", @"priority" : @1},
                      @{@"name": @"Finish GitHub App", @"priority" : @0}
                      ] mutableCopy];
        //makes a dictionary that can be changed while the app is being used.
        
        NSLog(@"%lu",[itemList count]);
        
        self.tableView.rowHeight = 50;
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //removes space between rows.
        self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
        //creates the header and defines its size.
        
        newTODO = [[UITextField alloc] initWithFrame:CGRectMake(20, 40, 180, 30)];
        newTODO.placeholder = @"New To Do";
        newTODO.backgroundColor = TAN_COLOR;
        newTODO.textColor = [UIColor whiteColor];
        newTODO.layer.cornerRadius =5;
        
        lowButton = [[UIButton alloc] initWithFrame:CGRectMake(205, 40, 30, 30)];
        [lowButton addTarget:self action:@selector(addNewListItem:) forControlEvents:UIControlEventTouchUpInside];
        lowButton.tag=1;
        lowButton.layer.cornerRadius = 15;
        lowButton.backgroundColor = YELLOW_COLOR;
        lowButton.alpha = .5;
        
        medButton = [[UIButton alloc] initWithFrame:CGRectMake(240, 40, 30, 30)];
        [medButton addTarget:self action:@selector(addNewListItem:) forControlEvents:UIControlEventTouchUpInside];
        medButton.tag=2;
        medButton.layer.cornerRadius = 15;
        medButton.backgroundColor = ORANGE_COLOR;
        medButton.alpha = .5;
        
        highButton = [[UIButton alloc] initWithFrame:CGRectMake(275, 40, 30, 30)];
        [highButton addTarget:self action:@selector(addNewListItem:) forControlEvents:UIControlEventTouchUpInside];
        highButton.tag=3;
        highButton.layer.cornerRadius = 15;
        highButton.backgroundColor = RED_COLOR;
        highButton.alpha = .5;
        
        [self.tableView.tableHeaderView addSubview:newTODO];
        //        addsubveiew must be used to make the object visible
        [self.tableView.tableHeaderView addSubview:lowButton];
        [self.tableView.tableHeaderView addSubview:medButton];
        [self.tableView.tableHeaderView addSubview:highButton];
        
    }
    return self;
}

-(void)addNewListItem:(id)sender
{
    UIButton * button = (UIButton *)sender;
    NSString * name = newTODO.text;
    
    if (![name isEqualToString:@""])
    {
        [itemList insertObject:@{@"name":name, @"priority":@(button.tag)} atIndex:0];
        //button.tag is a number but since it's a variable object it must be in parentheses.
    }
    //    NSLog(@"%@", itemList);
    [self.tableView reloadData];
    
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

- (NSInteger)tableview:(UITableView *)tableview numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%lu",[itemList count]);
    return [itemList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TDLTableViewCellLow *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {cell = [[TDLTableViewCellLow alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];}
    
    NSDictionary * listItem = itemList[indexPath.row];
    
    cell.bgView.backgroundColor = priorityColors[[itemList[indexPath.row][@"priority"] intValue]];
    cell.textLabel.text = listItem[@"name"];
    
    //    cell.setTodoInfoLow = itemList[indexPath.row];
    
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
