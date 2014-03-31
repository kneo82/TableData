//
//  TDFriendDetailView.h
//  TableData
//
//  Created by Vitaliy Voronok on 3/29/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TDImageView;

@interface TDFriendDetailView : UIView
@property (nonatomic, retain)   IBOutlet TDImageView    *imageModel;
@property (nonatomic, retain)   IBOutlet UILabel        *nameLable;
@property (nonatomic, retain)   IBOutlet UILabel        *cityLable;
@property (nonatomic, retain)   IBOutlet UILabel        *countryLable;
@property (nonatomic, retain)   IBOutlet UILabel        *birthdayLable;
@property (nonatomic, retain)   IBOutlet UILabel        *genderLable;

@end
