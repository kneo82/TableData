//
//  TDTableCell.h
//  TableData
//
//  Created by Vitaliy Voronok on 3/7/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TDModel;

@interface TDTableCell : UITableViewCell

- (void)fillWithModel:(TDModel *)model;

@end
