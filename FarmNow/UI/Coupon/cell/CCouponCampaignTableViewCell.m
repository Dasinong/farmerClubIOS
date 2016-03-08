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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *amountLabelHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeightConstraint;
@end

@implementation CCouponCampaignTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setupWithModel:(id)model {
    self.couponCampaign = model;
    
    if (self.couponCampaign.institution && self.couponCampaign.institution[@"name"]) {
        self.titleLabel.text = [NSString stringWithFormat:@"%@活动", self.couponCampaign.institution[@"name"]];
    }
    else {
        self.titleLabel.text = self.couponCampaign.name;
    }
    
    if (self.couponCampaign.amount == 0) {
        self.amountLabel.text = @"";
        
        self.amountLabelHeightConstraint.constant = 0.1;
    }
    else {
       self.amountLabel.text = [NSString stringWithFormat:@"￥%.2f", self.couponCampaign.amount];
        self.amountLabelHeightConstraint.constant = 20;
    }
    
    if (self.couponCampaign.pictureUrls.count > 0) {
        NSString *picUrlString = [NSString stringWithFormat:@"%@/pic/couponCampaign/%@", kServer, self.couponCampaign.pictureUrls[0]];
        [self.campaignImageView sd_setImageWithURL:[NSURL URLWithString:picUrlString]];
    }
    
    NSDate* claimTimeStart = [NSDate dateWithTimeIntervalSince1970:self.couponCampaign.claimTimeStart / 1000];
    NSDate* claimTimeEnd = [NSDate dateWithTimeIntervalSince1970:self.couponCampaign.claimTimeEnd / 1000];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MM月dd日"];
    
    self.claimLabel.text = [NSString stringWithFormat:@"申领时间：%@ - %@", [df stringFromDate:claimTimeStart], [df stringFromDate:claimTimeEnd]];
    
    if (self.isDetail) {
        self.imageHeightConstraint.constant = 250;
    }
    else {
        self.imageHeightConstraint.constant = 120;
    }
}

- (IBAction)claim:(id)sender {
    if (self.couponCampaign && [self.delegate respondsToSelector:@selector(claim:)]) {
        [self.delegate claim:self.couponCampaign];
    }
}
@end
