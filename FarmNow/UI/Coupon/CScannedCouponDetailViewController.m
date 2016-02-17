//
//  CScannedCouponDetailViewController.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/17.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CScannedCouponDetailViewController.h"
#import "CCouponTableViewCell.h"
#import "CScannedCouponsModel.h"
#import "MJRefresh.h"

@interface CScannedCouponDetailViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *dataArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation CScannedCouponDetailViewController

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
    CScannedCouponsParam *params = [CScannedCouponsParam new];
    params.campaignId = self.couponCampaign.id;
    
    [CScannedCouponsModel requestWithParams:GET params:params completion:^(CScannedCouponsModel *model, JSONModelError *err) {
        if (model) {
            self.dataArray = model.coupons;
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
    if (indexPath.row == 0) {
        return 105;
    }
    if (indexPath.row == 1) {
        return 86;
    }
    if (indexPath.row == 2) {
        return 35;
    }
    
    return 45;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3 + self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        CCouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCouponTableViewCell" forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setupWithModel:self.couponCampaign];
        return cell;
    }
    
    if (indexPath.row == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OverallCell" forIndexPath:indexPath];
        
        UILabel *countLabel = (UILabel*)[cell.contentView viewWithTag:1];
        countLabel.text = [NSString stringWithFormat:@"%d", (int)self.dataArray.count];
        
        UILabel *amountLabel = (UILabel*)[cell.contentView viewWithTag:2];
        float amount = 0;
        for (CCoupon *coupon in self.dataArray) {
            amount += coupon.amount;
        }
        amountLabel.text = [NSString stringWithFormat:@"￥%.2f", amount];
        
        return cell;
    }
    
    if (indexPath.row == 2) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecordHeaderCell" forIndexPath:indexPath];
        return cell;
    }
    else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecordCell" forIndexPath:indexPath];
        
        CCoupon *coupon = self.dataArray[indexPath.row - 3];
        
        UILabel *dateLabel = (UILabel*)[cell.contentView viewWithTag:1];
        NSDate *redeemedAt = [NSDate dateWithTimeIntervalSince1970:coupon.redeemedAt / 1000];
        NSDateFormatter *df = [NSDateFormatter new];
        [df setDateFormat:@"YYYY.MM.dd"];
        dateLabel.text = [df stringFromDate:redeemedAt];
        
        UILabel *cellLabel = (UILabel*)[cell.contentView viewWithTag:2];
        if (coupon.claimerCell.length < 4) {
            cellLabel.text = coupon.claimerCell;
        }
        else {
            cellLabel.text = [coupon.claimerCell substringFromIndex:coupon.claimerCell.length - 4];
        }
        
        UILabel *idLabel = (UILabel*)[cell.contentView viewWithTag:3];
        idLabel.text = [NSString stringWithFormat:@"%d", (int)coupon.id];
        
        return cell;
    }
}
@end
