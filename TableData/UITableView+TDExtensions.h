//
//  UITableView+TDExtensions.h
//  TableData
//
//  Created by Vitaliy Voronok on 3/31/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (TDExtensions)

// This message calls beginUpdates prior to the block execution
// and endUpdates after the block execution
- (void)updateTableViewWithBlock:(void (^)(void))block;

@end
