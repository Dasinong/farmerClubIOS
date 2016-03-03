//
//  CCouponHomeViewController.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/14.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CCouponHomeViewController.h"
#import "CCouponDetailViewController.h"
#import "CClaimCouponViewController.h"
#import "CCouponCampaignTableViewCell.h"
#import "CCouponCampaign.h"
#import "CCouponCampaignsModel.h"
#import "CPersonalCache.h"
#import "MJRefresh.h"
#import "CMyCouponDetailViewController.h"

@interface CCouponHomeViewController () <UITableViewDataSource, UITableViewDelegate, CCouponCampaignTableViewCellDelegate, CClaimCouponViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation CCouponHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestData];
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CCouponCampaignTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"CCouponCampaignTableViewCell"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([CPersonalCache defaultPersonalCache].cacheUserInfo != nil) {
        [self requestData];
    }
    else {
        self.dataArray = nil;
        [self.tableView reloadData];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)requestData {
    CCouponCampaignsParam *param = [CCouponCampaignsParam new];
    
    [CCouponCampaignsModel requestWithParams:param completion:^(CCouponCampaignsModel *model, JSONModelError *err) {
        [self.tableView.mj_header endRefreshing];
        if (model && model.campaigns) {
            self.dataArray = model.campaigns;
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 465;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CCouponCampaign *couponCampaign = self.dataArray[indexPath.row];
    
    CCouponCampaignTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCouponCampaignTableViewCell" forIndexPath:indexPath];
    cell.delegate = self;
    [cell setupWithModel:couponCampaign];
    
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CCouponCampaign *couponCampaign = self.dataArray[indexPath.row];
    
    CCouponDetailViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CCouponDetailViewController"];
    controller.hidesBottomBarWhenPushed = YES;
    controller.couponCampaign = couponCampaign;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - CCouponCampaignTableViewCellDelegate
- (void)claim:(CCouponCampaign*)couponCampaign {
    CClaimCouponViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CClaimCouponViewController"];
    controller.hidesBottomBarWhenPushed = YES;
    controller.delegate = self;
    controller.couponCampaign = couponCampaign;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - CClaimCouponViewControllerDelegate
- (void)couponGet:(CCoupon *)coupon {
    CMyCouponDetailViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CMyCouponDetailViewController"];
    controller.hidesBottomBarWhenPushed = YES;
    controller.coupon = coupon;
    [self.navigationController pushViewController:controller animated:YES];
}
@end
