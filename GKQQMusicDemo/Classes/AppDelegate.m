//
//  AppDelegate.m
//  GKQQMusicDemo
//
//  Created by QuintGao on 2017/9/9.
//  Copyright © 2017年 高坤. All rights reserved.
//

#import "AppDelegate.h"
#import "GKQQListViewController.h"
#import "GKQQPlayerViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 配置导航栏外观
    [self setupNavConfigure];
    
    // 初始化window
    self.window                     = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor     = [UIColor whiteColor];
    self.window.rootViewController  = [UINavigationController rootVC:[GKQQListViewController new] translationScale:NO];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)setupNavConfigure {
    [GKConfigure setupCustomConfigure:^(GKNavigationBarConfigure *configure) {
        configure.backgroundColor = [UIColor whiteColor];
        configure.titleColor = [UIColor whiteColor];
        configure.titleFont = [UIFont systemFontOfSize:18.0];
        configure.statusBarStyle = UIStatusBarStyleLightContent;
        
        configure.backStyle = GKNavigationBarBackStyleWhite;
    }];
}

@end
