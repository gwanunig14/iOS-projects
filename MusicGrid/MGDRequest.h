//
//  MGDRequest.h
//  MusicGrid
//
//  Created by T.J. Mercer on 6/7/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGDRequest : NSObject <NSURLConnectionDelegate>
{
    NSMutableData * _responseData;
}

-(void)sendDictionary:(NSDictionary *)dict andString:(NSString *)url;

@end
