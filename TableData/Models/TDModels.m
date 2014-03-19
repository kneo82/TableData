//
//  TDModels.m
//  TableData
//
//  Created by Vitaliy Voronok on 3/7/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TDModels.h"
#import "TDModel.h"
#import "TDImageModel.h"

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
    }
}

- (void)moveModelFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    @synchronized(self.mutableModels) {
        NSMutableArray *models = self.mutableModels;
        
        TDModel *model = [[models objectAtIndex:fromIndex] retain];
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

#pragma mark -
#pragma mark Private

- (void)performLoading {
    [super performLoading];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        sleep(2);
        
        NSString *query =
        @"SELECT uid, name, pic_square FROM user WHERE uid IN "
        @"(SELECT uid2 FROM friend WHERE uid1 = me() LIMIT 10)";
        
        NSDictionary *queryParam = @{ @"q": query };
        dispatch_async(dispatch_get_main_queue(), ^{
        [FBRequestConnection startWithGraphPath:@"/fql"
                                     parameters:queryParam
                                     HTTPMethod:@"GET"
                              completionHandler:^(FBRequestConnection *connection, id result, NSError *error)
            {
                  if (!error) {
                      NSMutableArray *array = [NSMutableArray array];
                      id data = [result objectForKey:@"data"];
                      
                      for (id item in data) {
                          NSString *name =[item objectForKey:@"name"];
                          NSString *imageFilePath = [item objectForKey:@"pic_square"];
                          
                          TDImageModel *imageModel = [[[TDImageModel alloc] initWithFileName:imageFilePath] autorelease];
                          TDModel *model = [TDModel object];
                          model.string = name;
                          model.modelImage = imageModel;
                          [array addObject: model];
                      }
                      @synchronized (self.mutableModels) {
                          [self.mutableModels addObjectsFromArray:array];
                      }
                      } else {
                      NSLog(@"%@", error);
                  }
                  [self finishLoading];
              }];
        });
        
    });
}

- (void)generateModels {
    for (NSUInteger i = 0; i < kTDStringCount; ++i) {
		[self addModel:[TDModel object]];
	}
}

@end
