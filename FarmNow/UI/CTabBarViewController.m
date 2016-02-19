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
                                 [self.storyboard instantiateViewControllerWithIdentifier:@"couponNavigationController"],
                                 [self.storyboard instantiateViewControllerWithIdentifier:@"wikiNavigationController"],
                                 [self.storyboard instantiateViewControllerWithIdentifier:@"mineNavigationController"],
                                 ];
    }
    else {
        
        if ([[USER.userType lowercaseString] isEqualToString:@"retailer"]) {
            self.viewControllers = @[
                                     [self.storyboard instantiateViewControllerWithIdentifier:@"weatherNavigationController"],
                                     [self.storyboard instantiateViewControllerWithIdentifier:@"fieldNavigationController"],
                                     [self.storyboard instantiateViewControllerWithIdentifier:@"storeNavigationController"],
                                     [self.storyboard instantiateViewControllerWithIdentifier:@"wikiNavigationController"],
                                     [self.storyboard instantiateViewControllerWithIdentifier:@"mineNavigationController"],
                                     ];
        }
        else {
            self.viewControllers = @[
                                     [self.storyboard instantiateViewControllerWithIdentifier:@"weatherNavigationController"],
                                     [self.storyboard instantiateViewControllerWithIdentifier:@"fieldNavigationController"],
                                     [self.storyboard instantiateViewControllerWithIdentifier:@"couponNavigationController"],
                                     [self.storyboard instantiateViewControllerWithIdentifier:@"wikiNavigationController"],
                                     [self.storyboard instantiateViewControllerWithIdentifier:@"mineNavigationController"],
                                     ];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)signinNotification:(NSNotification *)notification {
    if ([[USER.userType lowercaseString] isEqualToString:@"retailer"]) {
        if (![self.viewControllers[2].restorationIdentifier isEqualToString:@"storeNavigationController"]) {
            UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"storeNavigationController"];
            self.viewControllers = @[
                                     self.viewControllers[0],
                                     self.viewControllers[1],
                                     controller,
                                     self.viewControllers[3],
                                     self.viewControllers[4],
                                     ];
        }
    }
    else {
        if (![self.viewControllers[2].restorationIdentifier isEqualToString:@"couponNavigationController"]) {
            UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"couponNavigationController"];
            self.viewControllers = @[
                                     self.viewControllers[0],
                                     self.viewControllers[1],
                                     controller,
                                     self.viewControllers[3],
                                     self.viewControllers[4],
                                     ];
        }
    }
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
