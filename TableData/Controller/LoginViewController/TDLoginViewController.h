//
//  TDLoginView.h
//  TableData
//
//  Created by Vitaliy Voronok on 3/28/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "IDPKit.h"

@class TDFriendsViewController;
@class TDUsers;

@interface TDLoginViewController : UIViewController <FBLoginViewDelegate>
@property (nonatomic, retain) TDUsers *models;

- (IBAction)onShowFriends:(id)sender;

@end