//
//  ViewController.h
//  CashMachine
//
//  Created by popov on 03.11.15.
//  Copyright © 2015 popov. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController <NSTextFieldDelegate>
@property (weak) IBOutlet NSButtonCell *getCashButton;
@property (weak) IBOutlet NSTextField *cashField;
@property (weak) IBOutlet NSTextField *valuesField;
@property (nonatomic) NSString* message;
- (IBAction)getCash:(id)sender;
- (void)controlTextDidChange:(NSNotification *)notification;
- (void)prepareForSegue:(NSStoryboardSegue*) segue sender: (id)sender;
@end

