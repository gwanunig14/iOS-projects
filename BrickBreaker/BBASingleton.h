//
//  BBASingleton.h
//  BrickBreaker
//
//  Created by T.J. Mercer on 5/6/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BBASingleton.h"

@interface BBASingleton : NSObject

+(BBASingleton *)sharedSingleton;

@end
