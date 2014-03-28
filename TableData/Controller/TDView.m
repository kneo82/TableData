//
//  TDView.m
//  TableData
//
//  Created by Vitaliy Voronok on 3/5/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TDView.h"

@implementation TDView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.table = nil;
    self.editButton = nil;
    self.addButton = nil;
    self.loadingView = nil;
    self.loginView = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark Accessors

- (void)setEditing:(BOOL)editing {
    _editing = editing;
    
    [self setTableViewEditing:editing];
}

#pragma mark -
#pragma mark Private

- (void)setTableViewEditing:(BOOL)editing {
    self.editButton.title = editing ? @"Done" : @"Edit";
    [self.table setEditing:editing animated:YES];
}


@end
