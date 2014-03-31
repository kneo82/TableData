//
//  TDContextLoadingUsers.m
//  TableData
//
//  Created by Vitaliy Voronok on 3/29/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TDContextLoadingUsers.h"
#import "TDModel.h"
#import "TDImageModel.h"
#import "TDModels.h"

static NSString *const kTDNameKey = @"name";
static NSString *const kTDFacebookUserID = @"uid";
static NSString *const kTDPreviewImageKey = @"pic_square";

static NSString *const query =
@"SELECT uid, name, pic_square FROM user WHERE uid IN "
@"(SELECT uid2 FROM friend WHERE uid1 = me())";

@implementation TDContextLoadingUsers

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.models = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark Public

- (TDModel *)parseItemResultRequest:(id)item {
    NSString *name =[item objectForKey:kTDNameKey];
    NSString *imageFilePath = [item objectForKey:kTDPreviewImageKey];
    NSString *facebookUserID = [item objectForKey:kTDFacebookUserID];
    
    TDImageModel *imageModel = [[[TDImageModel alloc] initWithFilePath:imageFilePath] autorelease];
    TDModel *model = [TDModel object];
    model.fullName = name;
    model.modelPreviewImage = imageModel;
    model.facebookUserID = facebookUserID;
    
    return model;
}

- (void)finishExecutingOperation:(NSArray *)array {
    [self.models addModelsFromArray:array];
    [super finishExecutingOperation:array];
}

- (void)prepareExecutingOperation {
    self.query = query;
    [super prepareExecutingOperation];
}

@end
