//
//  TPAViewController.m
//  TwitterPost
//
//  Created by T.J. Mercer on 5/20/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "TPAViewController.h"
#import <MapKit/MapKit.h>
#import "STTwitter.h"

@interface TPAViewController () <CLLocationManagerDelegate>

@end

@implementation TPAViewController
{
    STTwitterAPI * twitter;
    UITextField * tweetField;
    
    NSString * currentLatitude;
    NSString * currentLongitude;
    
    CLLocationManager * lManager;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        twitter = [STTwitterAPI twitterAPIOSWithFirstAccount];
        
        [twitter verifyCredentialsWithSuccessBlock:^(NSString *username) {
            
            NSLog(@"%@",username);
            
        } errorBlock:^(NSError *error) {
            
            NSLog(@"%@",error.userInfo);
            
        }];
        
        lManager = [[CLLocationManager alloc] init];
        lManager.delegate = self;
        
        lManager.distanceFilter = 10;
        
        [lManager startUpdatingLocation];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    int w = [UIScreen mainScreen].bounds.size.width;
    int h = [UIScreen mainScreen].bounds.size.height;
    
    tweetField = [[UITextField alloc]initWithFrame:CGRectMake(20, 20 , w-40, h-296)];
//    writeStatus.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:tweetField];
    
    UIButton * tweetButton = [[UIButton alloc]initWithFrame:CGRectMake(0, h-276, w, 60)];
    tweetButton.backgroundColor = [UIColor colorWithRed:0.208f green:0.710f blue:0.843f alpha:1.0f];
    [tweetButton setTitle:@"Tweet" forState:UIControlStateNormal];
    [tweetButton addTarget:self action:@selector(postTweet) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tweetButton];
}

-(void)postTweet
{
    [twitter postStatusUpdate:tweetField.text inReplyToStatusID:nil latitude:currentLatitude longitude:currentLongitude placeID:nil displayCoordinates:nil trimUser:nil successBlock:^(NSDictionary *status) {
        NSLog(@"%@",status);
    } errorBlock:^(NSError *error) {
        NSLog(@"%@",error.userInfo);
    }];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"location");
    for (CLLocation * location in locations) {
        
        CLGeocoder * geoCoder = [[CLGeocoder alloc]init];
        
        [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
            currentLatitude = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
            currentLongitude = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
        }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
