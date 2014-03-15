//
//  TDModel.m
//  TableData
//
//  Created by Vitaliy Voronok on 3/7/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TDModel.h"

#import "TDImageModel.h"
//#import "TDModelImages.h"

#import "NSObject+TDExtensions.h"
#import "NSString+TDExtensions.h"

static const NSUInteger kTDLengthString = 20;

@interface TDModel ()
@property (nonatomic, retain)   TDModelImages   *modelImages;

@end

@implementation TDModel

@dynamic image;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.modelImage = nil;
    self.modelImages = nil;
    
    [super dealloc];
}

- (id)init {
    self = [super init];
    if (self) {
        self.string = [NSString randomStringOfLength:kTDLengthString];
        self.modelImage = [TDImageModel object];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setModelImage:(TDImageModel *)modelImage {
    if (modelImage != _modelImage) {
        [_modelImage release];

        if (nil != modelImage) {
            NSString *fileName =modelImage.imageFileName;
            _modelImage = [[[TDImageModel alloc] initWithFileName:fileName] retain];
            [self finishLoading];
        }
    }
}

- (UIImage *)image {
    if (kTDModelLoaded == self.modelImage.state) {
        return self.modelImage.image;
    } else {
        return [UIImage imageNamed:@"blank.png"];
    }
}

#pragma mark -
#pragma mark Public

- (void)dump {
    self.modelImage = nil;
    
    [super dump];
}

#pragma mark -
#pragma mark NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.string = [aDecoder decodeObjectForKey:@"string"];
        self.modelImage = [aDecoder decodeObjectForKey:@"modelImage"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.string forKey:@"string"];
    [aCoder encodeObject:self.modelImage forKey:@"modelImage"];
}

@end
