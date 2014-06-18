//
//  WTFAnimal.m
//  Why Tests Fail
//
//  Created by T.J. Mercer on 6/17/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "WTFAnimal.h"

@implementation WTFAnimal

-(void)setAmountOfLegs:(int)amountOfLegs
{
    _amountOfLegs = amountOfLegs;
    
    self.crawling = (amountOfLegs > 2);
}

@end
