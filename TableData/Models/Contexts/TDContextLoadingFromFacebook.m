//
//  TDContextLoadifFromFacebook.m
//  TableData
//
//  Created by Vitaliy Voronok on 3/20/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TDContextLoadingFromFacebook.h"
#import "TDModels.h"
#import "TDModel.h"
#import "TDImageModel.h"

static NSString *const query =
@"SELECT uid, name, pic_square FROM user WHERE uid IN "
@"(SELECT uid2 FROM friend WHERE uid1 = me())";

static NSString *const kTDStorageFileName   = @"TDStorageFileName.plist";

static NSString *const kTDDataKey = @"data";
static NSString *const kTDNameKey = @"name";
static NSString *const kTDPreviewImageKey = @"pic_square";

@interface TDContextLoadingFromFacebook ()
@property (nonatomic, readonly) NSString    *path;

- (void)requestToFacebook;
- (TDModel *)parseItemResultRequest:(id)item;
- (NSArray *)parseResultRequest:(FBGraphObject *)result;

@end

@implementation TDContextLoadingFromFacebook

@dynamic path;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.models = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark Accessors

- (NSString *)path {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = paths[0];
    
    return [path stringByAppendingPathComponent:kTDStorageFileName];
}

#pragma mark -
#pragma mark Public

- (void)executeOperation {
    [self load];
}

#pragma mark -
#pragma mark Private

- (NSArray *)parseResultRequest:(FBGraphObject *)result {
    NSMutableArray *array = [NSMutableArray array];
    id data = [result objectForKey:kTDDataKey];
    
    for (id item in data) {
        TDModel *model = [self parseItemResultRequest:item];
        if (model) {
            [array addObject:model];
        }
    }
    
    return array;
}

- (TDModel *)parseItemResultRequest:(id)item {
    NSString *name =[item objectForKey:kTDNameKey];
    NSString *imageFilePath = [item objectForKey:kTDPreviewImageKey];

    TDImageModel *imageModel = [[[TDImageModel alloc] initWithFilePath:imageFilePath] autorelease];
    TDModel *model = [TDModel object];
    model.string = name;
    model.modelImage = imageModel;
    
    return model;
}

- (void)requestToFacebook {
    NSDictionary *queryParam = @{ @"q": query };
    dispatch_async(dispatch_get_main_queue(), ^{
        void (^block) (FBRequestConnection *, id, NSError *);
        block = ^(FBRequestConnection *connection, id result, NSError *error) {
            NSArray *modelsArray = nil;
            if (!error) {
                modelsArray = [self parseResultRequest:result];
            } else {
                modelsArray = [NSKeyedUnarchiver unarchiveObjectWithFile:self.path];
            }
            [self.models addModelsFromArray:modelsArray];
            [self finishLoading];
            [self removeObserver:self.models];
        };
        
        [FBRequestConnection startWithGraphPath:@"/fql"
                                     parameters:queryParam
                                     HTTPMethod:@"GET"
                              completionHandler:block];
    });
}

- (BOOL)load {
    if (![super load]) {
        return NO;
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
       [self requestToFacebook];
    });
    return YES;
    
}

@end
