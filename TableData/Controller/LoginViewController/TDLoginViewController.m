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
static NSString *const kTDBasicInfoPermissions = @"basic_info";
static NSString *const kTDFriendsBirthdayPermissions = @"friends_birthday";
static NSString *const kTDFriendsHometownPermissions = @"friends_hometown";

@interface TDLoginViewController ()
@property (nonatomic, readonly) TDLoginView  *loginView;

@end

@implementation TDLoginViewController

@dynamic loginView;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.friendsViewController = nil;
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = kLoginViewTitle;
        self.friendsViewController = [[TDFriendsViewController newViewControllerWithDefaultNib] autorelease];
    }
    return self;
}

#pragma mark -
#pragma mark Accessors

- (TDLoginView *)loginView {
    if ([self isViewLoaded] && [self.view isKindOfClass:[TDLoginView class]]) {
        return (TDLoginView *)self.view;
    }
    
    return nil;
}

#pragma mark -
#pragma mark Interface Handling

- (void)onShowFriends:(id)sender {
    [self.navigationController pushViewController:self.friendsViewController animated:YES];
}

#pragma mark -
#pragma mark FBLoginViewDelegate

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        NSArray *requestPermissions = @[kTDBasicInfoPermissions,
                                        kTDFriendsBirthdayPermissions,
                                        kTDFriendsHometownPermissions];
        
        [FBSession openActiveSessionWithReadPermissions:requestPermissions
                                           allowLoginUI:NO
                                      completionHandler:^(FBSession *session,
                                                          FBSessionState state,
                                                          NSError *error)
         {
         }];
    }
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user {
    self.loginView.pictureView.profileID = user.id;
    self.loginView.nameLable.text = user.name;
    self.loginView.buttonFriends.enabled = YES;
    self.loginView.buttonFriends.backgroundColor = [UIColor blueColor];
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    self.loginView.pictureView.profileID = nil;
    self.loginView.nameLable.text = @"";
    self.loginView.buttonFriends.enabled = NO;
    self.loginView.buttonFriends.backgroundColor = [UIColor grayColor];
}

@end
