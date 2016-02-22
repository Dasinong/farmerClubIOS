//
//  CSplashViewController.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/22.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CSplashViewController.h"

@implementation CSplashViewController
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        UIViewController* controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CWeatherDrawerController"];
        delegate.window.rootViewController = controller;
    });
}
@end
