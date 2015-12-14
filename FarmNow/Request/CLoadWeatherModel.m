//
//  CLoadWeatherModel.m
//  FarmNow
//
//  Created by zheliang on 15/10/31.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CLoadWeatherModel.h"

@implementation CLoadWeatherParams

+ (NSString *)path
{
	return @"loadWeather";
}

@end

@implementation CLoadWeatherByMonitorLocationIdParams

+ (NSString *)path
{
	return @"loadWeather";
}

@end

@implementation CLoadWeatherModel


+ (JSONKeyMapper *)keyMapper
{
	return [[JSONKeyMapper alloc] initWithDictionary:@{@"data.workable":@"workable",
													  @"data.sprayable":@"sprayable",
													  @"data.current":@"current",
													  @"data.n24h":@"n24h",
													  @"data.n7d":@"n7d",
													  @"data.POP":@"POP",
													  @"data.sunrise":@"sunrise",
													   @"data.sunset":@"sunset",
													   @"data.soilHum":@"soilHum"}];
	
}

@end
