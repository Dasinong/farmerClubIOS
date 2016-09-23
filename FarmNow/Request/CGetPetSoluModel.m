//
//  CGetPetSoluModel.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/27.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CGetPetSoluModel.h"

@implementation CGetPetSoluParam
+ (NSString *)path
{
    return @"getFormattedPetSolu";
}
@end

@implementation CGetPetSoluModel
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"data.cPProducts":@"cPProducts"}];
}
@end
