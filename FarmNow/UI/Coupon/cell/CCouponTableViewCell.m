//
//  CCouponTableViewCell.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/17.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CCouponTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CCouponCampaign.h"

@interface CCouponTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *couponImageView;
@property (weak, nonatomic) IBOutlet UILabel *campaignNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *redeemTimeLabel;
@end

@implementation CCouponTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupWithModel:(id)model {
    CCouponCampaign *couponCampaign = (CCouponCampaign *)model;
    
    if (couponCampaign.pictureUrls.count > 0) {
        NSString *picUrlString = [NSString stringWithFormat:@"%@/pic/couponCampaign/%@", kServer, couponCampaign.pictureUrls[0]];
        [self.couponImageView sd_setImageWithURL:[NSURL URLWithString:picUrlString]];
    }
    
    self.campaignNameLabel.text = couponCampaign.name;
    
    if (couponCampaign.redeemTimeStart > 0 && couponCampaign.redeemTimeEnd > 0) {
        NSDate* redeemTimeStart = [NSDate dateWithTimeIntervalSince1970:couponCampaign.redeemTimeStart / 1000];
        NSDate* redeemTimeEnd = [NSDate dateWithTimeIntervalSince1970:couponCampaign.redeemTimeEnd / 1000];
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"MM月dd日"];
        
        if ([couponCampaign isInsurance] || couponCampaign.id==38 || couponCampaign.id == 40) {
//            self.redeemTimeLabel.text = @"";
            self.redeemTimeLabel.text = [NSString stringWithFormat:@"兑换时间：12月7日-13日、12月14日-20日"];

            
        }
        else {
            self.redeemTimeLabel.text = [NSString stringWithFormat:@"使用时间：%@ - %@", [df stringFromDate:redeemTimeStart], [df stringFromDate:redeemTimeEnd]];
        }
    }
}

- (void)setupWithCoupon:(CCoupon *)coupon {
    [self setupWithModel:coupon.campaign];
    if ([coupon isInsurance] && coupon.redeemedAt > 0) { //已完成
        NSDate* redeemedAt = [NSDate dateWithTimeIntervalSince1970:coupon.redeemedAt / 1000];
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"MM月dd日"];
        self.redeemTimeLabel.text = [NSString stringWithFormat:@"扫描日期：%@", [df stringFromDate:redeemedAt]];
    }
}
@end
