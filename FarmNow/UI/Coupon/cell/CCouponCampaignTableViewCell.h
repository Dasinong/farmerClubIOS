//
//  CCouponCampaignTableViewCell.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/14.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCouponCampaign.h"

@protocol CCouponCampaignTableViewCellDelegate <NSObject>
- (void)claim:(CCouponCampaign*)couponCampaign;
@end

@interface CCouponCampaignTableViewCell : UITableViewCell
@property (nonatomic, weak) id<CCouponCampaignTableViewCellDelegate> delegate;

@property (nonatomic, assign) BOOL hideClaimButton;
- (void)setupWithModel:(id)model;
@end
