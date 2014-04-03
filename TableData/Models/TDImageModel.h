//
//  TDModelImage.h
//  TableData
//
//  Created by Vitaliy Voronok on 3/10/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDPKit.h"

@class TDModelImages;

@interface TDImageModel : IDPModel <NSCoding, IDPModelObserver>
@property (nonatomic, readonly) UIImage         *image;
@property (nonatomic, readonly) NSString        *imageFilePath;
@property (nonatomic, assign)   TDModelImages   *cache;

- (id)initWithFilePath:(NSString *)filePath;
- (void)cancel;

@end
