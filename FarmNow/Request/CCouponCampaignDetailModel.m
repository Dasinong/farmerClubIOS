//
//  CCouponCampaignDetailModel.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/14.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CCouponCampaignDetailModel.h"

@implementation CCouponCampaignDetailParam
+ (NSString *)path
{
    return [NSString stringWithFormat:@"couponCampaigns/%d", (int)[CCouponCampaignDetailParam shared_].couponCampaignId];
}

@end

@implementation CCouponCampaignDetailModel
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"data.campaign":@"campaign"}];
}
@end
