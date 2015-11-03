//
//  ViewController.m
//  CashMachine
//
//  Created by popov on 03.11.15.
//  Copyright © 2015 popov. All rights reserved.
//

#import "ViewController.h"
#import "CashMachine.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    [self.cashField setDelegate: self];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)getCash:(id)sender {
    if(![[self.valuesField stringValue] length]) return;
    if(!([[self.cashField stringValue] length] && [self.cashField intValue])) return;
    NSSet* values = [[NSSet alloc] initWithArray: [[self.valuesField stringValue] componentsSeparatedByString:@" "]];
    for(id item in values) if(![item isKindOfClass:[NSNumber class]]) return;
    CashMachine* cashMachine = [[CashMachine alloc] initWithDenominators: values];
    [cashMachine getCash: [self.cashField intValue]];
}

- (void)controlTextDidChange:(NSNotification *)notification {
    [self.getCashButton setEnabled: [self.cashField intValue]];
}
@end
