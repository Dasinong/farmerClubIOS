//
//  CGetCropDetailsModel.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/24.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CGetCropDetailsModel.h"

@implementation CGetCropDetailsParam
+ (NSString *)path
{
    return @"getCropDetails";
}
@end

@implementation CGetCropDetailsModel
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"data.crop":@"cropDetail"}];
}
@end
