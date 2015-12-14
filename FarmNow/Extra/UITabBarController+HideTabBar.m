//
//  UITabBarController+HideTabBar.m
//  FarmNow
//
//  Created by zheliang on 15/10/29.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "UITabBarController+HideTabBar.h"
#define kAnimationDuration .3

CGRect tmpRect;
@implementation UITabBarController (HideTabBar)


- (BOOL)isTabBarHidden {
	CGRect viewFrame = self.view.frame;
	CGRect tabBarFrame = self.tabBar.frame;
	return tabBarFrame.origin.y >= viewFrame.size.height;
}

- (void)setTabBarFrame
{
	CGRect tabBarFrame = self.tabBar.frame;
	tabBarFrame.origin.y = self.view.frame.size.height - tabBarFrame.size.height;
}


- (void)setTabBarHidden:(BOOL)hidden{
	[self setTabBarHidden:hidden animated:NO completion:nil];
}


- (void)setTabBarHidden:(BOOL)hidden animated:(BOOL)animated completion:(void(^)( BOOL finished)) completion
{
	BOOL isHidden = self.tabBarHidden;
	UIView *transitionView = [[[self.view.subviews reverseObjectEnumerator] allObjects] lastObject];
	if(hidden == isHidden){
		transitionView.frame = tmpRect;
		return;
	}
	
	if(transitionView == nil) {
		NSLog(@"could not get the container view!");
		return;
	}
	
	
	CGRect viewFrame = self.view.frame;
	CGRect tabBarFrame = self.tabBar.frame;
	CGRect containerFrame = transitionView.frame;
	
	tabBarFrame.origin.y = viewFrame.size.height - (hidden ? 0 : tabBarFrame.size.height);
	containerFrame.size.height = viewFrame.size.height - (hidden ? 0 : tabBarFrame.size.height);
	tmpRect = containerFrame;
	[UIView animateWithDuration:kAnimationDuration
					 animations:^{
						 self.tabBar.frame = tabBarFrame;
						 transitionView.frame = containerFrame;
					 } completion:^(BOOL finished) {
						 if (completion) {
							 completion(finished);

						 }
					 }
	 ];
}
@end
