//
//  UIImageView+TDExtensions.h
//  TableData
//
//  Created by Vitaliy Voronok on 3/10/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TDModelImage.h"
#import "TDModelObserver.h"

@interface UIImageView (TDExtensions) <TDModelObserver>

- (void)setImageFromModel:(TDModelImage *)modelImage;

@end
