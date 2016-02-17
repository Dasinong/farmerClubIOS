//
//  CMyCouponPagerViewController.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/14.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CMyCouponPagerViewController.h"
#import "CCouponListViewController.h"

@interface CMyCouponPagerViewController ()

@end

@implementation CMyCouponPagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.buttonBarView.shouldCellsFillAvailableWidth = YES;
    self.isProgressiveIndicator = NO;
    self.isElasticIndicatorLimit = YES;
    self.buttonBarView.selectedBar.backgroundColor = [UIColor colorwithHexString:@"#2bad29"];
    [self.buttonBarView setSelectedBarHeight:2.0];
    [self.buttonBarView setSelectedBarAlignment:XLSelectedBarAlignmentCenter];
    self.buttonBarView.backgroundColor = [UIColor colorwithHexString:@"#f7fcff"];
    
    UICollectionViewFlowLayout *flowlayout = (UICollectionViewFlowLayout *)self.buttonBarView.collectionViewLayout;
    flowlayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    UIView *seperator = [[UIView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 1)];
    [seperator setBackgroundColor:[UIColor colorwithHexString:@"#dbe3e5"]];
    [self.view addSubview:seperator];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
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


#pragma mark - XLPagerTabStripViewControllerDataSource

-(NSArray *)childViewControllersForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    // create child view controllers that will be managed by XLPagerTabStripViewController
    CCouponListViewController * child_1 = [self.storyboard instantiateViewControllerWithIdentifier:@"CCouponListViewController"];
    child_1.type = CouponTypeMyUnused;
    
    CCouponListViewController * child_2 = [self.storyboard instantiateViewControllerWithIdentifier:@"CCouponListViewController"];
    child_2.type = CouponTypeMyExpired;
    
    return @[child_1, child_2];
}
@end
