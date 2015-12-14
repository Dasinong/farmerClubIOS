//
//  CWeatherDayCell.m
//  FarmNow
//
//  Created by zheliang on 15/11/2.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CWeatherDayCell.h"
#import "CForecastDayInfoObject.h"

@interface CWeatherDayCell ()
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *weather;
@property (weak, nonatomic) IBOutlet UILabel *temp;
@property (weak, nonatomic) IBOutlet UILabel *wind;

@end

@implementation CWeatherDayCell

- (void)setData:(id)data
{
	if (data && [data isKindOfClass:[CForecastDayInfoObject class]]) {
		CForecastDayInfoObject* object = (CForecastDayInfoObject*)data;
		NSDate* date = [NSDate dateWithTimeIntervalSince1970:object.forecast_time / 1000];
		NSString* weekday = date.weekdayChinese;
		self.date.text = weekday;
		self.temp.text = [NSString stringWithFormat:@"%ld°/%ld°",(long)object.max_temp, (long)object.min_temp];
		
		self.weather.text = WEATHER_NAME_DICT[@(object.weather)];
		self.icon.image = IMAGE(WEATHER_IMAGE_DICT[@(object.weather)]);
		self.wind.text = [NSString stringWithFormat:@"%@%@",WIND_DIRECTION_DICT[@(object.ff_level)],WIND_LEVEL_DICT[@(object.dd_level)]];
	}
}

@end
