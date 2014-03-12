//
//  TDModelImages.m
//  TableData
//
//  Created by Vitaliy Voronok on 3/10/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TDModelImages.h"

#import "TDModelImage.h"

#include "NSObject+TDExtensions.h"

@interface TDModelImages ()
@property (nonatomic, retain, readwrite)   NSMutableArray  *mutableModelImages;

@end

@implementation TDModelImages

@dynamic modelImages;

#pragma mark -
#pragma mark Class Methods

+ (TDModelImages *)sharedInstance {
    static TDModelImages *singletoneObject = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singletoneObject = [[self alloc] init];
    });

    return  singletoneObject;
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.mutableModelImages = nil;
    
    [super dealloc];
}

- (id)init {
    self = [super init];
    if (self) {
        self.mutableModelImages = [NSMutableArray array];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)modelImages {
    @synchronized (self.mutableModelImages) {
        return [[self.mutableModelImages copy] autorelease];
    }
}

#pragma mark -
#pragma mark Public

- (void)addModel:(TDModelImage *)model {
    @synchronized(self.mutableModelImages) {
        NSMutableArray *mutableModelImages = self.mutableModelImages;
        if (![mutableModelImages containsObject:model]) {
            [mutableModelImages addObject:model];
        }
    }
}

- (void)removeModel:(TDModelImage *)model {
    @synchronized(self.mutableModelImages) {
        model.countUsedModel--;
        if (0 == model.countUsedModel) {
            [self.mutableModelImages removeObject:model];
        }
    }
}

- (TDModelImage *)takeModelWhisFileName:(TDModelImage *)model {
    if (!model) {
        return nil;
    }
    @synchronized (self.mutableModelImages) {
        NSArray *modelImages = self.modelImages;
        if (!model.imageFileName) {
            model.imageFileName = @"smile.png";
        }
        for (TDModelImage *theModel in modelImages) {
            if (0 == [theModel.imageFileName compare:model.imageFileName]) {
                NSArray *observers = model.observers;
                NSArray *observersTheModel = theModel.observers;
                for (id observer in observers) {
                    if (![observersTheModel containsObject:observer]) {
                        [theModel addObserver:observer];
                    }
                }
                theModel.countUsedModel++;
                if (kTDModelLoaded == theModel.state) {
                    [theModel finishLoading];
                }
                return theModel;
            }
        }
        model.countUsedModel++;
        [self addModel:model];
        [model load];
        return model;
    }
}

@end
