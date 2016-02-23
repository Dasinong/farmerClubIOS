//
//  CSubscriableCropsModel.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/23.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CSubscriableCropsModel.h"


@implementation CSubscriableCropsParam
+ (NSString *)path
{
    return @"getSubscriableCrops";
}
@end

@implementation CSubscriableCropsModel
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"data.crops":@"crops"}];
}
@end
