//
//  UITableView+TDExtensions.h
//  TableData
//
//  Created by Vitaliy Voronok on 3/7/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (TDExtensions)

// Deuqeues or creates the reusable cell of class |theClass|
// Cell identifier must be the same as its class name
// Cell nib name must be the same as its class name
// Nib must contain one and only one top level object of any class
- (id)reusableCellOfClass:(Class)theClass;

// This message calls beginUpdates prior to the block execution
// and endUpdates after the block execution
- (void)updateTableViewWithBlock:(void (^)(void))block;

@end
