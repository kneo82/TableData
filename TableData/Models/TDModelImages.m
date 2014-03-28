//
//  TDModelImages.m
//  TableData
//
//  Created by Vitaliy Voronok on 3/10/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TDModelImages.h"

#import "TDImageModel.h"

static TDModelImages *TDSingletoneObject = nil;

@interface TDModelImages ()
@property (nonatomic, retain) NSMutableDictionary *mutableDictionaryImages;

@end

@implementation TDModelImages

#pragma mark -
#pragma mark Class Methods

+ (TDModelImages *)sharedObject {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        TDSingletoneObject = [[self alloc] init];
    });

    return  TDSingletoneObject;
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
#pragma mark Public

- (void)addModel:(TDImageModel *)model {
    @synchronized(self.mutableDictionaryImages) {
        NSMutableDictionary *mutableDictionaryImages = self.mutableDictionaryImages;
        NSString *fileName = model.imageFilePath;
        if (![mutableDictionaryImages objectForKey:fileName]) {
            [mutableDictionaryImages setObject:model forKey:fileName];
        }
    }
}

- (void)removeModel:(TDImageModel *)model {
    @synchronized(self.mutableDictionaryImages) {
        if (model.imageFilePath) {
            [self.mutableDictionaryImages removeObjectForKey:model.imageFilePath];
        }
    }
}

- (TDImageModel *)takeModelWithFileName:(NSString *)fileName {
    @synchronized(self) {
        return [self.mutableDictionaryImages objectForKey:fileName];
    }
}

#pragma mark -
#pragma mark Private

+ (id)__sharedObject {
	return TDSingletoneObject;
}

@end
