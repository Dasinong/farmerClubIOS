//
//  CLoadWeatherModel.h
//  FarmNow
//
//  Created by zheliang on 15/10/31.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CResponseBase.h"
#import "CLiveWeatherObject.h"
#import "CForecastHourInfoModel.h"
#import "CForecastDayInfoObject.h"
#import "CPOPObject.h"

@interface CLoadWeatherParams : CRequestBaseParams
@property (assign, nonatomic) double lat;
@property (assign, nonatomic) double lon;
@end

@interface CLoadWeatherByMonitorLocationIdParams : CRequestBaseParams

@property (strong, nonatomic) NSNumber* monitorLocationId;
@end

@interface CLoadWeatherModel : CResponseModel

@property (assign, nonatomic) NSInteger workable;	//1表示适宜,-1表示不适宜
@property (assign, nonatomic) NSInteger sprayable;	//1表示适宜,-1表示不适宜
@property (strong, nonatomic) CLiveWeatherObject* current;	//当前天气数据
@property (strong, nonatomic) NSArray<CForecastHourInfoModel>* n24h; //接下来24小时的天气预测
@property (strong, nonatomic) NSArray<CForecastDayInfoObject>* n7d;	//接下来7天的天气预测
@property (strong, nonatomic) CPOPObject* POP;	//今天的降水预测
@property (assign, nonatomic) NSTimeInterval sunrise;			//今天日出的时间
@property (assign, nonatomic) NSTimeInterval sunset;			//今天日落的时间
@property (strong, nonatomic) NSString* soilHum;	//1表示适宜,-1表示不适宜
@end
