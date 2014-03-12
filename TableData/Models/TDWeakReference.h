//
//  TDWeakReference.h
//  TableData
//
//  Created by Oleksa Korin on 10/3/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDWeakReference : NSObject
@property (nonatomic, readonly)     id<NSObject>    object;

+ (id)referenceWithObject:(id<NSObject>)object;

@end
