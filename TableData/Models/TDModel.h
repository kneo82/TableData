//
//  TDModel.h
//  TableData
//
//  Created by Vitaliy Voronok on 3/7/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TDObervableModel.h"

@class TDModelImage;
@class TDModelImages;

// TODO: Create separate TDImageModel, create TDImageView for handling image model lazy loading

@interface TDModel : TDObervableModel <NSCoding>
@property (nonatomic, copy)     NSString        *string;
@property (nonatomic, retain)   TDModelImage    *modelImage;
@property (nonatomic, readonly) UIImage         *image;

- (void)clearingModel;

@end
