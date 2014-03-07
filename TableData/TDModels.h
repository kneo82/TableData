//
//  TDModels.h
//  TableData
//
//  Created by Vitaliy Voronok on 3/7/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TDModel;

@interface TDModels : NSObject
@property (nonatomic, readonly) NSArray *models;

@property (nonatomic, readonly, getter = isLoaded)    BOOL  loaded;

- (void)addModel:(TDModel *)model;
- (void)removeModel:(TDModel *)model;
- (void)moveModelFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

- (void)save;
- (void)load;
- (void)dump;

@end
