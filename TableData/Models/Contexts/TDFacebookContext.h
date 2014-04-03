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

@class TDUsers;
@class TDUser;

@interface TDFacebookContext : IDPModel
@property (nonatomic, copy) NSString    *query;

- (void)executeOperation;
- (void)cancel;

- (TDUser *)parseItemResultRequest:(id)item;
- (void)finishExecutingOperation:(NSArray *)array;
- (void)prepareExecutingOperation;

@end
