//
//  CCouponTableViewCell.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/17.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CCouponTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CCoupon.h"

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
    CCoupon *coupon = (CCoupon *)model;
    
    if (coupon.campaign.pictureUrls.count > 0) {
        NSString *picUrlString = [NSString stringWithFormat:@"%@/pic/couponCampaign/%@", kServer, coupon.campaign.pictureUrls[0]];
        [self.couponImageView sd_setImageWithURL:[NSURL URLWithString:picUrlString]];
    }
    
    self.campaignNameLabel.text = coupon.campaign.name;
    
    NSDate* redeemTimeStart = [NSDate dateWithTimeIntervalSince1970:coupon.campaign.redeemTimeStart / 1000];
    NSDate* redeemTimeEnd = [NSDate dateWithTimeIntervalSince1970:coupon.campaign.redeemTimeEnd / 1000];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MM月dd日"];
    
    self.redeemTimeLabel.text = [NSString stringWithFormat:@"使用时间：%@ - %@", [df stringFromDate:redeemTimeStart], [df stringFromDate:redeemTimeEnd]];
}
@end
