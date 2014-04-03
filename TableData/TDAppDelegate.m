//
//  TDAppDelegate.m
//  TableData
//
//  Created by Vitaliy Voronok on 3/5/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TDAppDelegate.h"
#import "TDFriendsViewController.h"
#import "TDUsers.h"
#import "TDLoginViewController.h"
#import "IDPKit.h"

#import "UIWindow+TDExtensions.h"

@interface TDAppDelegate ()
@property (nonatomic, retain)   TDUsers    *models;

@end

@implementation TDAppDelegate

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.window = nil;
    self.models = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark View Lifecycle

-           (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [UIWindow window];
    UIWindow *window = self.window;
    
    self.models = [TDUsers object];
    
    TDLoginViewController *loginController;
    loginController = [TDLoginViewController viewControllerWithDefaultNib];
    
    loginController.models = self.models;
    
    UINavigationController *controller = nil;
    controller = [[UINavigationController alloc] initWithRootViewController:loginController];
    [controller autorelease];
    
    window.rootViewController = controller;
    
    [window makeKeyAndVisible];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self.models save];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [self.models save];
}

@end
