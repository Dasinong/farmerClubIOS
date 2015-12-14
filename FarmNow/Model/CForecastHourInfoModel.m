//
//  CForecastHourInfoModel.m
//  FarmNow
//
//  Created by zheliang on 15/10/31.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CForecastHourInfoModel.h"

@implementation CForecastHourInfoModel

+ (JSONKeyMapper *)keyMapper
{
	return [[JSONKeyMapper alloc] initWithDictionary:@{@"pOP":@"POP"}];
}
@end
