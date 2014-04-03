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

@class TDUser;

@interface TDUsers : IDPModel
@property (nonatomic, readonly) NSArray     *models;

- (void)addModel:(TDUser *)model;
- (void)addModelsFromArray:(NSArray *)array;
- (void)removeModel:(TDUser *)model;
- (void)moveModelFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

- (void)save;

@end
