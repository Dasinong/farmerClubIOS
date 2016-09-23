//
//  CBASFNaviViewController.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/3/8.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CBASFNaviViewController.h"
#import "AppDelegate.h"
#import "CPersonalCache.h"

@interface CBASFNaviViewController ()
@property (nonatomic, weak) IBOutlet UIButton *qrButton;
@end

@implementation CBASFNaviViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([[USER.userType lowercaseString] isEqualToString:@"retailer"]) {
        [self.qrButton setImage:[UIImage image_s:@"BASFNaviButton4Alt"] forState:UIControlStateNormal];
    }
    else {
        [self.qrButton setImage:[UIImage image_s:@"BASFNaviButton4"] forState:UIControlStateNormal];
    }
    
}

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
