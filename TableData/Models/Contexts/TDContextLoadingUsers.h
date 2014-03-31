//
//  TDContextLoadingUsers.h
//  TableData
//
//  Created by Vitaliy Voronok on 3/29/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDContextLoadingFromFacebook.h"

@interface TDContextLoadingUsers : TDContextLoadingFromFacebook
@property (nonatomic, retain)   TDModels *models;

@end
