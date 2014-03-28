//
//  TDModelImage.m
//  TableData
//
//  Created by Vitaliy Voronok on 3/10/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TDImageModel.h"
#import "TDModelImages.h"

static NSString *const defaultFileName = @"smile.png";

@interface TDImageModel ()
@property (nonatomic, retain)   UIImage         *image;
@property (nonatomic, readonly) NSString        *path;
@property (nonatomic, copy)     NSString        *imageFilePath;

- (NSString *)pathForFileName:(NSString *)fileName;

@end

@implementation TDImageModel

@dynamic path;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.image = nil;

    [super dealloc];
}

- (id)initWithFilePath:(NSString *)filePath {
    TDModelImages *cache = [TDModelImages sharedObject];
    TDImageModel *model = [cache takeModelWithFileName:filePath];
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
    return [self initWithFilePath:defaultFileName];
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

#pragma mark -
#pragma mark Public

- (BOOL)load {
    if(![super load]) {
        return NO;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        sleep(arc4random_uniform(3));
        
        UIImage *image = nil;
        NSString *imageFilePath = self.imageFilePath;
        
        if (imageFilePath == nil || 0 == [imageFilePath compare:@"smile.png"]) {
            image = [UIImage imageNamed:imageFilePath];
        } else {
            NSURL *url = [NSURL URLWithString:self.imageFilePath];
            NSData *dataImage = [NSData dataWithContentsOfURL:url];
            NSString *path = [self pathForFileName:[url lastPathComponent]];
            if (dataImage) {
                image = [UIImage imageWithData:dataImage];
                [dataImage writeToFile:path atomically:YES];
            } else {
                image = [UIImage imageWithContentsOfFile:path];
            }
        }
        
        self.image = image;
        
        [self finishLoading];
    });
    return YES;
}

- (oneway void)release {
    @synchronized (self) {
        [super release];
        if (1 == [self retainCount]) {
            TDModelImages *cache = [TDModelImages sharedObject];
            [cache removeModel:self];
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
    NSString *fileName = [aDecoder decodeObjectForKey:@"imageFileName"];
    TDImageModel *model = [[self initWithFilePath:fileName] autorelease];
    return [model retain];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.imageFilePath forKey:@"imageFileName"];
}

@end
