//
//  CLaonongsModel.m
//  FarmNow
//
//  Created by zheliang on 15/11/16.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CLaonongsModel.h"

@implementation CLaonongsParams

+ (NSString *)path
{
	return @"laonongs";
}

@end

@implementation CLaonongsModel

+ (JSONKeyMapper *)keyMapper
{
	return [[JSONKeyMapper alloc] initWithDictionary:@{@"data.laonongs":@"laonongs"}];
}
@end
