//
//  TDModelImages.h
//  TableData
//
//  Created by Vitaliy Voronok on 3/10/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPKit.h"

@class TDImageModel;

@interface TDModelImages : IDPSingletonModel

+ (TDModelImages *)sharedObject;

- (void)addModel:(TDImageModel *)model;
- (void)removeModel:(TDImageModel *)model;
- (TDImageModel *)takeModelWithFileName:(NSString *)fileName;

@end
