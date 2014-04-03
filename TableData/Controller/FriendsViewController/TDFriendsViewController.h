//
//  TDViewController.h
//  TableData
//
//  Created by Vitaliy Voronok on 3/5/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "IDPKit.h"

@class TDUsers;

@interface TDFriendsViewController : UIViewController   <UITableViewDataSource,
                                                        UITableViewDelegate,
                                                        IDPModelObserver,
                                                        FBLoginViewDelegate>
@property (nonatomic, retain) TDUsers *models;

- (IBAction)onEdit:(id)sender;
- (IBAction)onAdd:(id)sender;

@end
