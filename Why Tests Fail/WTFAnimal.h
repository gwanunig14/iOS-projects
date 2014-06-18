//
//  WTFAnimal.h
//  Why Tests Fail
//
//  Created by T.J. Mercer on 6/17/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WTFAnimal : NSObject

@property (nonatomic) int amountOfLegs;
@property (nonatomic, getter = isCrawling) BOOL crawling;
@property (nonatomic, getter = isHairy) BOOL hairy;
@property (nonatomic) NSMutableArray * foodsItWillEat;

@end
