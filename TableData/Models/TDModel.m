//
//  TDModel.m
//  TableData
//
//  Created by Vitaliy Voronok on 3/7/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TDModel.h"

#import "TDImageModel.h"

@implementation TDModel

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.modelImage = nil; 
    
    [super dealloc];
}

- (id)init {
    self = [super init];
    if (self) {
        self.modelImage = [TDImageModel object];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setModelImage:(TDImageModel *)modelImage {
    if (modelImage != _modelImage) {
        [_modelImage removeObserver:self];
        [_modelImage release];

        _modelImage = [modelImage retain];
        [_modelImage addObserver:self];
        if (nil != _modelImage) {
            [self finishLoading];
        }
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
