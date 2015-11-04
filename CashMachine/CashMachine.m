//
//  CashMachine.m
//  CashConsole
//
//  Created by popov on 29.10.15.
//  Copyright © 2015 popov. All rights reserved.
//

#import "CashMachine.h"

@implementation CashMachine

//Initialize with array of values
- (id)initWithDenominators: (NSArray*) denominations {
    if(self = [super init]) [self setDenominations: denominations];
    return self;
}

//Set values
- (void) setDenominations: (NSArray*) denominations {
    
    _denominations = [[[[[NSSet alloc] initWithArray:[denominations valueForKey: @"integerValue"]] allObjects]
                       filteredArrayUsingPredicate:
                       [NSPredicate predicateWithBlock:
                        ^BOOL(id evaluatedObject, NSDictionary *bindings) {return [evaluatedObject intValue];}]]
                      sortedArrayUsingDescriptors:
                      [NSArray arrayWithObject:
                       [NSSortDescriptor sortDescriptorWithKey: nil
                                                     ascending: NO
                                                      selector: @selector(compare:)]]];
}

//Calculates the sum of money
- (int) sum: (NSArray*) notes {
    int s = 0;
    if([notes count] == [_denominations count])
        for(int i = 0; i < (long long)[notes count]; ++i) s += [notes[i] intValue] * [_denominations[i] intValue];
    return s;
}

//Save result if it better meets the conditions
- (void) updateResult: (NSArray*) notes {
    int notesCount = 0;
    int resultCount = 0;
    int notesDenominations = 0;
    int resultDenominations = 0;
    
    for(long long i = 0; i < (long long)[notes count]; ++i)
        if([notes[i] boolValue]) {
            ++notesDenominations;
            notesCount += [notes[i] intValue];
        }
    for(long long i = 0; i < (long long)[result count]; ++i)
        if([result[i] boolValue]) {
            ++resultDenominations;
            resultCount += [result[i] intValue];
        }

    if(notesDenominations > resultDenominations ||
       (notesDenominations == resultDenominations &&
        (!resultCount || notesCount < resultCount))) result = [notes copy];
}

//Calculate bank notes to be ejected and save to 'result'
- (void) calculateNotes: (NSMutableArray*) notes startIndex: (long long) s cash: (int) cash {
    if([notes count] == [_denominations count])
        for(long long i = s; i < (long long)[notes count]; ++i) {
            [notes replaceObjectAtIndex: i withObject: @([notes[i] integerValue] + (cash - [self sum: notes]) / [_denominations[i] integerValue])];
            for(int j = [notes[i] intValue]; j >= 0; --j) {
                [notes replaceObjectAtIndex: i withObject: @(j)];
                if(!(cash - [self sum: notes])) [self updateResult: notes];
                if(s + 1 < (long long) [notes count]) [self calculateNotes: notes startIndex: s + 1 cash: cash];
        }
    }
}

//Returns result if possible
- (NSArray*) getCash: (int) cash {
    result = nil;
    NSMutableArray* notes = [[NSMutableArray alloc] initWithCapacity: [_denominations count]];
    for(unsigned long i = 0; i < (unsigned long)[_denominations count]; ++i) [notes addObject: @0];
    [self calculateNotes: notes startIndex: 0 cash: cash];
    if([self sum: result] == cash) return result;
    else return nil;
}

@end