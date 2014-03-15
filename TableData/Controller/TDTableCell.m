//
//  TDTableCell.m
//  TableData
//
//  Created by Vitaliy Voronok on 3/7/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TDTableCell.h"

#import "TDModel.h"

#import "NSBundle+TDExtensions.h"
#import "NSObject+TDExtensions.h"

@implementation TDTableCell

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.model = nil;
    self.imageModel = nil;
    self.label = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark Accessors

- (NSString *)restorationIdentifier {
    return NSStringFromClass([self class]);
}

- (void)setModel:(TDModel *)model {
    if (model != _model) {

//        [_model removeObserver:self];
//        [_model release];
        
        _model = [model retain];
        [_model addObserver:self];
        
        if (nil != _model) {
            self.label.text = @"Loading";
            [_model load];
        }
    }
}

#pragma mark -
#pragma mark Public

- (void)fillWithModel:(TDModel *)model {
    [self.imageModel setImageFromModel:model.modelImage];
    self.label.text = model.string;
}

#pragma mark -
#pragma mark TDTaskCompletion.h

- (void)modelDidLoad:(id)object {
    [self fillWithModel:_model];
}

@end
