//
//  CMyCouponDetailViewController.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/17.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CMyCouponDetailViewController.h"
#import "CCouponCampaignTableViewCell.h"
#import "CStoreTableViewCell.h"

@interface CMyCouponDetailViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *storeDict;

//@property (weak, nonatomic) IBOutlet UILabel *couponIdLabel;
//@property (weak, nonatomic) IBOutlet UIImageView *QRView;

@end

@implementation CMyCouponDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CCouponCampaignTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"CCouponCampaignTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CStoreTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"CStoreTableViewCell"];
    
    [self groupStoreWithProvince];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    // 二维码
//    NSError *error = nil;
//    
//    ZXEncodeHints *hints = [ZXEncodeHints hints];
//    hints.encoding = NSUTF8StringEncoding;
//    ZXMultiFormatWriter *writer = [ZXMultiFormatWriter writer];
//    NSString *string = [NSString stringWithFormat:@"http://www.cloudfds.com?action=invite2fa&fid=%@&fname=%@" , @"1" , @"2"];
//    
//    ZXBitMatrix* result = [writer encode:string format:kBarcodeFormatQRCode width:self.QRView.width height:self.QRView.height hints:hints error:&error];
//    // 设置编码类型 hints.errorCorrectionLevel = [ZXErrorCorrectionLevel
//    
//    if (result) {
//        CGImageRef image = [[ZXImage imageWithMatrix:result] cgimage];
//        self.QRView.image =  [UIImage imageWithCGImage: image];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)groupStoreWithProvince {
    self.storeDict = [NSMutableDictionary dictionary];
    
    for (CStore *store in self.coupon.campaign.stores) {
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if ([self.coupon isInsurance]) {
        return 2;
    }
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return SCREEN_WIDTH / 640.0 * 480.0 + 46;
    }
    else if (indexPath.section == 1) {
        return 280;
    }
    else if (indexPath.section == 2) {
        return 33;
    }
    else {
        id keyOrStore = [self getStoreOrKeyInRow:indexPath.row];
        if ([keyOrStore isKindOfClass:[NSString class]]) {
            return 33;
        }
        else {
            return UITableViewAutomaticDimension;
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 3) {
        NSInteger storeRowCount = 0;
        for (NSString *key in self.storeDict.allKeys) {
            storeRowCount++;
            
            NSArray *stores = self.storeDict[key];
            storeRowCount += stores.count;
        }
        
        return storeRowCount;
    }
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 400;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CCouponCampaignTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CCouponCampaignTableViewCell" forIndexPath:indexPath];
        cell.isDetail = YES;
        [cell setupWithModel:self.coupon];
        
        [cell setNeedsLayout];
        [cell layoutIfNeeded];

        return cell;
    }
    else if (indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QRCell" forIndexPath:indexPath];
        
        UIImageView *QRView = (UIImageView *)[cell.contentView viewWithTag:1];
        UILabel *couponIdLabel = (UILabel *)[cell.contentView viewWithTag:2];
        
        NSString *QRString = [NSString stringWithFormat:@"%@/pic/couponCampaign/QRCode/%d.png", kServer, (int)self.coupon.id];
        [QRView sd_setImageWithURL:[NSURL URLWithString:QRString]];
        
        couponIdLabel.text = [NSString stringWithFormat:@"券号：%d", (int)self.coupon.id];
        
        return cell;
    }
    else if (indexPath.section == 2) {
        return [tableView dequeueReusableCellWithIdentifier:@"RedeemCell" forIndexPath:indexPath];
    }
    else {
        id keyOrStore = [self getStoreOrKeyInRow:indexPath.row];
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
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
