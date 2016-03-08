//
//  CTabBarViewController.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/17.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CTabBarViewController.h"
#import "CPersonalCache.h"

@interface CTabBarViewController ()

@end

@implementation CTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(signinNotification:) name:@"notification_signin" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(signoutNotification:) name:@"notification_signout" object:nil];
    
    if (USER == nil) {
        self.viewControllers = @[
                                 [self.storyboard instantiateViewControllerWithIdentifier:@"weatherNavigationController"],
                                 [self.storyboard instantiateViewControllerWithIdentifier:@"fieldNavigationController"],
                                 [self.storyboard instantiateViewControllerWithIdentifier:@"wikiNavigationController"],
                                 [self.storyboard instantiateViewControllerWithIdentifier:@"mineNavigationController"],
                                 ];
    }
    else {
        NSMutableArray *vcArray = [NSMutableArray array];
        [vcArray addObject:[self.storyboard instantiateViewControllerWithIdentifier:@"weatherNavigationController"]];
        [vcArray addObject:[self.storyboard instantiateViewControllerWithIdentifier:@"fieldNavigationController"]];
        
        BOOL enableWelfare = NO;
        if ([USER_DEFAULTS objectForKey:@"clientConfig"]) {
            NSDictionary *clientConfig = [USER_DEFAULTS objectForKey:@"clientConfig"];
            if (clientConfig[@"enableWelfare"]) {
                if ([clientConfig[@"enableWelfare"] boolValue]) {
                    enableWelfare = YES;
                }
            }
        }
        
        if (enableWelfare) {
            if ([[USER.userType lowercaseString] isEqualToString:@"retailer"]) {
                [vcArray addObject:[self.storyboard instantiateViewControllerWithIdentifier:@"storeNavigationController"]];
            }
            else {
                [vcArray addObject:[self.storyboard instantiateViewControllerWithIdentifier:@"couponNavigationController"]];
            }
        }
        
        [vcArray addObject:[self.storyboard instantiateViewControllerWithIdentifier:@"wikiNavigationController"]];
        [vcArray addObject:[self.storyboard instantiateViewControllerWithIdentifier:@"mineNavigationController"]];
        
        self.viewControllers = vcArray;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    if ([delegate.jumpState isEqualToString:@"wiki"]) {
        self.selectedIndex = 3;
        // 然后要跳转到巴斯夫产品页
    }
    else if ([delegate.jumpState isEqualToString:@"campaign"]) {
        self.selectedIndex = 2;
        
        delegate.jumpState = nil;
    }
    else if ([delegate.jumpState isEqualToString:@"qr"]) {
        self.selectedIndex = 4;
        // 然后要跳转到扫一扫
    }
}

- (void)signinNotification:(NSNotification *)notification {
    BOOL enableWelfare = NO;
    if ([USER_DEFAULTS objectForKey:@"clientConfig"]) {
        NSDictionary *clientConfig = [USER_DEFAULTS objectForKey:@"clientConfig"];
        if (clientConfig[@"enableWelfare"]) {
            if ([clientConfig[@"enableWelfare"] boolValue]) {
                enableWelfare = YES;
            }
        }
    }
    
    NSMutableArray *vcArray = [NSMutableArray array];
    [vcArray addObject:self.viewControllers[0]];
    [vcArray addObject:self.viewControllers[1]];
    
    if (enableWelfare) {
        if ([[USER.userType lowercaseString] isEqualToString:@"retailer"]) {
            [vcArray addObject:[self.storyboard instantiateViewControllerWithIdentifier:@"storeNavigationController"]];
        }
        else {
            [vcArray addObject:[self.storyboard instantiateViewControllerWithIdentifier:@"couponNavigationController"]];
        }
    }
    
    [vcArray addObject:self.viewControllers[self.viewControllers.count - 2]];
    [vcArray addObject:self.viewControllers[self.viewControllers.count - 1]];
    
    self.viewControllers = vcArray;
}

- (void)signoutNotification:(NSNotification *)notification {
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
