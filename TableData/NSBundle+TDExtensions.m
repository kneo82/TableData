//
//  NSBundle+TDExtensions.m
//  TableData
//
//  Created by Vitaliy Voronok on 3/6/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "NSBundle+TDExtensions.h"

@implementation NSBundle (TDExtensions)

- (id)loadClass:(Class)theClass {
    return [self loadClass:theClass owner:nil];
}

- (id)loadClass:(Class)theClass
          owner:(id)owner
{
    return [self loadClass:theClass owner:owner options:nil];
}

- (id)loadClass:(Class)theClass
          owner:(id)owner
        options:(NSDictionary *)options
{
    return [self loadClass:theClass
                     owner:owner
                   options:options
                   nibName:NSStringFromClass(theClass)];
}

- (id)loadClass:(Class)theClass
          owner:(id)owner
        options:(NSDictionary *)options
        nibName:(NSString *)nibName
{
    NSArray *objects = [[NSBundle mainBundle] loadNibNamed:nibName
                                                     owner:owner
                                                   options:options];
    
    for (id <NSObject> object in objects) {
        if ([object isMemberOfClass:theClass]) {
            return object;
        }
    }
    
    return nil;
}

@end
