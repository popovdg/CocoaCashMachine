//
//  CashViewController.m
//  CashMachine
//
//  Created by popov on 04.11.15.
//  Copyright © 2015 popov. All rights reserved.
//

#import "CashViewController.h"

@interface CashViewController ()

@end

@implementation CashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    if([self message]) [[self messageField] setStringValue: [self message]];
    else [[self messageField] setStringValue: @"Sorry, no bank notes avilable to give the cash."];
}

@end
