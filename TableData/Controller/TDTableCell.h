//
//  TDTableCell.h
//  TableData
//
//  Created by Vitaliy Voronok on 3/7/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TDModelObserver.h"
#import "TDImageView.h"

@class TDModel;


@interface TDTableCell : UITableViewCell <TDModelObserver>
@property (nonatomic, retain)   IBOutlet TDImageView    *imageModel;
@property (nonatomic, retain)   IBOutlet UILabel        *label;

@property (nonatomic, retain)   TDModel     *model;

- (void)fillWithModel:(TDModel *)model;

@end
