//
//  TDLGitHubRequest.h
//  TODO
//
//  Created by T.J. Mercer on 4/7/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDLGitHubRequest : NSObject

+ (NSDictionary *)getUserWithUsername: (NSString *)username;

@end
