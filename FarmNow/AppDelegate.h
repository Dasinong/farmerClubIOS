//
//  AppDelegate.h
//  FarmNow
//
//  Created by zheliang on 15/10/15.
//  Copyright (c) 2015年 zheliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, assign, readonly) UINavigationController *currentController;
@property (nonatomic, strong) UITabBarController *tabBarController;


@end

