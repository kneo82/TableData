//
//  TDViewController.m
//  TableData
//
//  Created by Vitaliy Voronok on 3/5/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TDFriendsViewController.h"

#import "TDFriendsView.h"
#import "TDFriendDetailViewController.h"
#import "TDTableCell.h"

#import "TDModels.h"
#import "TDModel.h"
#import "TDContextLoadingUsers.h"
#import "UITableView+TDExtensions.h"

static NSString *const kFriendsViewTitle = @"Friends";

@interface TDFriendsViewController ()
@property (nonatomic, readonly) TDFriendsView           *mainView;
@property (nonatomic, retain)   TDContextLoadingUsers   *loadFromFacebook;

- (void)loadModels;

@end

@implementation TDFriendsViewController

@dynamic mainView;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.models = nil;
    self.loadFromFacebook = nil;
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        self.title = kFriendsViewTitle;
        self.mainView.loadingView.hidden = NO;
    }
    
    return self;
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainView.loadingView.hidden = NO;
    if (!self.models) {
        self.models = [TDModels object];
    }

    [self loadModels];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    [self.models dump];
}

#pragma mark -
#pragma mark Accessors

- (TDFriendsView *)mainView {
    if ([self isViewLoaded] && [self.view isKindOfClass:[TDFriendsView class]]) {
        return (TDFriendsView *)self.view;
    }
    
    return nil;
}

- (void)setModels:(TDModels *)models {
    if (models != _models) {
        [_models removeObserver:self];
        [_models release];

        _models = [models retain];
        [_models addObserver:self];
    }
}

#pragma mark -
#pragma mark Interface Handling

- (IBAction)onEdit:(id)sender{
    TDFriendsView *view = self.mainView;
	view.editing = !view.editing;
}

- (IBAction)onAdd:(id)sender {
    [self.models addModel:[TDModel object]];
    
    UITableView *tableView = self.mainView.table;
	
	NSUInteger lastRow = [tableView numberOfRowsInSection:0];
	NSIndexPath *pathForLastRow = [NSIndexPath indexPathForRow:lastRow inSection:0];
    
    [tableView updateTableViewWithBlock:^{
        [tableView insertRowsAtIndexPaths:@[pathForLastRow]
                         withRowAnimation:UITableViewRowAnimationTop];
    }];
}

#pragma mark -
#pragma mark Private

- (void)loadModels {
    self.loadFromFacebook = [TDContextLoadingUsers object];
    TDContextLoadingUsers *loadFromFacebook = self.loadFromFacebook;
    loadFromFacebook.models = self.models;
    [loadFromFacebook addObserver:self];
    [loadFromFacebook executeOperation];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.models.models count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TDTableCell *cell = [tableView dequeueCell:[TDTableCell class]];
    
    TDModel *cellModel = self.models.models[indexPath.row];
	cell.model = cellModel;

    return  cell;
}

- (void)  tableView:(UITableView *)tableView
 commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
  forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.models removeModel:self.models.models[indexPath.row]];
        [tableView updateTableViewWithBlock:^{
            [tableView deleteRowsAtIndexPaths:@[indexPath]
							 withRowAnimation:UITableViewRowAnimationFade];
        }];
	}
}

- (void)  tableView:(UITableView *)tableView
 moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
		toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [self.models moveModelFromIndex:sourceIndexPath.row
                            toIndex:destinationIndexPath.row];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (void)                        tableView:(UITableView *)tableView
 accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    TDFriendDetailViewController *object;
    object = [[TDFriendDetailViewController newViewControllerWithDefaultNib] autorelease];
    TDModel *model = self.models.models[indexPath.row];
    object.title = model.fullName;
    object.model = model;
    [self.navigationController pushViewController:object animated:YES]; 
}

#pragma mark -
#pragma mark TDTaskCompletion

- (void)modelDidLoad:(id)object {
    TDFriendsView *view = self.mainView;
    
    view.loadingView.hidden = YES;
    [view.table reloadData];
    
    [self.loadFromFacebook removeObserver:self];
    self.loadFromFacebook = nil;
}

@end
