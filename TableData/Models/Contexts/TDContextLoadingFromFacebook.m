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

static NSString *const kTDStorageFileName   = @"TDStorageFileName.plist";

static NSString *const kTDDataKey = @"data";

@interface TDContextLoadingFromFacebook ()
@property (nonatomic, readonly) NSString    *path;
@property (nonatomic, retain)	FBRequestConnection	*requestConnection;

- (void)requestToFacebook;
- (TDModel *)parseItemResultRequest:(id)item;
- (NSArray *)parseResultRequest:(FBGraphObject *)result;
- (NSArray *)loadFromDisk;

@end

@implementation TDContextLoadingFromFacebook

@dynamic path;

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

- (TDModel *)parseItemResultRequest:(id)item {
    return nil;
}

- (void)finishExecutingOperation:(NSArray *)array {
    [self finishLoading];
}

- (void)prepareExecutingOperation {
    [self requestToFacebook];
}

- (void)cancel {
    [self.requestConnection cancel];
    [self finishLoading];
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

- (NSArray *)loadFromDisk {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:self.path];
}

- (void)requestToFacebook {
    self.requestConnection = [FBRequestConnection object];
    __block id weakSelf = self;
    FBRequestHandler handler = ^(FBRequestConnection *connection, id result, NSError *error) {
        NSArray *modelsArray = nil;
        if (!error) {
            modelsArray = [weakSelf parseResultRequest:result];
        } else {
            modelsArray = [weakSelf loadFromDisk];
        }
        [weakSelf finishExecutingOperation:modelsArray];
    };
    
    FBRequestConnection *requestConnection = self.requestConnection;
    FBRequest *request = [FBRequest requestForGraphPath:@"/fql"];
    NSDictionary *queryParam = @{ @"q": self.query };
    [request.parameters addEntriesFromDictionary:queryParam];
    [requestConnection addRequest:request completionHandler:handler];
    dispatch_async(dispatch_get_main_queue(), ^{
         [requestConnection start];
    });
}

- (BOOL)load {
    if (![super load]) {
        return NO;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            sleep(2);
       [self prepareExecutingOperation];
    });
    
    return YES;
}

@end
