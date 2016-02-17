//
//  CCouponModel.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/17.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CCouponModel.h"

@implementation CCouponParam
+ (NSString *)path
{
    return @"getCoupons";
}
@end

@implementation CCouponModel
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"data.coupons":@"coupons"}];
}
@end
