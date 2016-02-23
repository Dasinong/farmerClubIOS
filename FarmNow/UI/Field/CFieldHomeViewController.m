//
//  CFieldHomeViewController.m
//  FarmNow
//
//  Created by 曦炽 朱 on 16/1/26.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CFieldHomeViewController.h"
#import "MJRefresh.h"
#import "CCropSubscriptionsModel.h"
#import "CAddCropViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CAddWeatherFirstViewController.h"
#import "CCropDetailViewController.h"

@interface CFieldHomeViewController () <UITableViewDataSource, UITableViewDelegate, CAddCropViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation CFieldHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestData];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(signoutNotification:) name:@"notification_signout" object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.dataArray.count == 0) {
        [self requestData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)signoutNotification:(NSNotification *)notification {
    self.dataArray = nil;
}

- (void)requestData {
    CCropSubscriptionsParam *param = [CCropSubscriptionsParam new];
    [CCropSubscriptionsModel requestWithParams:param completion:^(CCropSubscriptionsModel *model, JSONModelError *err) {
        [self.tableView.mj_header endRefreshing];
        if (model && model.subscriptions) {
            self.dataArray = model.subscriptions;
            [self.tableView reloadData];
        }
    }];
}

- (IBAction)addCorp:(id)sender {
    CAddCropViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CAddCropViewController"];
    controller.delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)goToDetail {
    CCropDetailViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CCropDetailViewController"];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    CCropSubscription *subscription = self.dataArray[indexPath.row];
    
    UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:1];
    UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:2];
    UILabel *countLabel = (UILabel *)[cell.contentView viewWithTag:3];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:subscription.crop.iconUrl]];
    titleLabel.text = subscription.crop.cropName;
    if (subscription.fields.count == 0) {
        countLabel.text = @"未种植";
    }
    else {
        countLabel.text = [NSString stringWithFormat:@"%d块田", (int)subscription.fields.count];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CCropSubscription *subscription = self.dataArray[indexPath.row];
    if (subscription.fields.count == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"正在种植" message:@"加田后能收到更多针对这块田的种植指导哦！" preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"暂时没种" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self goToDetail];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"马上加田" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            CAddWeatherFirstViewController* controller = [self.storyboard controllerWithID:@"CAddWeatherFirstViewController"];
            controller.type = eFarm;
            [self.navigationController pushViewController:controller animated:YES];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else {
        [self goToDetail];
    }
}

#pragma mark - CAddCropViewControllerDelegate
- (void)addCropCompelted {
    [self requestData];
}
@end
