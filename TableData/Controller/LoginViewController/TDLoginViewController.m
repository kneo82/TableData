//
//  TDLoginView.m
//  TableData
//
//  Created by Vitaliy Voronok on 3/28/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TDLoginViewController.h"
#import "TDFriendsViewController.h"
#import "TDLoginView.h"

static NSString *const kLoginViewTitle = @"Login";

@interface TDLoginViewController ()
@property (nonatomic, readonly) TDLoginView  *loginView;

@end

@implementation TDLoginViewController

@dynamic loginView;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.models = nil;
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = kLoginViewTitle;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

IDPViewControllerViewOfClassGetterSynthesize(TDLoginView, loginView)

#pragma mark -
#pragma mark Interface Handling

- (void)onShowFriends:(id)sender {
    TDFriendsViewController *controller = [TDFriendsViewController defaultNibController];
    controller.models = self.models;
    
    [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark -
#pragma mark FBLoginViewDelegate

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {

}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user {
    TDLoginView *view = self.loginView;
    UIButton *buttonFriends = view.buttonFriends;
    
    view.pictureView.profileID = user.id;
    view.nameLable.text = user.name;
    buttonFriends.enabled = YES;
    buttonFriends.backgroundColor = [UIColor blueColor];
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    TDLoginView *view = self.loginView;
    UIButton *buttonFriends = view.buttonFriends;
    
    view.pictureView.profileID = nil;
    view.nameLable.text = @"";
    buttonFriends.enabled = NO;
    buttonFriends.backgroundColor = [UIColor grayColor];
}

@end
