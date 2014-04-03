//
//  TDTableCell.m
//  TableData
//
//  Created by Vitaliy Voronok on 3/7/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TDTableCell.h"

#import "TDUser.h"

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

- (void)setModel:(TDUser *)model {
    IDPNonatomicRetainPropertySynthesizeWithObserver(_model, model);
    
//    if (model != _model) {
//        [_model removeObserver:self];
//        [_model release];
//        
//        _model = [model retain];
//        [_model addObserver:self];
//        
        if (_model) {
            [_model load];
        }
//    }
}

#pragma mark -
#pragma mark Public

- (void)fillWithModel:(TDUser *)model {
    [self.imageModel setModelImage:model.modelPreviewImage];
    self.label.text = model.fullName;
}

#pragma mark -
#pragma mark TDTaskCompletion.h

- (void)modelDidLoad:(id)object {
    [self fillWithModel:object];
}

@end
