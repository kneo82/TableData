//
//  TDViewController.m
//  TableData
//
//  Created by Vitaliy Voronok on 3/5/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TDViewController.h"

#import "TDView.h"
#import "TDModels.h"
#import "TDModel.h"

#import "TDTableCell.h"

#import "NSObject+TDExtensions.h"
#import "UITableView+TDExtensions.h"

@interface TDViewController ()
@property (nonatomic, readonly) TDView *theView;
@property (nonatomic, retain, readwrite) TDModels *models;

@end

@implementation TDViewController

@dynamic theView;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.models = nil;
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.models = [TDModels object];
    }
    
    return self;
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.models load];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    [self.models dump];
}




#pragma mark -
#pragma mark Accessors

- (TDView *)theView {
    if ([self isViewLoaded] && [self.view isKindOfClass:[TDView class]]) {
        return (TDView *)self.view;
    }
    
    return nil;
}

#pragma mark -
#pragma mark Interface Handling

- (IBAction)onEdit:(id)sender{
    TDView *view = self.theView;
	view.editing = !view.editing;
}

- (IBAction)onAdd:(id)sender {
    [self.models addModel:[TDModel model]];
    
    UITableView *tableView = self.theView.table;
	
	NSUInteger lastRow = [tableView numberOfRowsInSection:0];
	NSIndexPath *pathForLastRow = [NSIndexPath indexPathForRow:lastRow inSection:0];
    
    [tableView updateTableViewWithBlock:^{
        [tableView insertRowsAtIndexPaths:@[pathForLastRow]
                         withRowAnimation:UITableViewRowAnimationTop];
    }];
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
    [cell fillWithModel:self.models.models[indexPath.row]];
    
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

@end
