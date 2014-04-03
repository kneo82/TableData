//
//  TDTableCell.h
//  TableData
//
//  Created by Vitaliy Voronok on 3/7/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDPKit.h"
#import "TDImageView.h"

@class TDUser;

@interface TDTableCell : UITableViewCell <IDPModelObserver>
@property (nonatomic, retain)   IBOutlet TDImageView    *imageModel;
@property (nonatomic, retain)   IBOutlet UILabel        *label;

@property (nonatomic, retain)   TDUser     *model;

- (void)fillWithModel:(TDUser *)model;

@end
