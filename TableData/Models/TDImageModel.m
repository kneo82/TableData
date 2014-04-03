//
//  TDModelImage.m
//  TableData
//
//  Created by Vitaliy Voronok on 3/10/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TDImageModel.h"
#import "TDModelImages.h"

static NSString *const defaultImage = @"smile.png";
static NSString *const kTDImageFileNameKey = @"imageFileName";

@interface TDImageModel ()
@property (nonatomic, retain)   UIImage             *image;
@property (nonatomic, readonly) NSString            *path;
@property (nonatomic, copy)     NSString            *imageFilePath;
@property (nonatomic, retain)   IDPURLConnection    *urlConnection;

- (NSString *)pathForFileName:(NSString *)fileName;

@end

@implementation TDImageModel

@dynamic path;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.image = nil;
    self.urlConnection = nil;
    
    [super dealloc];
}

- (id)initWithFilePath:(NSString *)filePath {
    self.cache = [TDModelImages sharedObject];
    TDModelImages *cache = self.cache;
    
    TDImageModel *model = [cache modelWithFilePath:filePath];
    if (model) {
        [self autorelease];
        
        return [model retain];
    }

    self = [super init];
    if (self) {
        self.imageFilePath = filePath;
        [cache addModel:self];
    }
    
    return self;
}

- (id)init {
    return [self initWithFilePath:defaultImage];
}

#pragma mark -
#pragma mark Accessors

- (NSString *)path {
    return [self pathForFileName:self.imageFilePath];
}

- (NSString *)pathForFileName:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = paths[0];
    
    return [path stringByAppendingPathComponent:fileName];
}

- (void)setUrlConnection:(IDPURLConnection *)urlConnection {
    IDPNonatomicRetainPropertySynthesizeWithObserver(_urlConnection, urlConnection);
}

#pragma mark -
#pragma mark Public

- (void)cancel {
    [super cancel];
    self.urlConnection = nil;
}

- (void)loadImage {
    NSURL *url = [NSURL URLWithString:self.imageFilePath];
    NSString *path = [self pathForFileName:[url lastPathComponent]];
    
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath: path];
    if (fileExists) {
        [self loadFromDisk:path];
    } else {
        [self loadFromInternet:url];
    }
}

- (void)loadFromDisk:(NSString *)path {
    UIImage *image = nil;
    image = [UIImage imageWithContentsOfFile:path];
    self.image = image;
    [self finishLoading];
}

- (void)loadFromInternet:(NSURL *)url {
    self.urlConnection = [IDPURLConnection connectionToURL:url];
    IDPURLConnection *urlConnection = self.urlConnection;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [urlConnection load];
    });
}

- (void)modelDidLoad:(id)theModel {
    UIImage *image = nil;
    NSURL *url = [NSURL URLWithString:self.imageFilePath];
    NSString *path = [self pathForFileName:[url lastPathComponent]];
    
    NSData *dataImage = self.urlConnection.data;
    
    if (dataImage) {
        image = [UIImage imageWithData:dataImage];
        [dataImage writeToFile:path atomically:YES];
    }
    
    self.urlConnection = nil;
    self.image = image;
    [self finishLoading];
}

- (BOOL)load {
    if(![super load]) {
        return NO;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [self loadImage];
    });
    
    return YES;
}

- (oneway void)release {
    @synchronized (self) {
        [super release];
        if (1 == [self retainCount]) {
            [self.cache removeModel:self];
        }
    }
}

- (void)dump {
    self.image = nil;
    
    [super dump];
}

#pragma mark -
#pragma mark NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
    NSString *fileName = [aDecoder decodeObjectForKey:kTDImageFileNameKey];

    return [self initWithFilePath:fileName];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.imageFilePath forKey:kTDImageFileNameKey];
}

@end
