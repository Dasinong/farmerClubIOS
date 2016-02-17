//
//  CMyStoreViewController.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/17.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CMyStoreViewController.h"
#import "CScannableCampaignsModel.h"
#import "MJRefresh.h"
#import "CCouponTableViewCell.h"
#import "CScannedCouponDetailViewController.h"

@interface CMyStoreViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation CMyStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CCouponTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"CCouponTableViewCell"];
    
    [self requestData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestData {
    CScannableCampaignsParam *params = [CScannableCampaignsParam new];
    
    [CScannableCampaignsModel requestWithParams:GET params:params completion:^(CScannableCampaignsModel *model, JSONModelError *err) {
        if (model) {
            self.dataArray = model.campaigns;
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 105;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CCouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCouponTableViewCell" forIndexPath:indexPath];
    
    CCouponCampaign *couponCampaign = self.dataArray[indexPath.row];
    [cell setupWithModel:couponCampaign];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CCouponCampaign *couponCampaign = self.dataArray[indexPath.row];
    
    CScannedCouponDetailViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CScannedCouponDetailViewController"];
    controller.couponCampaign = couponCampaign;
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}
@end
