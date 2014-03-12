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
#import "UIImageView+TDExtensions.h"


@implementation TDTableCell

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.activityIndicator = nil;
    self.model = nil;
    
    [super dealloc];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIActivityIndicatorView *spinner = self.activityIndicator;
    spinner.center = self.imageView.center;
    [spinner stopAnimating];
}

#pragma mark -
#pragma mark Accessors

- (NSString *)restorationIdentifier {
    return NSStringFromClass([self class]);
}

- (void)setModel:(TDModel *)model {
    if (model != _model) {
        [_model removeObserver:self];
        [_model release];
        
        _model = [model retain];
        [_model addObserver:self];
        
        if (nil != _model) {
            [self.activityIndicator startAnimating];
            self.textLabel.text = @"Loading";
            self.imageView.image = [UIImage imageNamed:@"blank.png"];
            
            [_model load];
            [self fillWithModel:_model];
        }
    }
}


#pragma mark -
#pragma mark Accessors

- (void)fillWithModel:(TDModel *)model {
    [self.imageView setImageFromModel:model.modelImage];
    self.textLabel.text = model.string;
}

#pragma mark -
#pragma mark TDTaskCompletion.h

- (void)modelDidLoad:(id)object {
//    TDModel *model = object;
//    [self fillWithModel:model];

    [self.activityIndicator stopAnimating];
}

@end
