//
//  washComlexTest.m
//  washComlexTest
//
//  Created by Nikola Andriiev on 16.06.16.
//  Copyright © 2016 Anfriiev.Mykola. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ANSCarWashComplex.h"

@interface washComlexTest : XCTestCase {
    @private
    ANSCarWashComplex *complex;
    ANSCar *car;
}

@end

@implementation ANSCarWashComlexTest

- (void)setUp {
    [super setUp];
    complex = [[ANSCarWashComplex new] autorelease];
    car = [[ANSCar new] autorelease];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    XCTAssertNotNil(complex, @"complex should not be nil");
    XCTAssertNotNil(car, @"car should not be nil");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
