//
//  TDObservableObject.m
//  TableData
//
//  Created by Vitaliy Voronok on 3/9/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TDObservableObject.h"

#import "TDWeakReference.h"

@interface TDObservableObject ()
@property (nonatomic, retain)   NSMutableArray *mutableObservers;

@end

@implementation TDObservableObject

@dynamic observers;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
	self.mutableObservers = nil;
    
	[super dealloc];
}

- (id)init {
	self = [super init];
	if (self) {
		self.mutableObservers = [NSMutableArray array];
	}
    
	return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)observers {
    NSArray *observers = nil;
    @synchronized(self.mutableObservers) {
        observers = [[self.mutableObservers copy] autorelease];
    }
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:[observers count]];
    for (TDWeakReference *reference in observers) {
        [result addObject:reference.object];
    }
    
    return [[result copy] autorelease];
}

#pragma mark -
#pragma mark Public

- (void)addObserver:(id <NSObject>)object {
    TDWeakReference *reference = [TDWeakReference referenceWithObject:object];
    NSMutableArray *observers = self.mutableObservers;
    @synchronized(observers) {
        if (![observers containsObject:reference]) {
            [observers addObject:reference];
        }
    }
}

- (void)removeObserver:(id)object {
    TDWeakReference *reference = [TDWeakReference referenceWithObject:object];
    @synchronized(self.mutableObservers) {
        [self.mutableObservers removeObject:reference];
    }
}

- (void)notifyObserversWithSelector:(SEL)selector {
    [self notifyObserversWithBlock:^(id<NSObject> observer) {
        if ([observer respondsToSelector:selector]) {
            [observer performSelector:selector withObject:self];
        }
    }];
}

- (void)notifyObserversWithSelector:(SEL)selector object:(id)object {
    [self notifyObserversWithBlock:^(id<NSObject> observer) {
        if ([observer respondsToSelector:selector]) {
            [observer performSelector:selector withObject:self withObject:object];
        }
    }];
}

- (void)notifyObserversWithBlock:(void (^)(id <NSObject> observer))block {
    NSArray *observers = self.observers;

    dispatch_async(dispatch_get_main_queue(), ^{
        for (id <NSObject> observer in observers) {
            block(observer);
        }
    });
}

@end
