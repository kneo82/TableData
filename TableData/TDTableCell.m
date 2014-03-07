//
//  TDTableCell.m
//  TableData
//
//  Created by Vitaliy Voronok on 3/7/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TDTableCell.h"
#import "TDModel.h"

@implementation TDTableCell

#pragma mark -
#pragma mark Accessors

- (NSString *)restorationIdentifier {
    return NSStringFromClass([self class]);
}

#pragma mark -
#pragma mark Accessors

- (void)fillWithModel:(TDModel *)model {
    self.textLabel.text = model.string;
}

@end
