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

- (void) testInit { //Testing setDenominations
    CashMachine* cashMachine = [CashMachine alloc];
    
    //Unsorted values
    NSArray* values = @[@50, @100, @10, @20];
    NSArray* correctResult = @[@100, @50, @20, @10];
    [cashMachine setDenominations: values];
    NSArray* result = [cashMachine denominations];
    XCTAssertEqualObjects(result, correctResult, @"setDenominations for unsorted values fails");
    
    //With 0$
    values = @[@50, @100, @0, @10, @20];
    correctResult = @[@100, @50, @20, @10];
    [cashMachine setDenominations: values];
    result = [cashMachine denominations];
    XCTAssertEqualObjects(result, correctResult, @"setDenominations for values with 0 fails");
    
    //With duplicates
    values = @[@50, @100, @20, @10, @20];
    correctResult = @[@100, @50, @20, @10];
    [cashMachine setDenominations: values];
    result = [cashMachine denominations];
    XCTAssertEqualObjects(result, correctResult, @"setDenominations for values with duplicates fails");
    
    //With string
    values = @[@50, @100, @"test", @10, @20];
    correctResult = @[@100, @50, @20, @10];
    [cashMachine setDenominations: values];
    result = [cashMachine denominations];
    XCTAssertEqualObjects(result, correctResult, @"setDenominations for values with string fails");
}

- (void) testSum { //Testing sum
    CashMachine* cashMachine = [CashMachine alloc];
    
    //Unsorted values
    NSArray* values = @[@50, @100, @10, @20];
    [cashMachine setDenominations: values];
    int sum = [cashMachine sum: @[@1, @0, @10, @1]];
    XCTAssertEqual(sum, 310);
    
    //With 0$
    values = @[@50, @100, @0, @10, @20];
    [cashMachine setDenominations: values];
    sum = [cashMachine sum: @[@1, @0, @10, @1]];
    XCTAssertEqual(sum, 310);
    
    //With duplicates
    values = @[@50, @100, @20, @10, @20];
    [cashMachine setDenominations: values];
    sum = [cashMachine sum: @[@1, @0, @10, @1]];
    XCTAssertEqual(sum, 310);
    
    //With string
    values = @[@50, @100, @"test", @10, @20];
    [cashMachine setDenominations: values];
    sum = [cashMachine sum: @[@1, @0, @10, @1]];
    XCTAssertEqual(sum, 310);
}

- (void)testExamples { //Testing getCash
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    CashMachine* cashMachine = [CashMachine alloc];

    //Unsorted values
    NSArray* values = @[@50, @100, @10, @20];
    [cashMachine setDenominations: values];
    NSArray* result = [cashMachine getCash: 50];
    NSArray* correctResult = @[@0, @0, @2, @1];
    XCTAssertEqualObjects(result, correctResult, @"Bad result of ejecting 50$ for unsorted values");
    
    //With 0$
    values = @[@50, @100, @0, @10, @20];
    result = [cashMachine getCash: 10];
    correctResult = @[@0, @0, @0, @1];
    XCTAssertEqualObjects(result, correctResult, @"Bad result of ejecting 10$ for values with 0");
    
    //With duplicates
    values = @[@50, @100, @20, @10, @20];
    result = [cashMachine getCash: 20];
    correctResult = @[@0, @0, @1, @0];
    XCTAssertEqualObjects(result, correctResult, @"Bad result of ejecting 20$ for duplicated values");
    
    //With string
    values = @[@50, @100, @"test", @10, @20];
    result = [cashMachine getCash: 10];
    correctResult = @[@0, @0, @0, @1];
    XCTAssertEqualObjects(result, correctResult, @"Bad result of ejecting 10$ for values with string");
    
    //Incorrect sum
    values = @[@100, @500, @20, @10];
    result = [cashMachine getCash: 1];
    XCTAssertNil(result, @"Bad result of ejecting incorrect sum");
    
    //With nil
    values = nil;
    result = [cashMachine getCash: 1];
    XCTAssertNil(result, @"Bad result of testing with nil values");
}
@end
