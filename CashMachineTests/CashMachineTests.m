//
//  CashMachineTests.m
//  CashMachineTests
//
//  Created by popov on 03.11.15.
//  Copyright © 2015 popov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CashMachine.h"

@interface CashMachineTests : XCTestCase

@end

@implementation CashMachineTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testInit {
    CashMachine* cashMachine = [CashMachine alloc];
    
    NSArray* values = @[@50, @100, @10, @20]; //Unsorted values
    NSArray* correctResult = @[@100, @50, @20, @10];
    [cashMachine setDenominations: values];
    NSArray* result = [cashMachine denominations];
    XCTAssertEqualObjects(result, correctResult, @"setDenominations for unsorted values fails");
    
    values = @[@50, @100, @0, @10, @20]; //With 0$
    correctResult = @[@100, @50, @20, @10];
    [cashMachine setDenominations: values];
    result = [cashMachine denominations];
    XCTAssertEqualObjects(result, correctResult, @"setDenominations for values with 0 fails");
    
    values = @[@50, @100, @20, @10, @20]; //With duplicates
    correctResult = @[@100, @50, @20, @10];
    [cashMachine setDenominations: values];
    result = [cashMachine denominations];
    XCTAssertEqualObjects(result, correctResult, @"setDenominations for values with duplicates fails");
    
    values = @[@50, @100, @"test", @10, @20]; //With string
    correctResult = @[@100, @50, @20, @10];
    [cashMachine setDenominations: values];
    result = [cashMachine denominations];
    XCTAssertEqualObjects(result, correctResult, @"setDenominations for values with string fails");
}

- (void) testSum {
    CashMachine* cashMachine = [CashMachine alloc];
    
    NSArray* values = @[@50, @100, @10, @20]; //Unsorted values
    [cashMachine setDenominations: values];
    int sum = [cashMachine sum: @[@1, @0, @10, @1]];
    XCTAssertEqual(sum, 310);
    
    values = @[@50, @100, @0, @10, @20]; //With 0$
    [cashMachine setDenominations: values];
    sum = [cashMachine sum: @[@1, @0, @10, @1]];
    XCTAssertEqual(sum, 310);
    
    values = @[@50, @100, @20, @10, @20]; //With duplicates
    [cashMachine setDenominations: values];
    sum = [cashMachine sum: @[@1, @0, @10, @1]];
    XCTAssertEqual(sum, 310);
    
    values = @[@50, @100, @"test", @10, @20]; //With string
    [cashMachine setDenominations: values];
    sum = [cashMachine sum: @[@1, @0, @10, @1]];
    XCTAssertEqual(sum, 310);
}

- (void)testExamples {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    CashMachine* cashMachine = [CashMachine alloc];

    NSArray* values = @[@50, @100, @10, @20]; //Unsorted values
    [cashMachine setDenominations: values];
    NSArray* result = [cashMachine getCash: 50];
    NSArray* correctResult = @[@0, @0, @2, @1];
    XCTAssertEqualObjects(result, correctResult, @"Bad result of ejecting 50$ for unsorted values");
    
    values = @[@50, @100, @0, @10, @20]; //With 0$
    result = [cashMachine getCash: 10];
    correctResult = @[@0, @0, @0, @1];
    XCTAssertEqualObjects(result, correctResult, @"Bad result of ejecting 10$ for values with 0");
    
    values = @[@50, @100, @20, @10, @20]; //With duplicates
    result = [cashMachine getCash: 20];
    correctResult = @[@0, @0, @1, @0];
    XCTAssertEqualObjects(result, correctResult, @"Bad result of ejecting 20$ for duplicated values");
    
    values = @[@50, @100, @"test", @10, @20]; //With string
    result = [cashMachine getCash: 10];
    correctResult = @[@0, @0, @0, @1];
    XCTAssertEqualObjects(result, correctResult, @"Bad result of ejecting 10$ for values with string");
    
    values = @[@100, @500, @20, @10]; //Incorrect sum
    result = [cashMachine getCash: 1];
    XCTAssertNil(result, @"Bad result of ejecting incorrect sum");
}
@end
