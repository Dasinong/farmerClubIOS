//
//  CCouponDetailViewController.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/14.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CCouponDetailViewController.h"
#import "CClaimCouponViewController.h"
#import "MJRefresh.h"
#import "CCouponCampaignDetailModel.h"
#import "CCouponTableViewCell.h"
#import "CCampaignDetailHeaderTableViewCell.h"
#import "CPictureTableViewCell.h"

@interface CCouponDetailViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *downloadedPictures;
@end

@implementation CCouponDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.downloadedPictures = [NSMutableDictionary dictionary];
    
    [self requestData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestData];
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CCampaignDetailHeaderTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"CCampaignDetailHeaderTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CPictureTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"CPictureTableViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)claim:(id)sender {
    CClaimCouponViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CClaimCouponViewController"];
    controller.hidesBottomBarWhenPushed = YES;
    controller.couponCampaign = self.couponCampaign;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)requestData {
    CCouponCampaignDetailParam *param = [CCouponCampaignDetailParam shared_];
    param.couponCampaignId = self.couponCampaign.id;
    [CCouponCampaignDetailModel requestWithParams:param completion:^(CCouponCampaignDetailModel *model, JSONModelError *err) {
        if (model && model.campaign) {
            self.couponCampaign = model.campaign;
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
            
            for (int i=0; i<self.couponCampaign.pictureUrls.count; i++) {
                __block NSString *pictureID = self.couponCampaign.pictureUrls[i];
                NSString *imageUrl = [NSString stringWithFormat:@"%@/pic/couponCampaign/%@",kServer,pictureID];
                
                SDWebImageManager *manager = [SDWebImageManager sharedManager];
                [manager downloadImageWithURL:[NSURL URLWithString:imageUrl]
                                      options:0
                                     progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                         // progression tracking code
                                     }
                                    completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                        if (image) {
                                            [self.downloadedPictures setObject:image forKey:pictureID];
                                            [self.tableView reloadData];
                                        }
                                    }];
                
            }
        }
    }];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 375;
    }
    else if(indexPath.row == 1) {
        return UITableViewAutomaticDimension;
    }
    else if(indexPath.row < 2 + self.couponCampaign.pictureUrls.count) {
        return UITableViewAutomaticDimension;
    }
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2 + self.couponCampaign.pictureUrls.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        CCouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        [cell setupWithModel:self.couponCampaign];
        return cell;
    }
    else if(indexPath.row == 1) {
        CCampaignDetailHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCampaignDetailHeaderTableViewCell" forIndexPath:indexPath];
        [cell setupWithModel:self.couponCampaign];
        return cell;
    }
    else if(indexPath.row < 2 + self.couponCampaign.pictureUrls.count) {
        CPictureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CPictureTableViewCell" forIndexPath:indexPath];
        
        NSString *pictureID = [self.couponCampaign.pictureUrls objectAtIndex_s:indexPath.row - 2];
        
        if (self.downloadedPictures[pictureID]) {
            [cell setupWithImage:self.downloadedPictures[pictureID]];
        }
        
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 300;
}
@end
