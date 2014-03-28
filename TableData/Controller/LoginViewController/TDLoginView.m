//
//  TDLoginView.m
//  TableData
//
//  Created by Vitaliy Voronok on 3/28/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TDLoginView.h"

@implementation TDLoginView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.loginView = nil;
    self.pictureView = nil;
    self.nameLable = nil;
    
    [super dealloc];
}

@end
