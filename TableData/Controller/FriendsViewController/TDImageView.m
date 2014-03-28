//
//  TDImageView.m
//  TableData
//
//  Created by Vitaliy Voronok on 3/13/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TDImageView.h"
#import "TDImageModel.h"

@interface TDImageView ()

@end

@implementation TDImageView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.modelImage = nil;
    self.activityIndicator = nil;
    self.imageView = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark Public

- (void)setModelImage:(TDImageModel *)modelImage {
    if (_modelImage != modelImage) {
        [_modelImage removeObserver:self];
        [_modelImage release];
        
        _modelImage = [modelImage retain];
        [_modelImage addObserver:self];
        [self.activityIndicator startAnimating];
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
