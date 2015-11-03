//
//  main.m
//  CashConsole
//
//  Created by popov on 29.10.15.
//  Copyright © 2015 popov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CashMachine.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        CashMachine * cashMachine = [[CashMachine alloc] initWithDenominators: [NSSet setWithObjects: @50,@30,@20,nil]];
        NSLog(@"%@",[cashMachine getCash: 80]);
    }
    return 0;
}
