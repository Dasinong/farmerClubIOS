//
//  CBaseViewController.m
//  FarmNow
//
//  Created by zheliang on 15/10/16.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CBaseViewController.h"

@interface CBaseViewController ()

@end

@implementation CBaseViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
	[[self navigationItem] setBackBarButtonItem:backButton];
		self.automaticallyAdjustsScrollViewInsets = NO;
		self.edgesForExtendedLayout =  UIRectEdgeNone;

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
