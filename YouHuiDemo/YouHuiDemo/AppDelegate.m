//
//  AppDelegate.m
//  YouHuiDemo
//
//  Created by ZIKong on 2017/6/5.
//  Copyright © 2017年 youhuikeji. All rights reserved.
//

#import "AppDelegate.h"
#import "YHKJLoginViewController.h"
#import "YHKJContext.h"
#import "GPFsliderViewController.h"
#import "GPFLeftViewController.h"

#define Context [YHKJContext sharedInstance]

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    UINavigationController *rootViewController = [[UINavigationController alloc] init];
    rootViewController.navigationBarHidden = YES;
    self.window.rootViewController = rootViewController;
    
    Context.rootViewController =  (UINavigationController *)self.window.rootViewController;
    
    
    //TODO 侧滑菜单
    [GPFsliderViewController sharedSliderController].MainVC = [[UINavigationController alloc] init];
    
    
    GPFLeftViewController *leftVC = [[GPFLeftViewController alloc] init];
    [GPFsliderViewController sharedSliderController].LeftVC = leftVC;
    
//    [GPFsliderViewController sharedSliderController].LeftSContentOffset=275;
    [GPFsliderViewController sharedSliderController].LeftSContentOffset=self.window.bounds.size.width-60;

    [GPFsliderViewController sharedSliderController].LeftContentViewSContentOffset = 90;
    //        [GPFsliderViewController sharedSliderController].LeftSContentScale=0.77;
    [GPFsliderViewController sharedSliderController].LeftSContentScale=1;
    [GPFsliderViewController sharedSliderController].LeftSJudgeOffset=160;
    [GPFsliderViewController sharedSliderController].changeLeftView = ^(CGFloat sca, CGFloat transX)
    {
        CGAffineTransform ltransS = CGAffineTransformMakeScale(sca, sca);
        CGAffineTransform ltransT = CGAffineTransformMakeTranslation(transX, 0);
        CGAffineTransform lconT   = CGAffineTransformConcat(ltransT, ltransS);
        leftVC.view.transform = lconT;
    };
    [[GPFsliderViewController sharedSliderController] setupRightViewController];
    [GPFsliderViewController sharedSliderController].panGestureRec.enabled = NO;
    [GPFsliderViewController sharedSliderController].tapGestureRec.enabled = NO;
    [Context.rootViewController pushViewController:[GPFsliderViewController sharedSliderController] animated:NO];
    //TODO 侧滑菜单
    [Context.rootViewController pushViewController:[[YHKJLoginViewController alloc] init] animated:NO];
    

//    YHKJLoginViewController *loginVC = [[YHKJLoginViewController alloc] init];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
//    self.window.rootViewController = nav;

    
    
    [self.window makeKeyAndVisible];

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
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
