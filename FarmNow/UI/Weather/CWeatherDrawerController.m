//
//  CWeatherDrawerController.m
//  FarmNow
//
//  Created by zheliang on 15/10/28.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CWeatherDrawerController.h"
#import "FirstViewController.h"

@interface CWeatherDrawerController () <UITabBarControllerDelegate>

@end

@implementation CWeatherDrawerController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	// basic

    // Do any additional setup after loading the view.
	UITabBarController* center = [self.storyboard controllerWithID:@"tabbarController"];
//	center.delegate = self;
	SharedAPPDelegate.tabBarController = center;
	self.maximumLeftDrawerWidth = HSScreenBounds().size.width - 100;
	[self setCenterViewController:center];
	UIViewController* left = [self.storyboard controllerWithID:@"CWeatherLeftController"];
	[self setLeftDrawerViewController:left];
	[self setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
	[self setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
	
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
