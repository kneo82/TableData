//
//  TDImageView.h
//  TableData
//
//  Created by Vitaliy Voronok on 3/13/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDPKit.h"

@class TDImageModel;

@interface TDImageView : UIView <IDPModelObserver>
@property (nonatomic, retain)   IBOutlet UIActivityIndicatorView    *activityIndicator;
@property (nonatomic, retain)   IBOutlet UIImageView                *imageView;
@property (nonatomic, retain)   TDImageModel                        *modelImage;

@end
