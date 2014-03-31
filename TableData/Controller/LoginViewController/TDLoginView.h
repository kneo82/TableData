//
//  TDLoginView.h
//  TableData
//
//  Created by Vitaliy Voronok on 3/28/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface TDLoginView : UIView
@property (nonatomic, retain)   IBOutlet UILabel                *nameLable;
@property (nonatomic, retain)   IBOutlet FBLoginView            *loginView;
@property (nonatomic, retain)   IBOutlet FBProfilePictureView   *pictureView;
@property (nonatomic, retain)   IBOutlet UIButton               *buttonFriends;

@end
