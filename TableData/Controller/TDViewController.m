//
//  TDViewController.m
//  TableData
//
//  Created by Vitaliy Voronok on 3/5/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TDViewController.h"

#import "TDView.h"
#import "TDTableCell.h"

#import "TDModels.h"
#import "TDModel.h"

#import "TDObservableObject.h"
#import "NSObject+TDExtensions.h"
#import "UITableView+TDExtensions.h"

@interface TDViewController ()
@property (nonatomic, readonly)             TDView      *mainView;

- (void)loadModels;

@end

@implementation TDViewController

@dynamic mainView;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.models = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadModels];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    [self.models dump];
}

#pragma mark -
#pragma mark Accessors

- (TDView *)mainView {
    if ([self isViewLoaded] && [self.view isKindOfClass:[TDView class]]) {
        return (TDView *)self.view;
    }
    
    return nil;
}

- (void)setModels:(TDModels *)models {
    if (models != _models) {
        [_models removeObserver:self];
        [_models release];

        _models = [models retain];
        [_models addObserver:self];
        
        if (_models) {
            [self loadModels];
        }
    }
}

#pragma mark -
#pragma mark Interface Handling

- (IBAction)onEdit:(id)sender{
    TDView *view = self.mainView;
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
    self.mainView.loadingView.hidden = NO;
    
    [self.models load];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.models.models count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TDTableCell *cell = [tableView reusableCellOfClass:[TDTableCell class]];
    cell.model = self.models.models[indexPath.row];
    
    return  cell;
}

- (void)  tableView:(UITableView *)tableView
 commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
  forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tableView updateTableViewWithBlock:^{
            [self.models removeModel:self.models.models[indexPath.row]];
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
#pragma mark TDTaskCompletion

- (void)modelDidLoad:(id)object {
    TDView *view = self.mainView;
    
    view.loadingView.hidden = YES;
    [view.table reloadData];
}

@end
