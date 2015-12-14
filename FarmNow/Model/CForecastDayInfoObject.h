//
//  CForecastDayInfoObject.h
//  FarmNow
//
//  Created by zheliang on 15/10/31.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CJSONModel.h"

@protocol CForecastDayInfoObject

@end

@interface CForecastDayInfoObject : CJSONModel
@property (assign, nonatomic) NSTimeInterval forecast_time;	//预报发布时间
@property (assign, nonatomic) NSInteger	ff_level;	//风向编码
@property (assign, nonatomic) NSInteger dd_level;	//风力编码
@property (assign, nonatomic) NSInteger min_temp;	//最低温
@property (assign, nonatomic) NSInteger max_temp;	//最高温度
@property (assign, nonatomic) NSInteger temp;		//平均温度
@property (assign, nonatomic) NSInteger weather;	//天气气象编码
@property (assign, nonatomic) NSInteger rain;		//降雨量

@end
