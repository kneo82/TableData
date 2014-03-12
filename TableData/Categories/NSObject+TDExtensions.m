//
//  NSObject+TDExtensions.m
//  TableData
//
//  Created by Vitaliy Voronok on 3/6/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "NSObject+TDExtensions.h"

@implementation NSObject (TDExtensions)

+ (id)object {
    return [[[self alloc] init] autorelease];
}

@end
