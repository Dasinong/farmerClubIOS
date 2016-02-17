//
//  CMyCouponDetailViewController.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/17.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CMyCouponDetailViewController.h"
//#import <ZXingObjC.h>

@interface CMyCouponDetailViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewWidthConstaints;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *campaignImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *claimLabel;
@property (weak, nonatomic) IBOutlet UIImageView *QRView;
@property (weak, nonatomic) IBOutlet UILabel *couponIdLabel;

@end

@implementation CMyCouponDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.scrollViewWidthConstaints.constant = SCREEN_WIDTH;
    
    
    if (self.coupon.campaign.pictureUrls.count > 0) {
        NSString *picUrlString = [NSString stringWithFormat:@"%@/pic/couponCampaign/%@", kServer, self.coupon.campaign.pictureUrls[0]];
        [self.campaignImageView sd_setImageWithURL:[NSURL URLWithString:picUrlString]];
    }
    
    self.nameLabel.text = self.coupon.campaign.name;
    self.amountLabel.text = [NSString stringWithFormat:@"￥%.2f", self.coupon.campaign.amount];

    NSDate* claimDate = [NSDate dateWithTimeIntervalSince1970:self.coupon.claimedAt / 1000];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"申领时间：MM月dd日"];
    
    self.claimLabel.text = [df stringFromDate:claimDate];
    
    self.couponIdLabel.text = [NSString stringWithFormat:@"券号：%d", (int)self.coupon.id];
    
     NSString *QRString = [NSString stringWithFormat:@"%@/pic/couponCampaign/QRCode/%d.png", kServer, (int)self.coupon.id];
    [self.QRView sd_setImageWithURL:[NSURL URLWithString:QRString]];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
