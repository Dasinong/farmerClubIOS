//
//  CCouponCampaignTableViewCell.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/14.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CCouponCampaignTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface CCouponCampaignTableViewCell ()
@property (nonatomic,strong) CCouponCampaign *couponCampaign;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *campaignImageView;
@property (weak, nonatomic) IBOutlet UILabel *claimLabel;
@end

@implementation CCouponCampaignTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setupWithModel:(id)model {
    self.couponCampaign = model;
    
    self.titleLabel.text = self.couponCampaign.name;
    self.amountLabel.text = [NSString stringWithFormat:@"￥%.2f", self.couponCampaign.amount];
    
    if (self.couponCampaign.pictureUrls.count > 0) {
        NSString *picUrlString = [NSString stringWithFormat:@"%@/pic/couponCampaign/%@", kServer, self.couponCampaign.pictureUrls[0]];
        [self.campaignImageView sd_setImageWithURL:[NSURL URLWithString:picUrlString]];
    }
    
    NSDate* claimTimeStart = [NSDate dateWithTimeIntervalSince1970:self.couponCampaign.claimTimeStart / 1000];
    NSDate* claimTimeEnd = [NSDate dateWithTimeIntervalSince1970:self.couponCampaign.claimTimeEnd / 1000];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MM月dd日"];
    
    self.claimLabel.text = [NSString stringWithFormat:@"申领时间：%@ - %@", [df stringFromDate:claimTimeStart], [df stringFromDate:claimTimeEnd]];
}

- (IBAction)claim:(id)sender {
    if (self.couponCampaign && [self.delegate respondsToSelector:@selector(claim:)]) {
        [self.delegate claim:self.couponCampaign];
    }
}
@end
