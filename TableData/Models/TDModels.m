//
//  TDModels.m
//  TableData
//
//  Created by Vitaliy Voronok on 3/7/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TDModels.h"
#import "TDModel.h"

#import "TDObservableObject.h"

#import "NSObject+TDExtensions.h"

static NSString *const kTDStorageFileName   = @"TDStorageFileName.plist";

static const NSUInteger kTDStringCount  = 10;

@interface TDModels ()
@property (nonatomic, retain, readwrite)    NSMutableArray    *mutableModels;
@property (nonatomic, readonly)             NSString          *path;

- (void)generateModels;

@end

@implementation TDModels

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

- (void)addModel:(TDModel *)model {
    @synchronized(self.mutableModels) {
        [self.mutableModels addObject:model];
    }
}

- (void)removeModel:(TDModel *)model {
    @synchronized(self.mutableModels) {
        [self.mutableModels removeObject:model];
        [model release];
    }
}

- (void)moveModelFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    @synchronized(self.mutableModels) {
        NSMutableArray *models = self.mutableModels;
        
        TDModel *model = [models objectAtIndex:fromIndex];
        [models removeObjectAtIndex:fromIndex];
        [models insertObject:model atIndex:toIndex];
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

#pragma mark -
#pragma mark Private

- (void)performLoading {
    [super performLoading];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        sleep(2);
        NSArray *modelsFromFile = [NSKeyedUnarchiver unarchiveObjectWithFile:self.path];
        if (modelsFromFile) {
            [self.mutableModels addObjectsFromArray:modelsFromFile];
        } else {
            [self generateModels];
        }
        
        [self finishLoading];
    });
}

- (void)generateModels {
    for (NSUInteger i = 0; i < kTDStringCount; ++i) {
		[self addModel:[TDModel object]];
	}
}

@end
