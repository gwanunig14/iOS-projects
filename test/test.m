//
//  testTableViewController.m
//  test
//
//  Created by T.J. Mercer on 6/16/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "test.h"

@interface test ()

@end

@implementation test
{
    NSMutableArray * display;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
        display = [@[]mutableCopy];
        
        NSMutableDictionary * testD = [@{@"new" : @{@"characters" : @{@"1" : @2,
                                                                      @"3" : @1
                                                                      },
                                                    @"projectInfo" : @[@{@"heading" : @1,
                                                                         @"info" : @[@{@"character" : @1,
                                                                                       @"plotpoint" : @"Threeish"
                                                                                       },
                                                                                     @{@"character" : @2,
                                                                                       @"plotpoint" : @"Threeish"
                                                                                       },
                                                                                     @{@"character" : @1,
                                                                                       @"plotpoint" : @"Six"
                                                                                       },
                                                                                     @{@"character" : @2,
                                                                                       @"plotpoint" : @"Five or more"
                                                                                       },
                                                                                     @{@"character" : @1,
                                                                                       @"plotpoint" : @"Five or more"
                                                                                       }
                                                                                     ],
                                                                         },
                                                                       @{@"heading" : @2,
                                                                         @"info" : @[@{@"character" : @1,
                                                                                       @"plotpoint" : @"Hi"
                                                                                       },
                                                                                     @{@"character" : @2,
                                                                                       @"plotpoint" : @"Two"
                                                                                       },
                                                                                     @{@"character" : @1,
                                                                                       @"plotpoint" : @"F"
                                                                                       },
                                                                                     [@{@"character" : @0,
                                                                                        @"plotpoint" : @"Yo"
                                                                                        } mutableCopy],
                                                                                     [@{@"character" : @0,
                                                                                        @"plotpoint" : @"Yo"
                                                                                        } mutableCopy],
                                                                                     @{@"character" : @2,
                                                                                       @"plotpoint" : @"Huh?"
                                                                                       }
                                                                                     ]
                                                                         }
                                                                       ]
                                                    }
                                         } mutableCopy];
        
        for (NSDictionary * one in testD[@"new"][@"projectInfo"])
        {
            NSLog(@"change 1 %@",one);
            for (NSDictionary * two in one[@"info"])
            {
                NSLog(@"change 2 %@",two);
                if ([two[@"character"]  isEqual: @2])
                {
                    [display addObject:two[@"plotpoint"]];
                };
            };
        };
        NSLog(@"%@",display);
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

    return [display count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"celle"];
    
    UILabel * characterName = [[UILabel alloc]initWithFrame:CGRectMake(40, 20, self.view.frame.size.width -12, 20)];
    
    characterName.text = display[indexPath.row];
    
    NSLog(@"%@", display);
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    [cell addSubview:characterName];
    
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
