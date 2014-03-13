//
//  TDModelImages.h
//  TableData
//
//  Created by Vitaliy Voronok on 3/10/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDModelObserver.h"

@class TDModelImage;

@interface TDModelImages : NSObject <TDModelObserver>
@property (nonatomic, readonly) NSDictionary *dictionaryImages;

+ (TDModelImages *)sharedInstance;

- (void)addModel:(TDModelImage *)model;
- (void)removeModel:(TDModelImage *)model;
- (TDModelImage *)takeModelWithFileName:(NSString *)fileName;

@end
