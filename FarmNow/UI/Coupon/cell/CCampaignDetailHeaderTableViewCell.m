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
@end

@implementation CCampaignDetailHeaderTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setupWithModel:(id)model {
    CCouponCampaign *campaign = (CCouponCampaign*)model;
    
    self.descriptionLabel.text = campaign.campaignDescription;
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

@end
