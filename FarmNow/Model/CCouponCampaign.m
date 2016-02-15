//
//  CCouponCampaign.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/14.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CCouponCampaign.h"

@implementation CCouponCampaign
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"description":@"campaignDescription"}];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    if ([propertyName isEqualToString: @"pictureUrls"]) return YES;
    if ([propertyName isEqualToString: @"claimTimeStart"]) return YES;
    if ([propertyName isEqualToString: @"claimTimeEnd"]) return YES;
    if ([propertyName isEqualToString: @"redeemTimeStart"]) return YES;
    if ([propertyName isEqualToString: @"redeemTimeEnd"]) return YES;
    if ([propertyName isEqualToString: @"stores"]) return YES;
    if ([propertyName isEqualToString: @"campaignDescription"]) return YES;
    
    return NO;
}
@end
