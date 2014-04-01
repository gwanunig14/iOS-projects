//
//  TJFLearningtool.h
//  Day2 Class
//
//  Created by T.J. Mercer on 4/1/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJFLearningtool : UIView

@property (nonatomic) NSString *learningtitle;

+ (NSNumber *)randomnumber;

-(NSString *)whatIsMyTitle;
-(void)changeTitleWithName:(NSString *)name andSomething: (NSString *)something;

@end
