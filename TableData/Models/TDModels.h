//
//  TDModels.h
//  TableData
//
//  Created by Vitaliy Voronok on 3/7/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>
#import "IDPKit.h"

@class TDModel;

@interface TDModels : IDPModel
@property (nonatomic, readonly) NSArray     *models;

- (void)addModel:(TDModel *)model;
- (void)addModelsFromArray:(NSArray *)array;
- (void)removeModel:(TDModel *)model;
- (void)moveModelFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

- (void)save;

@end
