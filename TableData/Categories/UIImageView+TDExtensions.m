//
//  UIImageView+TDExtensions.m
//  TableData
//
//  Created by Vitaliy Voronok on 3/10/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "UIImageView+TDExtensions.h"

@implementation UIImageView (TDExtensions)

- (void)setImageFromModel:(TDModelImage *)modelImage {
    if (kTDModelLoaded == modelImage.state ) {
        self.image = modelImage.image;
    } else {
        [modelImage addObserver:self];
        if (kTDModelLoading != modelImage.state) {
            [modelImage load];
        }
    }
}

- (void)modelDidLoad:(id)object {
    [object removeObserver:self];
    self.image = ((TDModelImage *)object).image;
    
}

@end
