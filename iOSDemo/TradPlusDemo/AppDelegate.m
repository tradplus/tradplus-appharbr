//
//  AppDelegate.m
//  fluteSDKSample
//
//  Created by ms-mac on 2017/3/23.
//  Copyright © 2017年 TradPlus. All rights reserved.
//

#import "AppDelegate.h"
#import <TradPlusAds/TradPlus.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AppHarbrSDK/AppHarbrSDK-Swift.h>


@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if (@available(iOS 14.0, *))
    {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
        }];
    }
    
    NSDictionary *configuration = @{AppHarbrConfigurationKeys.debug:@(YES),AppHarbrConfigurationKeys.timeOut:@(60)};
    [[AppHarbrAdQuality shared] initializeSdkWithApiKey:@"1f53bd8b-785e-4b83-b982-c96016c6d108" directMediationSdk:AdSdkCustom configuration:configuration completion:^(NSError * _Nullable error) {
        if(error != nil)
        {
            NSLog(@"AppHarbr erorr:%@",error.localizedDescription);
        }
        else
        {
            NSLog(@"AppHarbr completion");
        }
    }];
    
    // Override point for customization after application launch.
    [TradPlus initSDK:@"7A8EC9F31CC99CBAEAD35868A9DF37F1" completionBlock:^(NSError * _Nonnull error) {
        if (!error)
        {
            NSLog(@"sdk init success!");
        }
    }];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    if (@available(iOS 14.0, *))
    {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
        }];
    }
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
@end
