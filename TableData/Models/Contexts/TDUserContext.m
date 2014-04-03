//
//  TDTDContextLoadingFullInfo.m
//  TableData
//
//  Created by Vitaliy Voronok on 3/29/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TDUserContext.h"
#import "TDUser.h"
#import "TDImageModel.h"

static NSString *const kTDBirthdayKey = @"birthday";
static NSString *const kTDLocationKey = @"hometown_location";
static NSString *const kTDCityKey = @"city";
static NSString *const kTDCountryKey = @"country";
static NSString *const kTDGenderKey = @"sex";
static NSString *const kTDFullImageKey = @"pic_big";

static NSString *const query =
@"SELECT birthday, hometown_location.city,"
@"hometown_location.country, friend_count, pic_big, sex FROM user WHERE uid = ";

@implementation TDUserContext

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.model = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark Public

- (TDUser *)parseItemResultRequest:(id)item {
    TDUser *model = self.model;
    
    id data = [item objectForKey:kTDBirthdayKey];
    model.birthday = data == [NSNull null] ? nil : [NSString stringWithFormat:@"%@", data];
    
    id location = [item objectForKey:kTDLocationKey];
    if (location != [NSNull null]) {
        model.city = [location objectForKey:kTDCityKey];
        model.country = [location objectForKey:kTDCountryKey];
    }
    
    model.gender = [item objectForKey:kTDGenderKey];
    
    NSString *fullImage = [item objectForKey:kTDFullImageKey];
    TDImageModel *imageModel = [[[TDImageModel alloc] initWithFilePath:fullImage] autorelease];
    model.modelFullImage = imageModel;
    
    model.fullDataModelLoaded = YES;
    
    return model;
}

- (void)prepareExecutingOperation {
    if (self.model.fullDataModelLoaded) {
        [self finishLoading];
        return;
    }
    self.query = [query stringByAppendingString:self.model.facebookUserID];
    [super prepareExecutingOperation];
}

@end
