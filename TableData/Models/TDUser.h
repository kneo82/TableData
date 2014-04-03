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

@interface TDUser : IDPModel <NSCoding>
@property (nonatomic, copy)     NSString        *fullName;
@property (nonatomic, copy)     NSString        *facebookUserID;
@property (nonatomic, retain)   TDImageModel    *modelPreviewImage;

@property (nonatomic, retain)   TDImageModel    *modelFullImage;
@property (nonatomic, copy)     NSString        *city;
@property (nonatomic, copy)     NSString        *country;
@property (nonatomic, copy)     NSString        *birthday;
@property (nonatomic, copy)     NSString        *gender;

@property (nonatomic, assign)   BOOL            fullDataModelLoaded;

@end