//
//  CCouponListViewController.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/17.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CCouponListViewController.h"
#import "CCouponTableViewCell.h"
#import "MJRefresh.h"
#import "CCouponModel.h"
#import "CMyCouponDetailViewController.h"

extern CLLocationDegrees gLatitude;
extern CLLocationDegrees gLongitude;

@interface CCouponListViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation CCouponListViewController

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
    CCouponParam *params = [CCouponParam new];
    params.lat = gLatitude;
    params.lon = gLongitude;
    
    [CCouponModel requestWithParams:GET params:params completion:^(CCouponModel *model, JSONModelError *err) {
        if (model) {
            NSMutableArray *array = [NSMutableArray array];
            
            for (CCoupon *coupon in model.coupons) {
                if (self.type == CouponTypeMyUnused) {
                    if (![coupon expired]) {
                        [array addObject:coupon];
                    }
                }
                else if (self.type == CouponTypeMyExpired) {
                    if ([coupon expired]) {
                        [array addObject:coupon];
                    }
                }
                else {
                    [array addObject:coupon];
                }
            }
            
            self.dataArray = array;
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

#pragma mark - XLPagerTabStripViewControllerDelegate

-(NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    switch (self.type) {
        case CouponTypeMyUnused:
            return @"未使用";
        case CouponTypeMyExpired:
            return @"已失效";
            
        default:
            return @"";
            break;
    }
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 105;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CCouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCouponTableViewCell" forIndexPath:indexPath];
    
    CCoupon *coupon = self.dataArray[indexPath.row];
    [cell setupWithModel:coupon.campaign];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CCoupon *coupon = self.dataArray[indexPath.row];
    
    CMyCouponDetailViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CMyCouponDetailViewController"];
    controller.coupon = coupon;
    [self.navigationController pushViewController:controller animated:YES];
}
@end
