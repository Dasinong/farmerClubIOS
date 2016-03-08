//
//  CBASFNaviViewController.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/3/8.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CBASFNaviViewController.h"
#import "AppDelegate.h"

@implementation CBASFNaviViewController
- (IBAction)weather:(id)sender {
    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    UIViewController* controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CWeatherDrawerController"];
    delegate.window.rootViewController = controller;
}

- (IBAction)wiki:(id)sender {
    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    UIViewController* controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CWeatherDrawerController"];
    delegate.jumpState = @"wiki";
    delegate.window.rootViewController = controller;
}

- (IBAction)daren:(id)sender {
    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    UIViewController* controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CWeatherDrawerController"];
    delegate.jumpState = @"campaign";
    delegate.window.rootViewController = controller;
}

- (IBAction)scanQR:(id)sender {
    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    UIViewController* controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CWeatherDrawerController"];
    delegate.jumpState = @"qr";
    delegate.window.rootViewController = controller;
}
@end
