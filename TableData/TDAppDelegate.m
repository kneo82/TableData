//
//  TDAppDelegate.m
//  TableData
//
//  Created by Vitaliy Voronok on 3/5/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TDAppDelegate.h"
#import "TDFriendsViewController.h"
#import "TDModels.h"
#import "TDLoginViewController.h"
#import "IDPKit.h"

@interface TDAppDelegate ()
@property (nonatomic, retain)   TDModels    *models;

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
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    TDLoginViewController *loginController = [[TDLoginViewController newViewControllerWithDefaultNib] autorelease];
    UIViewController *controller = [[[UINavigationController alloc] initWithRootViewController:loginController] autorelease];
    
    self.window.rootViewController = controller;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    BOOL wasHandled = [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
    
    return wasHandled;
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
