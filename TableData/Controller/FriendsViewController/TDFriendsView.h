//
//  TDView.h
//  TableData
//
//  Created by Vitaliy Voronok on 3/5/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface TDFriendsView : UIView 
@property (nonatomic, retain)   IBOutlet UITableView        *table;
@property (nonatomic, retain)	IBOutlet UIBarButtonItem	*editButton;
@property (nonatomic, retain)	IBOutlet UIBarButtonItem	*addButton;
@property (nonatomic, retain)   IBOutlet UIView             *loadingView;

@property (nonatomic, assign, getter = isEditing)	BOOL	editing;

@end
