//
//  CRedeemCouponModel.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/17.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CRedeemCouponModel.h"

@implementation CRedeemCouponParam
+ (NSString *)path
{
    return @"redeemCoupon";
}
@end

@implementation CRedeemCouponModel
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"data.coupon":@"coupon"}];
}
@end
