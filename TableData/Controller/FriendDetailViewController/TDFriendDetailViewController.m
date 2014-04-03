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
#import "TDUser.h"
#import "TDUserContext.h"

@interface TDFriendDetailViewController ()
@property (nonatomic, readonly) TDFriendDetailView  *friendView;
@property (nonatomic, retain)   TDUserContext       *loadFullModel;

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
    self.loadFullModel = [TDUserContext object];
    TDUserContext *loadFullModel = self.loadFullModel;
    loadFullModel.model = self.model;
    [loadFullModel executeOperation];
}

#pragma mark -
#pragma mark Accessors

IDPViewControllerViewOfClassGetterSynthesize(TDFriendDetailView, friendView)

#pragma mark -
#pragma mark Public


- (void)setModel:(TDUser *)model {
    IDPNonatomicRetainPropertySynthesizeWithObserver(_model, model);
    self.title = model.fullName;
}

- (void)setLoadFullModel:(TDUserContext *)loadFullModel {
    [loadFullModel cancel];
    IDPNonatomicRetainPropertySynthesizeWithObserver(_loadFullModel, loadFullModel);
}

#pragma mark -
#pragma mark Private

- (void)fillWithModel {
    [self.friendView fillWithModel:self.model];
}

#pragma mark -
#pragma mark TDTaskCompletion.h

- (void)modelDidLoad:(id)object {
    [self fillWithModel];
    self.loadFullModel = nil;
}

- (void)modelDidCancelLoading:(id)theModel {
    self.loadFullModel = nil;
}

@end
