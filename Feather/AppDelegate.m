//
//  AppDelegate.m
//  Feather
//
//  Created by Renata Guttenová on 20/05/2017.
//  Copyright © 2017 Renata Guttenová. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] init];
    self.window.frame = [[UIScreen mainScreen] bounds];
    
    MainViewController *viewController = [[MainViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];

    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    navigationController.navigationBar.translucent = NO;
        
//    UIBarButtonItem *buttonAdd = [[UIBarButtonItem alloc] initWithTitle:@"+" style:UIBarButtonItemStyleBordered target:self action:@selector(dismiss)];
//    navigationController.navigationItem.rightBarButtonItem = buttonAdd;
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
}


- (void)applicationWillTerminate:(UIApplication *)application {
}


@end
