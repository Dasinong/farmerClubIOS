//
//  UITabBarController+HideTabBar.h
//  FarmNow
//
//  Created by zheliang on 15/10/29.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarController (HideTabBar)
@property (nonatomic, getter=isTabBarHidden) BOOL tabBarHidden;
- (void)setTabBarHidden:(BOOL)hidden animated:(BOOL)animated completion:(void(^)( BOOL finished)) completion;
@end
