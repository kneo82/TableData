//
//  TDContextLoadifFromFacebook.m
//  TableData
//
//  Created by Vitaliy Voronok on 3/20/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TDFacebookContext.h"
#import "TDUsers.h"
#import "TDUser.h"
#import "TDImageModel.h"

#import "IDPPropertyMacros.h"

static NSString *const kTDStorageFileName   = @"TDStorageFileName1.plist";

static NSString *const kTDDataKey = @"data";

@interface TDFacebookContext ()
@property (nonatomic, readonly) NSString    *path;
@property (nonatomic, retain)	FBRequestConnection	*requestConnection;
@property (nonatomic, assign)   BOOL                canceled;

- (void)requestToFacebook;
- (NSArray *)parseResultRequest:(FBGraphObject *)result;
- (NSArray *)loadFromDisk;

@end

@implementation TDFacebookContext

@dynamic path;

#pragma mark -
#pragma mark Initalizations and Deallocations

- (void)dealloc {
    self.query = nil;
    self.requestConnection = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark Accessors

- (NSString *)path {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = paths[0];
    
    return [path stringByAppendingPathComponent:kTDStorageFileName];
}

- (void)setRequestConnection:(FBRequestConnection *)requestConnection {
    if (requestConnection != _requestConnection) {
        [_requestConnection cancel];
    }
    
    IDPNonatomicRetainPropertySynthesize(_requestConnection, requestConnection);
}

#pragma mark -
#pragma mark Public

- (void)executeOperation {
    [self load];
}

- (TDUser *)parseItemResultRequest:(id)item {
    return nil;
}

- (void)finishExecutingOperation:(NSArray *)array {
    [self finishLoading];
}

- (void)prepareExecutingOperation {
    [self requestToFacebook];
}

- (BOOL)load {
    if (![super load]) {
        return NO;
    }
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [self prepareExecutingOperation];
//    });
    
    return YES;
}

- (void)cancel {
    self.canceled = YES;
    self.requestConnection = nil;
    [super cancel];
}

#pragma mark -
#pragma mark Private

- (NSArray *)parseResultRequest:(FBGraphObject *)result {
    NSMutableArray *array = [NSMutableArray array];
    id data = [result objectForKey:kTDDataKey];
    
    for (id item in data) {
        TDUser *model = [self parseItemResultRequest:item];
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
    FBRequestConnection *requestConnection = [FBRequestConnection object];
    
    __block id weakSelf = self;
    
    FBRequestHandler handler = ^(FBRequestConnection *connection, id result, NSError *error) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NSArray *modelsArray = nil;
            if (!error) {
                modelsArray = [weakSelf parseResultRequest:result];
            } else {
                modelsArray = [weakSelf loadFromDisk];
            }
            
            [weakSelf finishExecutingOperation:modelsArray];
         });
    };
                      
    
    FBRequest *request = [FBRequest requestForGraphPath:@"/fql"];
    NSDictionary *queryParam = @{ @"q": self.query };
    [request.parameters addEntriesFromDictionary:queryParam];
    
    [requestConnection addRequest:request completionHandler:handler];
    
    self.requestConnection = requestConnection;
    [requestConnection start];
}

@end
