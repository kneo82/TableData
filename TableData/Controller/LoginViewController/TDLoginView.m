//
//  TDLoginView.m
//  TableData
//
//  Created by Vitaliy Voronok on 3/28/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TDLoginView.h"

static NSString *const kTDBasicInfoPermissions = @"basic_info";
static NSString *const kTDFriendsBirthdayPermissions = @"friends_birthday";
static NSString *const kTDFriendsHometownPermissions = @"friends_hometown";

@implementation TDLoginView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.loginView = nil;
    self.pictureView = nil;
    self.nameLable = nil;
    self.buttonFriends = nil;
    
    [super dealloc];
}


- (void)awakeFromNib {
    NSArray *requestPermissions = @[kTDBasicInfoPermissions,
                                    kTDFriendsBirthdayPermissions,
                                    kTDFriendsHometownPermissions];
    self.loginView.readPermissions = requestPermissions;
}

@end
