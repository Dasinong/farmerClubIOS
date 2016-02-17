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

@interface CCouponHomeViewController () <UITableViewDataSource, UITableViewDelegate, CCouponCampaignTableViewCellDelegate>
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self requestData];
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
    
    if ([CPersonalCache defaultPersonalCache].cacheUserInfo != nil) {
        CCouponCampaignsParam *param = [CCouponCampaignsParam new];
        
        [CCouponCampaignsModel requestWithParams:param completion:^(CCouponCampaignsModel *model, JSONModelError *err) {
            if (model && model.campaigns) {
                self.dataArray = model.campaigns;
                [self.tableView.mj_header endRefreshing];
                [self.tableView reloadData];
            }
        }];
    }
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 465;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CCouponCampaign *couponCampaign = self.dataArray[indexPath.row];
    
    CCouponCampaignTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.delegate = self;
    [cell setupWithModel:couponCampaign];
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
    controller.couponCampaign = couponCampaign;
    [self.navigationController pushViewController:controller animated:YES];
}
@end
