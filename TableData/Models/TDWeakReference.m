//
//  TDWeakReference.m
//  TableData
//
//  Created by Oleksa Korin on 10/3/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TDWeakReference.h"

#import "NSObject+TDExtensions.h"

@interface TDWeakReference ()
@property (nonatomic, assign)     id<NSObject>    object;

@end

@implementation TDWeakReference

#pragma mark -
#pragma mark Class Methods

+ (id)referenceWithObject:(id<NSObject>)object {
    TDWeakReference *result = [self object];
    result.object = object;
    
    return result;
}

#pragma mark -
#pragma mark Public

- (NSUInteger)hash {
    return (NSUInteger)self.object;
}

- (BOOL)isEqual:(id <NSObject>)object {
    if ([object isMemberOfClass:[self class]]) {
        TDWeakReference *reference = (TDWeakReference *)object;
        return reference.object == self.object;
    }
    
    return NO;
}

@end
