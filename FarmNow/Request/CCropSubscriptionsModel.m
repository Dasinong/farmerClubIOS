//
//  CCropSubscriptionsModel.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/22.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CCropSubscriptionsModel.h"

@implementation CCropSubscriptionsParam
+ (NSString *)path
{
    return @"getCropSubscriptions";
}
@end

@implementation CCropSubscriptionsModel
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"data.subscriptions":@"subscriptions"}];
}
@end
