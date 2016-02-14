//
//  CCouponHomeViewController.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/14.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CCouponHomeViewController.h"
#import "CCouponDetailViewController.h"
#import "CCliamCouponViewController.h"
#import "CCouponTableViewCell.h"
#import "CCoupon.h"

@interface CCouponHomeViewController () <UITableViewDataSource, UITableViewDelegate, CCouponTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation CCouponHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

#pragma mark - UITableViewDataSource && UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 430;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //CCoupon *coupon = self.dataArray[indexPath.row];
    
    CCouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.delegate = self;
    [cell setupWithModel:[[CCoupon alloc] init]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //CCoupon *coupon = self.dataArray[indexPath.row];
    
    CCouponDetailViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CCouponDetailViewController"];
    controller.hidesBottomBarWhenPushed = YES;
    controller.coupon = nil;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - CCouponTableViewCellDelegate
- (void)claim:(CCoupon*)coupon {
    CCliamCouponViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CCliamCouponViewController"];
    controller.hidesBottomBarWhenPushed = YES;
    controller.coupon = coupon;
    [self.navigationController pushViewController:controller animated:YES];
}
@end
