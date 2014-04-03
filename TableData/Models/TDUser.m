//
//  TDModel.m
//  TableData
//
//  Created by Vitaliy Voronok on 3/7/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TDUser.h"

#import "TDImageModel.h"

static NSString *const kTDFullNameKey = @"fullName";
static NSString *const kTDFacebookUserIDKey = @"facebookUserID";
static NSString *const kTDCityKey = @"city";
static NSString *const kTDCountryKey = @"country";
static NSString *const kTDBirthdayKey = @"birthday";
static NSString *const kTDGenderKey = @"gender";
static NSString *const kTDModelPreviewImageKey = @"modelPreviewImage";
static NSString *const kTDModelFullImageKey = @"modelFullImage";
static NSString *const kTDFullDataModelLoadedKey = @"fullDataModelLoaded";
static NSString *const kTDDefaultIDKey = @"me()";

@implementation TDUser

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.modelPreviewImage = nil;
    self.modelFullImage = nil;
    
    [super dealloc];
}

- (id)init {
    self = [super init];
    if (self) {
        self.facebookUserID = kTDDefaultIDKey;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setModelPreviewImage:(TDImageModel *)modelImage {
    
    IDPNonatomicRetainPropertySynthesizeWithObserver(_modelPreviewImage, modelImage);
    
    if (_modelPreviewImage) {
        [self finishLoading];
    }

}

- (void)setmodelFullImage:(TDImageModel *)modelImage {

    IDPNonatomicRetainPropertySynthesizeWithObserver(_modelFullImage, modelImage);
    
    if (_modelFullImage) {
        [self finishLoading];
    }
}


#pragma mark -
#pragma mark Public

- (void)dump {
    self.modelPreviewImage = nil;
    self.modelFullImage = nil;
    
    [super dump];
}

#pragma mark -
#pragma mark NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.fullName = [aDecoder decodeObjectForKey:kTDFullNameKey];
        self.facebookUserID = [aDecoder decodeObjectForKey:kTDFacebookUserIDKey];
        self.city = [aDecoder decodeObjectForKey:kTDCityKey];
        self.country = [aDecoder decodeObjectForKey:kTDCountryKey];
        self.birthday = [aDecoder decodeObjectForKey:kTDBirthdayKey];
        self.gender = [aDecoder decodeObjectForKey:kTDGenderKey];
        
        self.modelPreviewImage = [aDecoder decodeObjectForKey:kTDModelPreviewImageKey];
        self.modelFullImage = [aDecoder decodeObjectForKey:kTDModelFullImageKey];
        
        self.fullDataModelLoaded = [aDecoder decodeBoolForKey:kTDFullDataModelLoadedKey];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.fullName forKey:kTDFullNameKey];
    [aCoder encodeObject:self.facebookUserID forKey:kTDFacebookUserIDKey];
    [aCoder encodeObject:self.city forKey:kTDCityKey];
    [aCoder encodeObject:self.country forKey:kTDCountryKey];
    [aCoder encodeObject:self.birthday forKey:kTDBirthdayKey];
    [aCoder encodeObject:self.gender forKey:kTDGenderKey];
    
    [aCoder encodeObject:self.modelPreviewImage forKey:kTDModelPreviewImageKey];
    [aCoder encodeObject:self.modelFullImage forKey:kTDModelFullImageKey];
    
    [aCoder encodeBool:self.fullDataModelLoaded forKey:kTDFullDataModelLoadedKey];
}

@end
