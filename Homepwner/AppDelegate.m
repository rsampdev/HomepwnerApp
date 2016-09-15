//
//  AppDelegate.m
//  Homepwner
//
//  Created by Rodney Sampson on 9/13/16.
//  Copyright © 2016 Rodney Sampson II. All rights reserved.
//

#import "AppDelegate.h"
#import "ItemStore.h"
#import "ItemsViewController.h"
#import "ImageStore.h"

@interface AppDelegate ()

@property (nonatomic) ItemStore *itemStore;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"\n\n\n\n\n%@", NSStringFromSelector(_cmd));
    ItemStore *itemStore = [ItemStore new];
    ImageStore *imageStore = [ImageStore new];
    self.itemStore = itemStore;
    UINavigationController *navController = (UINavigationController *)self.window.rootViewController;
    ItemsViewController *ivc = (ItemsViewController *)navController.topViewController;
    ivc.itemStore = itemStore;
    ivc.imageStore = imageStore;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"\n\n\n\n\n%@", NSStringFromSelector(_cmd));
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"\n\n\n\n\n%@", NSStringFromSelector(_cmd));
    BOOL success = [self.itemStore saveChanges];
    if (success) {
        NSLog(@"Saved %lu items to disk.", (unsigned long)self.itemStore.allItems.count);
    } else {
        NSLog(@"Failed to save the items to disk.");
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"\n\n\n\n\n%@", NSStringFromSelector(_cmd));
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"\n\n\n\n\n%@", NSStringFromSelector(_cmd));
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"\n\n\n\n\n%@", NSStringFromSelector(_cmd));
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
