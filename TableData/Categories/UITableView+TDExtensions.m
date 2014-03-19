//
//  UITableView+TDExtensions.m
//  TableData
//
//  Created by Vitaliy Voronok on 3/7/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "UITableView+TDExtensions.h"
#import "NSBundle+TDExtensions.h"

@implementation UITableView (TDExtensions)

- (id)reusableCellOfClass:(Class)theClass {
	NSString *className = NSStringFromClass(theClass);
	id cell = [self dequeueReusableCellWithIdentifier:className];
	
	if (nil == cell) {
		cell = [[NSBundle mainBundle] loadClass:theClass];
	}
	
	return cell;
}

- (void)updateTableViewWithBlock:(void (^)(void))block {
    if (nil == block) {
        return;
    }
    
    [self beginUpdates];
    block();
    [self endUpdates];
}

@end
