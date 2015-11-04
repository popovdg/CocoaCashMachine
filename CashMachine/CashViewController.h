//
//  CashViewController.h
//  CashMachine
//
//  Created by popov on 04.11.15.
//  Copyright © 2015 popov. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CashViewController : NSViewController
@property (weak) IBOutlet NSTextField *messageField;
@property (nonatomic) NSString* message;
@end
