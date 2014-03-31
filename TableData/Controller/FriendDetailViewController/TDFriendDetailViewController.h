//
//  TDFriendDetailViewController.h
//  TableData
//
//  Created by Vitaliy Voronok on 3/29/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDPKit.h"

@class TDModel;

@interface TDFriendDetailViewController : UIViewController <IDPModelObserver>
@property (nonatomic, retain)   TDModel *model;

@end
