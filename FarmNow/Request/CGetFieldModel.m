//
//  CGetFieldModel.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/23.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CGetFieldModel.h"

@implementation CGetFieldParam
+ (NSString *)path
{
    return @"getField";
}
@end

@implementation CGetFieldModel
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"data.field":@"field"}];
}
@end
