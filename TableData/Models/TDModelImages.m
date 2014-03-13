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
@property (nonatomic, retain) NSMutableDictionary *mutableDictionaryImages;

@end

@implementation TDModelImages

@dynamic dictionaryImages;

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
    self.mutableDictionaryImages = nil;
    
    [super dealloc];
}

- (id)init {
    self = [super init];
    if (self) {
        self.mutableDictionaryImages = [NSMutableDictionary dictionary];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSDictionary *)dictionaryImages {
    @synchronized (self.mutableDictionaryImages) {
        return [[self.mutableDictionaryImages copy] autorelease];
    }
}

#pragma mark -
#pragma mark Public

- (void)addModel:(TDModelImage *)model {
    @synchronized(self.mutableDictionaryImages) {
        NSMutableDictionary *mutableDictionaryImages = self.mutableDictionaryImages;
        NSString *fileName = model.imageFileName;
        if (![mutableDictionaryImages objectForKey:fileName]) {
            [mutableDictionaryImages setObject:model forKey:fileName];
        }
    }
}

- (void)removeModel:(TDModelImage *)model {
    model.countUsedModel--;
    if (0 == model.countUsedModel) {
        @synchronized(self.mutableDictionaryImages) {
            [self.mutableDictionaryImages removeObjectForKey:model.imageFileName];
        }
    }
}

- (TDModelImage *)takeModelWithFileName:(NSString *)fileName {
    NSDictionary *dictionaryImages = self.dictionaryImages;

    if (!fileName) {
        fileName = @"smile.png";
    }
    
    TDModelImage *model = nil;
    model = [dictionaryImages objectForKey:fileName];
    if (!model) {
        model = [TDModelImage object];
        model.imageFileName = fileName;
        [self addModel:model];
    }
    model.countUsedModel++;
    return model;
}

@end
