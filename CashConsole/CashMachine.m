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
    _denominations = [[[denominations allObjects]
                       sortedArrayUsingDescriptors:
                       [NSArray arrayWithObject:
                        [NSSortDescriptor sortDescriptorWithKey: nil
                                                      ascending: NO
                                                       selector: @selector(compare:)]]]
                      filteredArrayUsingPredicate:
                      [NSPredicate predicateWithBlock:
                       ^BOOL(id evaluatedObject, NSDictionary *bindings) {return [evaluatedObject boolValue];}]];
}

//
- (int) sum: (NSArray*) notes {
    int s = 0;
    for(int i = 0; i < (long long)[notes count] - 1; ++i) s += [notes[i] intValue] * [_denominations[i] intValue];
    return s;
}

//
- (void) calculateNotes: (NSMutableArray*) notes startIndex: (long long) s cash: (int) cash {
    for(long long i = s; i < (long long)[notes count]; ++i) {
        [notes replaceObjectAtIndex: i withObject: @([notes[i] integerValue] + (cash - [self sum: notes]) / [_denominations[i] integerValue])];
        for(int j = [notes[i] intValue]; j >= 0; --j) {
            [notes replaceObjectAtIndex: i withObject: @(j)];
            if(!(cash - [self sum: notes])) result = [notes copy];
            if(s + 1 < (long long) [notes count]) [self calculateNotes: notes startIndex: s + 1 cash: cash];
        }
    }
}

//
- (NSArray*) getCash: (int) cash {
    NSMutableArray* notes = [[NSMutableArray alloc] initWithCapacity: [_denominations count]];
    for(unsigned long i = 0; i < (unsigned long)[_denominations count]; ++i) [notes addObject: @0];
    [self calculateNotes: notes startIndex: 0 cash: cash];
    if([self sum: result] == cash) return result;
    else return nil;
}

@end