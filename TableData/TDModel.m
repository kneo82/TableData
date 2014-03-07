//
//  TDModel.m
//  TableData
//
//  Created by Vitaliy Voronok on 3/7/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TDModel.h"
#import "NSObject+TDExtensions.h"
#import "NSString+TDExtensions.h"

static const NSUInteger kTDLengthString = 20;

@implementation TDModel

#pragma mark -
#pragma mark Class Methods

+ (id)model {
    TDModel *model = [TDModel object];
    model.string = [NSString randomStringOfLength:kTDLengthString];

    return model;
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.string = nil;
    
    [super dealloc];
}


@end
