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

/** Interface of a cash machine. */
@interface CashMachine : NSObject {
    NSArray* _denominations; /**< array of denominations */
    NSArray* result; /**< array of notes */
}

- (id) initWithDenominators: (NSSet*) denominations;
- (void) setDenominations: (NSSet*) denominations;
- (void) calculateNotes: (NSMutableArray*) notes startIndex: (long long) s cash: (int) cash;
- (int) sum: (NSArray*) notes;
- (void) updateResult: (NSArray*) notes;
- (NSArray*) getCash: (int) cash;
@end

#endif /* CashMachine_h */
