//
//  vkmusicTests.m
//  vkmusicTests
//
//  Created by Igor Nikolaev on 12/10/15.
//  Copyright © 2015 Igor Nikolaev. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "VKMNode.h"
#import "VKMAudioNode.h"

@interface vkmusicTests : XCTestCase

@end

@implementation vkmusicTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

#pragma mark - VKMNode Tests

- (void)testImpossibleToCreateNodeWithoutName {
    NSString *badName = nil;
    XCTAssertThrows([[VKMNode alloc] initWithName:badName]);
    XCTAssertThrows([[VKMNode alloc] initWithName:@""]);
    
}

- (void)testImpossibleToChangeNameAfterInitialization {
    NSMutableString *evilName = [NSMutableString stringWithString:@"123"];
    VKMNode *node = [[VKMNode alloc] initWithName:evilName];
    [evilName setString:@""];
    XCTAssertEqualObjects(node.name, @"123");
    XCTAssertNotEqual(node.name, @"");
}

#pragma mark - VKMAudioNode Tests

- (void)testImpossibleToCreateAudioNodeWithoutParams {
    NSString *badName = nil;
    XCTAssertThrows([[VKMAudioNode alloc] initWithName:badName type:@"mp3" size:2 artist:@"beatles" url:@"url" duration:2.0]);
    XCTAssertThrows([[VKMAudioNode alloc] initWithName:@"" type:@"mp3" size:2 artist:@"beatles" url:@"url" duration:2.0]);
}

@end
