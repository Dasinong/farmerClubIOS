//
//  CSplashViewController.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/22.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CSplashViewController.h"
#import "CPersonalCache.h"

@interface CSplashViewController ()
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *splashImageView;

@end

@implementation CSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    [self.versionLabel setText:[NSString stringWithFormat:@"当前版本：%@",[infoDictionary objectForKey:@"CFBundleShortVersionString"]]];
    
    if ([USER isBASF]) {
        [self.splashImageView setImage:[UIImage image_s:@"DefaultBASF"]];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        if ([USER isBASF]) {
            UIViewController *controller  = [self.storyboard instantiateViewControllerWithIdentifier:@"CBASFNaviViewController"];
            delegate.window.rootViewController = controller;
        }
        else {
            UIViewController* controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CWeatherDrawerController"];
            delegate.window.rootViewController = controller;
        }
    });
}
@end
