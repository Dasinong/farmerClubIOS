//
//  CLiveWeatherObject.h
//  FarmNow
//
//  Created by zheliang on 15/10/31.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CJSONModel.h"

@interface CLiveWeatherObject : CJSONModel
@property (strong, nonatomic) NSString* code;
@property (assign, nonatomic) NSTimeInterval	timeStamp;
@property (assign, nonatomic) NSInteger	l1;	//当前温度(摄氏度)
@property (assign, nonatomic) NSInteger	l2;	//当前湿度(单位%)
@property (assign, nonatomic) NSInteger	l3;	//当前风力(单位是级)
@property (assign, nonatomic) NSInteger	l4;	//当前风向编号
@property (assign, nonatomic) NSInteger	l5;	//当前天气气象编号
@property (strong, nonatomic) NSString*	l6;	//过去1小时的累积降水量(单位mm)
@property (strong, nonatomic) NSString*	l7;	//实况发布时间
@property (assign, nonatomic) NSInteger	daymin;	//今天最低温度(摄氏度)
@property (assign, nonatomic) NSInteger	daymax;	//今天最高温度(摄氏度)
@end
