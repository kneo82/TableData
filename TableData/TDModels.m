//
//  TDModels.m
//  TableData
//
//  Created by Vitaliy Voronok on 3/7/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TDModels.h"
#import "TDModel.h"

static NSString *const kTDStorageFileName   = @"TDStorageFileName.plist";

static const NSUInteger kTDStringCount  = 10;

@interface TDModels ()
@property (nonatomic, retain, readwrite)    NSMutableArray  *mutableModels;
@property (nonatomic, readonly)             NSString        *path;

@property (nonatomic, assign, getter = isLoaded)    BOOL  loaded;

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
    return [self.mutableModels copy] ;
}

- (NSString *)path {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = paths[0];
    
    return [path stringByAppendingPathComponent:kTDStorageFileName];
}

#pragma mark -
#pragma mark Public

- (void)addModel:(TDModel *)model {
    [self.mutableModels addObject:model];
}

- (void)removeModel:(TDModel *)model {
    [self.mutableModels removeObject:model];
}

- (void)moveModelFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    NSMutableArray *models = self.mutableModels;
    
    TDModel *model = [models objectAtIndex:fromIndex];
    [models removeObjectAtIndex:fromIndex];
    [models insertObject:model atIndex:toIndex];
}

- (void)load {
    NSArray *modelsFromFile = [NSArray arrayWithContentsOfFile:self.path];
	if (modelsFromFile) {
		[self.mutableModels addObjectsFromArray:modelsFromFile];
	} else {
        [self generateModels];
    }
    
    self.loaded = YES;
}

- (void)save {
    [self.mutableModels writeToFile:self.path atomically:YES];
}

- (void)dump {
    [self save];
    
    self.mutableModels = [NSMutableArray array];
}

#pragma mark -
#pragma mark Private

- (void)generateModels {
    for (NSUInteger i = 0; i < kTDStringCount; ++i) {
		[self addModel:[TDModel model]];
	}
}

@end
