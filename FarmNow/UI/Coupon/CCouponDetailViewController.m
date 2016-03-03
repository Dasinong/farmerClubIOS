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
#import "CCouponCampaignTableViewCell.h"
#import "CCampaignDetailHeaderTableViewCell.h"
#import "CStoreTableViewCell.h"
#import "CPictureTableViewCell.h"
#import "CStore.h"
#import "CMyCouponDetailViewController.h"

@interface CCouponDetailViewController () <UITableViewDataSource, UITableViewDelegate, CClaimCouponViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *downloadedPictures;
@property (nonatomic, strong) NSMutableDictionary *storeDict;
@end

@implementation CCouponDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.downloadedPictures = [NSMutableDictionary dictionary];
    self.title = self.couponCampaign.name;
    
    [self requestData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestData];
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CStoreTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"CStoreTableViewCell"];
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
    controller.delegate = self;
    controller.couponCampaign = self.couponCampaign;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)groupStoreWithProvince {
    self.storeDict = [NSMutableDictionary dictionary];
    
    for (CStore *store in self.couponCampaign.stores) {
        if(self.storeDict[store.province]) {
            NSMutableArray *stores = self.storeDict[store.province];
            [stores addObject:store];
        }
        else {
            NSMutableArray *stores = [NSMutableArray array];
            [stores addObject:store];
            [self.storeDict setObject:stores forKey:store.province];
        }
    }
}

// 返回key或者store
- (id)getStoreOrKeyInRow:(NSInteger)row {
    
    //for (int i=0; i<self.storeDict.allKeys.count; i++) {
    // NSString *key = self.storeDict.allKeys[i];
    for (NSString *key in self.storeDict.allKeys) {
        
        if (row == 0) {
            return key;
        }
        
        row--;
        NSArray *stores = self.storeDict[key];
        if (row < stores.count) {
            return stores[row];
        }
        
        row -= stores.count;
    }
    
    return nil;
}

- (void)requestData {
    CCouponCampaignDetailParam *param = [CCouponCampaignDetailParam shared_];
    param.couponCampaignId = self.couponCampaign.id;
    param.lat = gLatitude;
    param.lon = gLongitude;
    
    [CCouponCampaignDetailModel requestWithParams:param completion:^(CCouponCampaignDetailModel *model, JSONModelError *err) {
        if (model && model.campaign) {
            self.couponCampaign = model.campaign;
            [self groupStoreWithProvince];
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
    else {
        NSInteger newRow = indexPath.row - (2 + self.couponCampaign.pictureUrls.count);
        
        if (newRow == 0) {
            return 45;
        }
        
        id keyOrStore = [self getStoreOrKeyInRow:newRow-1];
        if ([keyOrStore isKindOfClass:[NSString class]]) {
            return 33;
        }
        else {
            return UITableViewAutomaticDimension;
        }
    }
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger storeRowCount = 0;
    for (NSString *key in self.storeDict.allKeys) {
        storeRowCount++;
        
        NSArray *stores = self.storeDict[key];
        storeRowCount += stores.count;
    }
    
    return 3 + self.couponCampaign.pictureUrls.count + storeRowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        CCouponCampaignTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
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
    else {
        NSInteger newRow = indexPath.row - (2 + self.couponCampaign.pictureUrls.count);
        
        if (newRow == 0) {
            return [tableView dequeueReusableCellWithIdentifier:@"RedeemCell" forIndexPath:indexPath];
        }
        
        id keyOrStore = [self getStoreOrKeyInRow:newRow-1];
        if ([keyOrStore isKindOfClass:[NSString class]]) {
            UITableViewCell *locationCell = [tableView dequeueReusableCellWithIdentifier:@"LocationCell" forIndexPath:indexPath];
            
            UILabel *locationLabel = (UILabel *)[locationCell.contentView viewWithTag:1];
            locationLabel.text = (NSString*)keyOrStore;
            return locationCell;
        }
        else {
            CStoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CStoreTableViewCell" forIndexPath:indexPath];
            [cell setupWithModel:keyOrStore];
            return cell;
        }
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 300;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row > 3 + self.couponCampaign.pictureUrls.count) {
        NSInteger newRow = indexPath.row - (3 + self.couponCampaign.pictureUrls.count);
        
        id keyOrStore = [self getStoreOrKeyInRow:newRow];
        
        if ([keyOrStore isKindOfClass:[CStore class]]) {
            CStore *store = (CStore*)keyOrStore;
            
            if (store.phone.length > 0) {
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"联系商家" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
                
                [alertController addAction:[UIAlertAction actionWithTitle:store.phone style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    NSString *phoneNum = [NSString stringWithFormat:@"tel://%@" , store.phone];
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNum]];
                }]];
                
                if (store.cellphone.length > 0) {
                    [alertController addAction:[UIAlertAction actionWithTitle:store.cellphone style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        NSString *phoneNum = [NSString stringWithFormat:@"tel://%@" , store.cellphone];
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNum]];
                    }]];
                }
                
                [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
        }
    }
}

#pragma mark - CClaimCouponViewControllerDelegate
- (void)couponGet:(CCoupon *)coupon {
    CMyCouponDetailViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CMyCouponDetailViewController"];
    controller.hidesBottomBarWhenPushed = YES;
    controller.coupon = coupon;
    [self.navigationController pushViewController:controller animated:YES];
}
@end
