//
//  TDViewController.h
//  TableData
//
//  Created by Vitaliy Voronok on 3/5/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

#import "TDModelObserver.h"

@class TDModels;

@interface TDViewController : UIViewController <UITableViewDataSource, TDModelObserver, FBLoginViewDelegate, TDModelObserver>
@property (nonatomic, retain) TDModels *models;

- (IBAction)onEdit:(id)sender;
- (IBAction)onAdd:(id)sender;

@end
