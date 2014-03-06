//
//  TDViewController.m
//  TableData
//
//  Created by Vitaliy Voronok on 3/5/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TDViewController.h"
#import "TDView.h"

@interface TDViewController ()
@property (nonatomic, readonly) TDView *theView;

@end

@implementation TDViewController

@dynamic theView;

#pragma mark -
#pragma mark Initializations and Deallocations

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark -
#pragma mark Accessors

- (TDView *)theView {
    if ([self isViewLoaded] && [self.view isKindOfClass:[TDView class]]) {
        return (TDView *)self.view;
    }
    
    return nil;
}

@end
