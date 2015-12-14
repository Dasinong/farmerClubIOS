//
//  CRecommendController.m
//  FarmNow
//
//  Created by zheliang on 15/10/24.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CRecommendController.h"
#import <HMSegmentedControl/HMSegmentedControl.h>

@interface CRecommendController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet HMSegmentedControl *segement;

@property (retain, nonatomic) UIViewController* currentViewController;

@end

@implementation CRecommendController

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.title = @"有奖推荐";
	NSArray* titles = @[@"推荐人", @"被推荐人"];
	
	//	DZNSegmentedControl *control = [[DZNSegmentedControl alloc] initWithItems:items];
	[self.segement setSectionTitles:titles];
	self.segement.selectionIndicatorColor = COLOR(0x2C9F27);
	self.segement.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
	self.segement.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleFixed;
	self.segement.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
	//	self.segement.delegate = self;
	UIViewController *vc = [self viewControllerForSegmentIndex:self.segement.selectedSegmentIndex];
	[self addChildViewController:vc];
	vc.view.frame = self.contentView.bounds;
	[self.contentView addSubview:vc.view];
	self.currentViewController = vc;
	
	self.segement.selectedSegmentIndex = 0;
	[self selectedSegment:self.segement];
	[self.segement addTarget:self action:@selector(selectedSegment:) forControlEvents:UIControlEventValueChanged];
	


}

- (UIViewController *)viewControllerForSegmentIndex:(NSInteger)index {
	UIViewController *vc = nil;
	switch (index) {
		case 0:
			vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CRecommendController1"];
			

			
			break;
		case 1:
			vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CRecommendController2"];

			
			break;
	}
	return vc;
}
- (void)selectedSegment:(id)sender {
	UIViewAnimationOptions options = UIViewAnimationOptionTransitionFlipFromRight;

	UIViewController *vc = [self viewControllerForSegmentIndex:self.segement.selectedSegmentIndex];
	[self addChildViewController:vc];
	vc.view.frame = self.contentView.bounds;
	
	self.segement.userInteractionEnabled = NO;
	[self transitionFromViewController:self.currentViewController
					  toViewController:vc duration:0.5
							   options:options animations:^{
								   [self.currentViewController.view removeFromSuperview];
								   [self.contentView addSubview:vc.view];
							   } completion:^(BOOL finished) {
								   self.segement.userInteractionEnabled = YES;
								   [vc didMoveToParentViewController:self];
								   [self.currentViewController removeFromParentViewController];
								   self.currentViewController = vc;
							   }];
	self.navigationItem.title = vc.title;
}
@end
