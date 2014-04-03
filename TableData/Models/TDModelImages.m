//
//  TDModelImages.m
//  TableData
//
//  Created by Vitaliy Voronok on 3/10/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TDModelImages.h"

#import "TDImageModel.h"

static TDModelImages *__sharedModelImages = nil;

@interface TDModelImages ()
@property (nonatomic, retain) NSMutableDictionary *mutableDictionaryImages;

@end

@implementation TDModelImages

#pragma mark -
#pragma mark Class Methods

+ (TDModelImages *)sharedObject {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedModelImages = [[self alloc] init];
    });

    return  __sharedModelImages;
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    for (TDImageModel *model in self.mutableDictionaryImages) {
        model.cache = nil;
    }
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
#pragma mark Public

- (void)addModel:(TDImageModel *)model {
    @synchronized(self.mutableDictionaryImages) {
        NSMutableDictionary *mutableDictionaryImages = self.mutableDictionaryImages;
        NSString *filePath = model.imageFilePath;
        if (![mutableDictionaryImages objectForKey:filePath]) {
            [mutableDictionaryImages setObject:model forKey:filePath];
        }
    }
}

- (void)removeModel:(TDImageModel *)model {
    @synchronized(self.mutableDictionaryImages) {
        if (model.imageFilePath) {
            model.cache = nil;
            [self.mutableDictionaryImages removeObjectForKey:model.imageFilePath];
        }
    }
}

- (TDImageModel *)modelWithFilePath:(NSString *)filePath {
    @synchronized(self) {
        return [self.mutableDictionaryImages objectForKey:filePath];
    }
}

#pragma mark -
#pragma mark Private

+ (id)__sharedObject {
	return __sharedModelImages;
}

@end
