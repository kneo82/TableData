//
//  TDModelImage.m
//  TableData
//
//  Created by Vitaliy Voronok on 3/10/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TDImageModel.h"
#import "TDModelImages.h"

#import "NSObject+TDExtensions.h"
static NSString *const defaultFileName = @"smile.png";

@interface TDImageModel ()
@property (nonatomic, retain)   UIImage         *image;
@property (nonatomic, readonly) NSString        *path;
@property (nonatomic, copy)     NSString        *imageFileName;

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

- (id)initWithFileName:(NSString *)fileName {
    TDModelImages *cache = [TDModelImages sharedInstance];
    TDImageModel *model = [cache takeModelWithFileName:fileName];
    if (model) {
        [self autorelease];
        return [model retain];
    }

    self = [super init];
    if (self) {
        self.imageFileName = fileName;
        [cache addModel:self];
    }
    
    return self;
}

- (id)init {
    return [self initWithFileName:defaultFileName];
}

#pragma mark -
#pragma mark Accessors

- (NSString *)path {
    return [self pathForFileName:self.imageFileName];
}

- (NSString *)pathForFileName:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = paths[0];
    
    return [path stringByAppendingPathComponent:fileName];
}

#pragma mark -
#pragma mark Public

- (void)performLoading {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        sleep(arc4random_uniform(5));
        UIImage *image = nil;
        NSString *imageFileName = self.imageFileName;
        if (imageFileName == nil || 0 == [imageFileName compare:@"smile.png"]) {
            imageFileName = @"smile.png";
            image = [UIImage imageNamed:imageFileName];
        } else {
            image = [UIImage imageWithContentsOfFile:self.path];
        }
        
        self.image = image;
        self.imageFileName = imageFileName;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self finishLoading];
        });
    });
}

- (void)dump {
    self.image = nil;
    
    [super dump];
}

#pragma mark -
#pragma mark NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.imageFileName = [aDecoder decodeObjectForKey:@"imageFileName"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.imageFileName forKey:@"imageFileName"];
}

@end
