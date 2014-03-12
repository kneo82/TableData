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
    self.image = modelImage.image;
}

@end
