//
//  TDImageView.m
//  TableData
//
//  Created by Vitaliy Voronok on 3/13/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TDImageView.h"
#import "TDModelImage.h"
#import "NSBundle+TDExtensions.h"

@implementation TDImageView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.activityIndicator = nil;
    self.imageView = nil;
    
    [super dealloc];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIActivityIndicatorView *spinner = self.activityIndicator;
    spinner.center = self.center;
    [spinner stopAnimating];
}

#pragma mark -
#pragma mark Accessors

- (NSString *)restorationIdentifier {
    return NSStringFromClass([self class]);
}

#pragma mark -
#pragma mark Public

- (void)setImageFromModel:(TDModelImage *)modelImage {
    self.imageView.image = [UIImage imageNamed:@"blank.png"];
    if (kTDModelLoaded == modelImage.state ) {
        self.imageView.image = modelImage.image;
    } else {
        [self.activityIndicator startAnimating];
        [modelImage addObserver:self];
        if (kTDModelLoading != modelImage.state) {
            [modelImage load];
        }
    }
}

#pragma mark -
#pragma mark TDTaskCompletion.h

- (void)modelDidLoad:(id)object {
    [object removeObserver:self];
    [self.activityIndicator stopAnimating];
    self.imageView.image = ((TDModelImage *)object).image;
}

@end
