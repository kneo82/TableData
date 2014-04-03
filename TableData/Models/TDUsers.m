//
//  TDModels.m
//  TableData
//
//  Created by Vitaliy Voronok on 3/7/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TDUsers.h"
#import "TDUser.h"
#import "TDImageModel.h"
#include "TDFacebookContext.h"

static NSString *const kTDStorageFileName   = @"TDStorageFileName.plist";

@interface TDUsers ()
@property (nonatomic, retain, readwrite)    NSMutableArray    *mutableModels;
@property (nonatomic, readonly)             NSString          *path;

@end

@implementation TDUsers

@dynamic path;
@dynamic models;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.mutableModels = nil;
    
    [super dealloc];
}

- (id)init {
    self = [super init];
    if (self) {
        self.mutableModels = [NSMutableArray array];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)models {
    @synchronized(self.mutableModels) {
        return [[self.mutableModels copy] autorelease];
    }
}

- (NSString *)path {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = paths[0];
    
    return [path stringByAppendingPathComponent:kTDStorageFileName];
}

#pragma mark -
#pragma mark Public

- (void)addModel:(TDUser *)model {
    @synchronized(self.mutableModels) {
        [self.mutableModels addObject:model];
    }
}

- (void)addModelsFromArray:(NSArray *)array {
    @synchronized(self.mutableModels) {
        [self.mutableModels addObjectsFromArray:array];
    }
}

- (void)removeModel:(TDUser *)model {
    @synchronized(self.mutableModels) {
        [self.mutableModels removeObject:model];
    }
}

- (void)moveModelFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    @synchronized(self.mutableModels) {
        NSMutableArray *models = self.mutableModels;
        
        TDUser *model = [[models objectAtIndex:fromIndex] retain];
        [models removeObjectAtIndex:fromIndex];
        [models insertObject:model atIndex:toIndex];
        [model release];
    }
}

- (void)save {
    [NSKeyedArchiver archiveRootObject:self.mutableModels toFile:self.path];
}

- (void)dump {
    [self save];
    self.mutableModels = [NSMutableArray array];
    
    [super dump];
}

@end
