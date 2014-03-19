//
//  TDImageView.m
//  TableData
//
//  Created by Vitaliy Voronok on 3/13/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TDImageView.h"
#import "TDImageModel.h"
#import "NSBundle+TDExtensions.h"

@interface TDImageView ()
@property (nonatomic, retain)   TDImageModel *modelImage;

@end

@implementation TDImageView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.activityIndicator = nil;
    self.imageView = nil;
    self.modelImage = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark Accessors

- (NSString *)restorationIdentifier {
    return NSStringFromClass([self class]);
}

#pragma mark -
#pragma mark Public

- (void)setImageFromModel:(TDImageModel *)modelImage {
    if (_modelImage != modelImage) {
        [_modelImage removeObserver:self];
        [_modelImage release];
        
        _modelImage = [modelImage retain];
        [_modelImage addObserver:self];
        
        [_modelImage load];
    }
}

#pragma mark -
#pragma mark TDTaskCompletion.h

- (void)modelDidLoad:(id)object {
    [self.activityIndicator stopAnimating];
    self.imageView.image = self.modelImage.image;
}

@end
