//
//  TDFriendDetailView.m
//  TableData
//
//  Created by Vitaliy Voronok on 3/29/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TDFriendDetailView.h"
#import "TDUser.h"
#import "TDImageView.h"

@implementation TDFriendDetailView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.imageModel = nil;
    self.nameLable = nil;
    self.cityLable = nil;
    self.countryLable = nil;
    self.birthdayLable = nil;
    self.genderLable = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark Public

- (void)fillWithModel:(TDUser *)model {
    self.imageModel.modelImage = model.modelFullImage;
    self.nameLable.text = model.fullName;
    self.cityLable.text = model.city;
    self.countryLable.text = model.country;
    self.birthdayLable.text = model.birthday;
    self.genderLable.text = model.gender;
}

@end
