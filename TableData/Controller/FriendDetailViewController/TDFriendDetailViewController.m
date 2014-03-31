//
//  TDFriendDetailViewController.m
//  TableData
//
//  Created by Vitaliy Voronok on 3/29/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TDFriendDetailViewController.h"
#import "TDFriendDetailView.h"
#import "TDImageView.h"
#import "TDModel.h"
#import "TDContextLoadingFullInfo.h"

@interface TDFriendDetailViewController ()
@property (nonatomic, readonly) TDFriendDetailView          *friendView;
@property (nonatomic, retain)   TDContextLoadingFullInfo    *loadFullModel;

@end

@implementation TDFriendDetailViewController

@dynamic friendView;


#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.model = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loadFullModel = [TDContextLoadingFullInfo object];
    TDContextLoadingFullInfo    *loadFullModel = self.loadFullModel;
    loadFullModel.model = self.model;
    [loadFullModel addObserver:self];
    [loadFullModel executeOperation];
}

#pragma mark -
#pragma mark Accessors

- (TDFriendDetailView *)friendView {
    if ([self isViewLoaded] && [self.view isKindOfClass:[TDFriendDetailView class]]) {
        return (TDFriendDetailView *)self.view;
    }
    
    return nil;
}

#pragma mark -
#pragma mark Public

- (void)setModel:(TDModel *)model {
    if (_model != model) {
        [_model removeObserver:self];
        [_model release];
        
        _model = [model retain];
        [_model addObserver:self];
    }
}

#pragma mark -
#pragma mark Private

- (void)fillWithModel {
    TDFriendDetailView *friendView = self.friendView;
    TDModel *model = self.model;
    
    [friendView.imageModel setModelImage:model.modelFullImage];
    friendView.nameLable.text = model.fullName;
    friendView.cityLable.text = model.city;
    friendView.countryLable.text = model.country;
    friendView.birthdayLable.text = model.birthday;
    friendView.genderLable.text = model.gender;
}

#pragma mark -
#pragma mark TDTaskCompletion.h

- (void)modelDidLoad:(id)object {
    [self fillWithModel];
    [self.loadFullModel removeObserver:self];
    self.loadFullModel = nil;
}

@end
