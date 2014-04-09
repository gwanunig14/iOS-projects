
//
//  TDLGitHubRequest.m
//  TODO
//
//  Created by T.J. Mercer on 4/7/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "TDLGitHubRequest.h"

@implementation TDLGitHubRequest

+(NSDictionary *)getUserWithUsername:(NSString *)username

{
    NSMutableDictionary * userInfo = [@{} mutableCopy];
    
    NSString * gitHub = [NSString stringWithFormat:@"https://api.github.com/users/%@", username];
    
    NSURL * url = [NSURL URLWithString:gitHub];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
//    NSOperationQueue * queue = [[NSOperationQueue alloc] init];
    
//    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
//    {
//        if (connectionError == nil)
//        {
//            
//        } else {
//            NSLog(@"%@", connectionError);
//        }
//        
//    }];
//
    NSURLResponse * response = nil;
    NSError * error = nil;
    
    NSData * responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSError * jsonError = nil;
    
    NSDictionary * githubProfile = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&jsonError];
    
//    for (NSString * key in [githubProfile allKeys]) {
//
//    }
    
    NSLog(@"%@", githubProfile);
    
    if (githubProfile [@"name"] !=nil) userInfo[@"name"] = githubProfile[@"name"];
    if (githubProfile [@"avatar_url"] != nil) userInfo [@"image"] = githubProfile[@"avatar_url"];
    if (githubProfile [@"html_url"] != nil) userInfo [@"github"] = githubProfile[@"html_url"];
    
//    userInfo = @{
//                 @"name": githubProfile [@"name"],
//                 @"image": githubProfile[@"avatar_url"],
//                 @"github" : githubProfile [@"html_url"]
//                 };
//    
    return userInfo;
}

@end