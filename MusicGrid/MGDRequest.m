//
//  MGDRequest.m
//  MusicGrid
//
//  Created by T.J. Mercer on 6/7/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "MGDRequest.h"
#import "MGDData.h"

@implementation MGDRequest

-(void)sendDictionary:(NSDictionary *)dict andString:(NSString *)url
{
    // Create the request.
    NSLog(@"%@",dict);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://warm-caverns-3979.herokuapp.com/api/v1/%@",url]]];
    
    // Specify that it will be a POST request
    request.HTTPMethod = @"POST";
    
    // This is how we set header fields
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    
    //object for key
    
    [request setHTTPBody:jsonData];
    
    NSMutableData * responseData = [[NSMutableData alloc]init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        [responseData appendData:data];
        
        NSString * responseString = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
        NSDictionary * responseD = [[NSDictionary alloc]initWithContentsOfFile:responseString];
        
        
        //        NSDictionary * dd = [NSDictionary di]
        NSLog(@"%@",responseString);
        NSLog(@"%@",responseD);
        
        if (responseD[@"topalbums"])
        {
            for (NSDictionary * albumInfo in responseD[@"topalbums"][@"album"])
            {
                NSData * imageData = [NSData dataWithContentsOfURL:albumInfo[@"image"][2][@"#text"]];
                
                UIImage * image = [UIImage imageWithData:imageData];
                
                [[MGDData mainData].suggestions addObject:@{@"album":albumInfo[@"name"],
                                                            @"cover":image,
                                                            @"artist":albumInfo[@"artist"]
                                                            }];
            }
        }
        
        [MGDData mainData].token = responseD[@"user_token"];
    }];
    
    // Setting a timeout
    request.timeoutInterval = 20.0;
}

- (NSString *)urlEncodeValue:(NSString *)str
{
    NSString *result = (NSString *) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)str, NULL, CFSTR("?=&+"), kCFStringEncodingUTF8));
    return result;
}

#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}


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
