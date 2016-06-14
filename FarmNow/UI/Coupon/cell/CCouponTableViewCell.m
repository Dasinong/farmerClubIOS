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
        
        if ([couponCampaign isInsurance]) {
            self.redeemTimeLabel.text = @"";
        }
        else {
            self.redeemTimeLabel.text = [NSString stringWithFormat:@"使用时间：%@ - %@", [df stringFromDate:redeemTimeStart], [df stringFromDate:redeemTimeEnd]];
        }
    }
}
@end
