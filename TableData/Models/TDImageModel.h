//
//  TDModelImage.h
//  TableData
//
//  Created by Vitaliy Voronok on 3/10/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TDObervableModel.h"

@interface TDImageModel : TDObervableModel <NSCoding>
@property (nonatomic, readonly) UIImage     *image;
@property (nonatomic, readonly) NSString    *imageFilePath;

- (id)initWithFileName:(NSString *)fileName;

@end
