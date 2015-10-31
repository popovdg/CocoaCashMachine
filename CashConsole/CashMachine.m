//
//  CashMachine.m
//  CashConsole
//
//  Created by popov on 29.10.15.
//  Copyright © 2015 popov. All rights reserved.
//

#import "CashMachine.h"

@implementation CashMachine

//
- (id)initWithDenominators: (NSSet*) denominations {
    if(self = [super init]) [self setDenominations: denominations];
    return self;
}

//
- (void) setDenominations: (NSSet*) denominations {
    _denominations = [[denominations allObjects]
                       sortedArrayUsingDescriptors:
                       [NSArray arrayWithObject:
                        [NSSortDescriptor sortDescriptorWithKey: nil
                                                      ascending: NO
                                                       selector: @selector(compare:)]]];
}

//
- (int) sum: (NSArray*) notes {
    int s;
    for(int i = 0; i < (long long)[notes count]; ++i) s += [notes[i] intValue] * [_denominations[i] intValue];
    return s;
}

//
- (void) calculateNotes: (NSMutableArray*) notes startIndex: (long long) s remainder: (int) r {
    for(long long i = s; i < (long long)[notes count] - 1; ++i)
        for(int j = [notes[i] intValue]; j >= 0; --j) {
            
            //[self calculateNotes:notes startIndex: i + 1 remainder: r - [self sum: notes]];
        }
}

//
- (NSArray*) getCash: (int) cash {
    NSMutableArray* notes = [[NSMutableArray alloc] initWithCapacity: [_denominations count]];
    for (unsigned long i = 0; i < (unsigned long)[_denominations count]; ++i) [notes addObject: @0];
    [self calculateNotes: notes startIndex: 0 remainder: cash];
    return notes;
}

@end