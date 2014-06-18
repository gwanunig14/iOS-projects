//
//  Why_Tests_FailTests.m
//  Why Tests FailTests
//
//  Created by T.J. Mercer on 6/17/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface Why_Tests_FailTests : XCTestCase

@end

@implementation Why_Tests_FailTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

@end
