//
//  CashMachine.h
//  CashConsole
//
//  Created by popov on 29.10.15.
//  Copyright © 2015 popov. All rights reserved.
//

#ifndef CashMachine_h
#define CashMachine_h

#import <Foundation/Foundation.h>
#import <Foundation/NSArray.h>

/** Cash machine */
@interface CashMachine : NSObject {
    NSArray* _denominations; /**< values of bank notes in cash machine */
    NSArray* result; /**< numbers of bank notes to be ejected */
}

/**
 Initialize with array of values
 @param denominations a set of values
 @returns self
 */
- (id) initWithDenominators: (NSSet*) denominations;

/**
 Set values
 @param denominations set of values
 */
- (void) setDenominations: (NSSet*) denominations;

/**
 Calculate bank notes to be ejected and save to 'result'
 @param notes temporary array of numbers of bank notes
 @param s start index of 'notes'
 @param cash cash to be ejected
 */
- (void) calculateNotes: (NSMutableArray*) notes startIndex: (long long) s cash: (int) cash;

/**
 Calculates the sum of money
 @param notes numbers of bank notes
 @returns sum the sum of money
 */
- (int) sum: (NSArray*) notes;

/**
 Save result if it better meets the conditions
 @param notes numbers of bank notes
 */
- (void) updateResult: (NSArray*) notes;

/**
 Returns result if possible
 @param cash requested cash
 @returns cash cash to be ejected
 @retval nil imposible to get the cash
 */
- (NSArray*) getCash: (int) cash;
@end

#endif /* CashMachine_h */