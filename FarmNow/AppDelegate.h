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
@property (nonatomic, assign) BOOL showQQLogin;
@property (nonatomic, assign) BOOL showWXLogin;

- (BOOL)enableWelfare; // 是否要显示福利社
- (BOOL)isDaren; // 是不是达人
- (void)uploadCachedStockArray:(BOOL)cleanIfFailed;

@property (nonatomic, strong) NSString *jumpState; // BASF的导航跳转
@end

