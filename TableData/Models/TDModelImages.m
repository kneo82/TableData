//
//  TDModelImages.m
//  TableData
//
//  Created by Vitaliy Voronok on 3/10/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TDModelImages.h"

#import "TDImageModel.h"

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

- (void)addModel:(TDImageModel *)model {
    @synchronized(self.mutableDictionaryImages) {
        NSMutableDictionary *mutableDictionaryImages = self.mutableDictionaryImages;
        NSString *fileName = model.imageFileName;
        if (![mutableDictionaryImages objectForKey:fileName]) {
            [mutableDictionaryImages setObject:model forKey:fileName];
        }
    }
}

- (void)removeModel:(TDImageModel *)model {
    @synchronized(self.mutableDictionaryImages) {
        if (model.imageFileName) {
            [self.mutableDictionaryImages removeObjectForKey:model.imageFileName];
        }
    }
}

- (TDImageModel *)takeModelWithFileName:(NSString *)fileName {
    @synchronized(self) {
        return [self.mutableDictionaryImages objectForKey:fileName];
    }
}

@end
