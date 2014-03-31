//
//  UITableView+TDExtensions.m
//  TableData
//
//  Created by Vitaliy Voronok on 3/31/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "UITableView+TDExtensions.h"

@implementation UITableView (TDExtensions)

- (void)updateTableViewWithBlock:(void (^)(void))block {
    if (nil == block) {
        return;
    }
    
    [self beginUpdates];
    block();
    [self endUpdates];
}

@end
