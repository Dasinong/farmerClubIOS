//
//  CCampaignDetailHeaderTableViewCell.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/14.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CCampaignDetailHeaderTableViewCell.h"
#import "CCouponCampaign.h"

@interface CCampaignDetailHeaderTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *redeemLabel;
@end

@implementation CCampaignDetailHeaderTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setupWithModel:(id)model {
    CCouponCampaign *campaign = (CCouponCampaign*)model;
    
    self.descriptionLabel.text = campaign.campaignDescription;
    
    NSDate* redeemTimeStart = [NSDate dateWithTimeIntervalSince1970:campaign.redeemTimeStart / 1000];
    NSDate* redeemTimeEnd = [NSDate dateWithTimeIntervalSince1970:campaign.redeemTimeEnd / 1000];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MM月dd日"];
    
    if ([campaign isInsurance]) {
        self.redeemLabel.text = @"";
    }
    else {
        self.redeemLabel.text = [NSString stringWithFormat:@"兑换期限：%@ - %@", [df stringFromDate:redeemTimeStart], [df stringFromDate:redeemTimeEnd]];
    }
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

@end
