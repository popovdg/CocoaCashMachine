//
//  ViewController.m
//  CashMachine
//
//  Created by popov on 03.11.15.
//  Copyright © 2015 popov. All rights reserved.
//

#import "ViewController.h"
#import "CashViewController.h"
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
    NSSet* values = [[NSSet alloc] initWithArray:
                      [[self.valuesField stringValue] componentsSeparatedByString:@" "]];
    CashMachine* cashMachine = [[CashMachine alloc] initWithDenominators: values];
    [self setMessage: [[cashMachine getCash: [self.cashField intValue]] componentsJoinedByString: @" "]];
    [self performSegueWithIdentifier:@"cashSegue" sender:self];
}

- (void)prepareForSegue:(NSStoryboardSegue*) segue sender: (id)sender {
    if ([[segue identifier] isEqualToString:@"cashSegue"]) {
        CashViewController* cashViewController = [segue destinationController];
        [cashViewController setMessage: [[self message] stringByAppendingString: @" "]];
    }
}

- (void)controlTextDidChange:(NSNotification *)notification {
    [self.getCashButton setEnabled: [self.cashField intValue]];
}
@end
