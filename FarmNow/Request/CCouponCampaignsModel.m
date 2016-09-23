//
//  CCouponCampaignsModel.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/14.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CCouponCampaignsModel.h"

@implementation CCouponCampaignsParam
+ (NSString *)path
{
    return @"couponCampaigns";
}

@end

@implementation CCouponCampaignsModel
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"data.campaigns":@"campaigns",
                                                       @"data.coupons":@"coupons"}];
}
@end
