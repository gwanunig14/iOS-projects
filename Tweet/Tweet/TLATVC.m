//
//  TLATVC.m
//  Tweet
//
//  Created by T.J. Mercer on 4/13/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "TLATVC.h"

@interface TLATVC ()

@end

@implementation TLATVC
{
    NSArray * tweets;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        tweets = @[@{
                       @"created_at": @"Sat Apr 12 03:35:47 +0000 2014",
                       @"id": @454825180305817600,
                       @"id_str": @"454825180305817600",
                       @"text": @"@foxjon123 What an awesome #FirstTweet ! So excited that you are doing things outside of what is being taught @TheIronYard #YouRock",
                       @"source": @"<a href=\"http://itunes.apple.com/us/app/twitter/id409789998?mt=12\" rel=\"nofollow\">Twitter for Mac</a>",
                       @"truncated": @false,
                       @"in_reply_to_status_id": @454805152306696200,
                       @"in_reply_to_status_id_str": @"454805152306696193",
                       @"in_reply_to_user_id": @2435447227,
                       @"in_reply_to_user_id_str": @"2435447227",
                       @"in_reply_to_screen_name": @"foxjon123",
                       @"user":  @{
                           @"id": @18487945,
                           @"id_str": @"18487945",
                           @"name": @"Jo Albright",
                           @"screen_name": @"Joalbright",
                           @"location": @"",
                           @"description": @"Co-Founder & iOS Developer for HighFive | iOS Instructor @TheIronYard",
                           @"url": @"http://t.co/0j8pzmKFox",
                           @"entities":  @{
                               @"url":  @{
                                   @"urls":  @[
                                             @{
                                                 @"url": @"http://t.co/0j8pzmKFox",
                                                 @"expanded_url": @"http://jo2.co",
                                                 @"display_url": @"jo2.co",
                                                 @"indices":  @[
                                                              @0,
                                                              @22
                                                              ]
                                             }
                                             ]
                               },
                               @"description":  @{
                                   @"urls":  @[]
                               }
                           },
                           @"protected": @false,
                           @"followers_count": @207,
                           @"friends_count": @313,
                           @"listed_count": @12,
                           @"created_at": @"Tue Dec 30 20:46:32 +0000 2008",
                           @"favourites_count": @26,
                           @"utc_offset": @-14400,
                           @"time_zone": @"Eastern Time (US & Canada)",
                           @"geo_enabled": @true,
                           @"verified": @false,
                           @"statuses_count": @201,
                           @"lang": @"en",
                           @"contributors_enabled": @false,
                           @"is_translator": @false,
                           @"is_translation_enabled": @false,
                           @"profile_background_color": @"FFFFFF",
                           @"profile_background_image_url": @"http://pbs.twimg.com/profile_background_images/267632372/logo.jpg",
                           @"profile_background_image_url_https": @"https://pbs.twimg.com/profile_background_images/267632372/logo.jpg",
                           @"profile_background_tile": @false,
                           @"profile_image_url": @"http://pbs.twimg.com/profile_images/420687815211364352/wF9mtzLq_normal.jpeg",
                           @"profile_image_url_https": @"https://pbs.twimg.com/profile_images/420687815211364352/wF9mtzLq_normal.jpeg",
                           @"profile_banner_url": @"https://pbs.twimg.com/profile_banners/18487945/1391875911",
                           @"profile_link_color": @"00E0E0",
                           @"profile_sidebar_border_color": @"FFFFFF",
                           @"profile_sidebar_fill_color": @"F7F7F7",
                           @"profile_text_color": @"424242",
                           @"profile_use_background_image": @true,
                           @"default_profile": @false,
                           @"default_profile_image": @false,
                           @"following": @false,
                           @"follow_request_sent": @false,
                           @"notifications": @false
                       }
                  }];
    }
    NSLog(@"%@", tweets);
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
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    NSLog(@"%d", [tweets count]);
    return [tweets count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSDictionary * blocks = tweets[indexPath.row];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.backgroundColor = [UIColor redColor];
    cell.textLabel.text = blocks[@"text"];
    
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
