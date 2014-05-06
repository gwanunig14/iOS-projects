//
//  TDLSingleton.m
//  TODO
//
//  Created by T.J. Mercer on 5/6/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "TDLSingleton.h"

@interface TDLSingleton ()

@property (nonatomic) NSMutableArray *listItems;

@end

@implementation TDLSingleton

+(TDLSingleton *)sharedSingleton
{
    static dispatch_once_t create;
    static TDLSingleton * singleton=nil;
    
    dispatch_once (&create, ^{
        singleton = [[TDLSingleton alloc]init];
    });
    
    return singleton;
}

-(id)init
{
    self = [super init];
    if (self)
    {
        [self loadListItems];
    }
    
    return self;
}

-(NSMutableArray *)listItems
{
    if(_listItems == nil)
    {
        _listItems = [@[]mutableCopy];
    }
    return _listItems;
}

-(void)addListItem:(NSDictionary *)listItem
{
    [self.listItems addObject:listItem];
    [self saveData];
}

-(void)removeListItem:(NSDictionary *)listItem
{
    [self.listItems removeObjectIdenticalTo:listItem];
    [self saveData];
}

-(void)removeListItemAtIndex:(NSInteger)index
{
    [self.listItems removeObjectAtIndex:index];
    [self saveData];
}

-(NSArray *)allListItems
{
    return [self.listItems copy];
}

-(void)saveData
{
    NSString *path = [self listArchivePath];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.listItems];
    [data writeToFile:path options:NSDataWritingAtomic error:nil];
}

- (NSString *)listArchivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = documentDirectories[0];
    return [documentDirectory stringByAppendingPathComponent:@"listdata.data"];
}

-(void)loadListItems
{
    NSString *path = [self listArchivePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        self.listItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    }
}

@end
