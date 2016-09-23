//
//  CClaimCouponModel.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/14.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CClaimCouponModel.h"

@implementation CClaimCouponParams

+ (NSString *)path
{
	return @"claimCoupon";
}

@end

@implementation CClaimCouponModel
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"data.coupon":@"coupon"}];
}
@end
