//
//  TDContextLoadifFromFacebook.h
//  TableData
//
//  Created by Vitaliy Voronok on 3/20/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>

#import "IDPKit.h"

@class TDModels;

@interface TDContextLoadingFromFacebook : IDPModel
@property (nonatomic, retain)   TDModels *models;

- (void)executeOperation;

@end
