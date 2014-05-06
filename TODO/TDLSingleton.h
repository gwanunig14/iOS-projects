//
//  TDLSingleton.h
//  TODO
//
//  Created by T.J. Mercer on 5/6/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDLSingleton : NSObject

+(TDLSingleton *)sharedSingleton;

-(void)addListItem:(NSDictionary *)listItem;
-(void)removeListItem:(NSDictionary *)listItem;
-(void)removeListItemAtIndex:(NSInteger)index;
-(NSArray *)allListItems;

@end
