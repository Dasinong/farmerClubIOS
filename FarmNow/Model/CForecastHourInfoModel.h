//
//  CForecastHourInfoModel.h
//  FarmNow
//
//  Created by zheliang on 15/10/31.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CJSONModel.h"

@protocol CForecastHourInfoModel
@end

@interface CForecastHourInfoModel : CJSONModel
@property (assign, nonatomic) NSTimeInterval time;//数据发布时间
@property (assign, nonatomic) NSInteger temperature;				//温度(摄氏度)
@property (assign, nonatomic) NSInteger relativeHumidity;			//湿度
@property (assign, nonatomic) NSInteger windDirection_10m;			//风向
@property (assign, nonatomic) double windSpeed_10m;					//风速
@property (assign, nonatomic) double accumRainTotal;				//积雨
@property (assign, nonatomic) double accumSnowTotal;				//积雪
@property (assign, nonatomic) double accumIceTotal;					//积冰
@property (strong, nonatomic) NSString* POP;						//降水概率(单位%)
@property (strong, nonatomic) NSString* icon;						//天气气象编码

@end
