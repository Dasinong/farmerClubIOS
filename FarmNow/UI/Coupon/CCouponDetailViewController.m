//
//  CCouponDetailViewController.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/14.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CCouponDetailViewController.h"
#import "CCliamCouponViewController.h"

@interface CCouponDetailViewController ()

@end

@implementation CCouponDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)claim:(id)sender {
    CCliamCouponViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CCliamCouponViewController"];
    controller.hidesBottomBarWhenPushed = YES;
    controller.coupon = self.coupon;
    [self.navigationController pushViewController:controller animated:YES];
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
