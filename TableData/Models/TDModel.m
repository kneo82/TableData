//
//  TDModel.m
//  TableData
//
//  Created by Vitaliy Voronok on 3/7/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TDModel.h"

#import "TDModelImage.h"
#import "TDModelImages.h"

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
        self.modelImages = [TDModelImages sharedInstance];
        self.modelImage = [TDModelImage object];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setModelImage:(TDModelImage *)modelImage {
    if (modelImage != _modelImage) {
        if (!self.modelImages) {
            self.modelImages = [TDModelImages sharedInstance];
        }
        [_modelImage removeObserver:self];
        _modelImage = nil;
        
//        _modelImage = [modelImage retain];
//        [_modelImage addObserver:self];
        if (nil != modelImage) {
            NSString *fileName =modelImage.imageFileName;
            _modelImage = [[self.modelImages takeModelWhisFileName:fileName] retain];
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

- (void)clearingModel {
    [self.modelImages removeModel:self.modelImage];
}

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

#pragma mark -
#pragma mark TDTaskCompletion.h

- (void)modelDidLoad:(id)object {
    [object removeObserver:self];
    [self finishLoading];
}

@end
