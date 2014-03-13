//
//  TDImageView.h
//  TableData
//
//  Created by Vitaliy Voronok on 3/13/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDModelObserver.h"

@class TDModelImage;

@interface TDImageView : UIView <TDModelObserver>
@property (nonatomic, retain)  IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain)  IBOutlet UIImageView             *imageView;

- (void)setImageFromModel:(TDModelImage *)modelImage;

@end
