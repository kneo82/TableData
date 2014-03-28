//
//  TDModel.h
//  TableData
//
//  Created by Vitaliy Voronok on 3/7/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDPKit.h"

@class TDImageModel;
@class TDModelImages;

@interface TDModel : IDPModel <NSCoding>
@property (nonatomic, copy)     NSString        *string;
@property (nonatomic, retain)   TDImageModel    *modelImage;


@end
