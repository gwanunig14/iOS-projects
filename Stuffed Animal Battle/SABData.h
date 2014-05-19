//
//  SABData.h
//  Stuffed Animal Battle
//
//  Created by T.J. Mercer on 5/18/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SABDelegate;

@interface SABData : NSObject

@property (nonatomic, assign) id<SABDelegate> delegate;

+(SABData *)mainData;

@property (nonatomic) float player2Life;

@end

@protocol SABDelegate <NSObject>

-(void)lifeLost;

@end
