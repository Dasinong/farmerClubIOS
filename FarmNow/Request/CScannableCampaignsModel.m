//
//  CScannableCampaignsModel.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/17.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CScannableCampaignsModel.h"

@implementation CScannableCampaignsParam
+ (NSString *)path
{
    return @"getScannableCampaigns";
}
@end

@implementation CScannableCampaignsModel
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"data.campaigns":@"campaigns"}];
}
@end
