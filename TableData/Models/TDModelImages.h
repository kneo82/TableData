//
//  TDModelImages.h
//  TableData
//
//  Created by Vitaliy Voronok on 3/10/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDModelObserver.h"

@class TDImageModel;

@interface TDModelImages : NSObject <TDModelObserver>

+ (TDModelImages *)sharedInstance;

- (void)addModel:(TDImageModel *)model;
- (void)removeModel:(TDImageModel *)model;
- (TDImageModel *)takeModelWithFileName:(NSString *)fileName;

@end
