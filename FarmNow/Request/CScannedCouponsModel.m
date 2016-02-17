//
//  CScannedCouponsModel.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/17.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CScannedCouponsModel.h"

@implementation CScannedCouponsParam
+ (NSString *)path
{
    return @"getScannedCouponsByCampaignId";
}
@end

@implementation CScannedCouponsModel
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"data.coupons":@"coupons"}];
}
@end
