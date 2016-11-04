//
//  CCouponCampaignTableViewCell.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/14.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CCouponCampaignTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

#import "CCoupon.h"

@interface CCouponCampaignTableViewCell ()
@property (nonatomic,strong) CCouponCampaign *couponCampaign;
@property (nonatomic,strong) CCoupon *coupon;
//@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *claimLabelHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *claimLabelTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *claimLabelBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *campaignTitleHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *campaignTitleTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *campaignTitleBottomConstraint;
@property (weak, nonatomic) IBOutlet UILabel *claimLabel;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *amountLabelHeightConstraint;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeightConstraint;


@property (weak, nonatomic) IBOutlet UIImageView *campaignImageView;
@property (weak, nonatomic) IBOutlet UIView *seperatorView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *seperatorViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *campaignTitleLabel;
@end

@implementation CCouponCampaignTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setupWithModel:(id)model {
    
    if ([model isKindOfClass:[CCouponCampaign class]]) {
        self.couponCampaign = model;
    }
    else {
        self.coupon = model;
        self.couponCampaign = self.coupon.campaign;
    }
    
    self.campaignTitleLabel.text = self.couponCampaign.name;
    
    
//    if (self.couponCampaign.institution && self.couponCampaign.institution[@"name"]) {
//        self.titleLabel.text = [NSString stringWithFormat:@"%@活动", self.couponCampaign.institution[@"name"]];
//    }
//    else {
//        self.titleLabel.text = self.couponCampaign.name;
//    }
//    
//    if (self.couponCampaign.amount == 0) {
//        self.amountLabel.text = @"";
//        
//        self.amountLabelHeightConstraint.constant = 0.1;
//    }
//    else {
//       self.amountLabel.text = [NSString stringWithFormat:@"￥%.2f", self.couponCampaign.amount];
//        self.amountLabelHeightConstraint.constant = 20;
//    }
    
    if (self.couponCampaign.pictureUrls.count > 0) {
        NSString *picUrlString = [NSString stringWithFormat:@"%@/pic/couponCampaign/%@", kServer, self.couponCampaign.pictureUrls[0]];
        [self.campaignImageView sd_setImageWithURL:[NSURL URLWithString:picUrlString]];
    }
    
   
    
    if (self.isDetail) {
        self.seperatorView.backgroundColor = [UIColor whiteColor];
        self.seperatorViewHeightConstraint.constant = 0.1;
    }
    else {
        self.campaignTitleHeightConstraint.constant = 0;
        self.campaignTitleTopConstraint.constant = 0;
        self.campaignTitleBottomConstraint.constant = 0;
        self.claimLabelHeightConstraint.constant = 0;
        self.claimLabelBottomConstraint.constant = 0;
        self.claimLabelTopConstraint.constant = 0;
    }
    
    if (self.coupon) {
        NSDate* claimedAt = [NSDate dateWithTimeIntervalSince1970:self.coupon.claimedAt / 1000];
        
        NSDate* timeStart;
        NSDate* timeEnd;
        
        BOOL isDaren = NO;
        if ([USER_DEFAULTS objectForKey:@"clientConfig"]) {
            NSDictionary *clientConfig = [USER_DEFAULTS objectForKey:@"clientConfig"];
            if (clientConfig[@"isDaren"]) {
                if ([clientConfig[@"isDaren"] boolValue]) {
                    isDaren = YES;
                }
            }
        }
        
        if (isDaren) {
            timeStart = [claimedAt dateByAddingDays:10];
        }
        else {
            timeStart = claimedAt;
        }
        timeEnd = [claimedAt dateByAddingDays:30];
        if (self.coupon.campaignId == 38 || self.coupon.campaignId == 40)
        {
            timeEnd =[NSDate dateWithTimeIntervalSince1970:self.coupon.campaign.redeemTimeEnd / 1000];
        }
        
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"MM月dd日"];
        
        if ([self.coupon isInsurance]) {
            self.claimLabel.text = [NSString stringWithFormat:@"你购买了：%@", self.coupon.comment];
        }
        else {
            self.claimLabel.text = [NSString stringWithFormat:@"兑换日期：%@ - %@", [df stringFromDate:timeStart], [df stringFromDate:timeEnd]];
        }
    }
    else {
        NSDate* claimTimeStart = [NSDate dateWithTimeIntervalSince1970:self.couponCampaign.claimTimeStart / 1000];
        NSDate* claimTimeEnd = [NSDate dateWithTimeIntervalSince1970:self.couponCampaign.claimTimeEnd / 1000];
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"MM月dd日"];
        
        NSString *text = @"申领时间";
        if ([self.couponCampaign isInsurance]) {
            text = @"活动时间";
        }
        
        self.claimLabel.text = [NSString stringWithFormat:@"%@：%@ - %@", text, [df stringFromDate:claimTimeStart], [df stringFromDate:claimTimeEnd]];
    }
//
//    if (self.isDetail) {
//        self.imageHeightConstraint.constant = 250;
//        
//    }
//    else {
//        self.imageHeightConstraint.constant = 120;
//    }
}

- (IBAction)claim:(id)sender {
    if (self.couponCampaign && [self.delegate respondsToSelector:@selector(claim:)]) {
        [self.delegate claim:self.couponCampaign];
    }
}
@end
