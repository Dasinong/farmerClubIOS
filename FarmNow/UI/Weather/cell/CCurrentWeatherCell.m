//
//  CCurrentWeatherCell.m
//  FarmNow
//
//  Created by zheliang on 15/10/31.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CCurrentWeatherCell.h"
#import "CLiveWeatherObject.h"

@interface CCurrentWeatherCell ()
@property (weak, nonatomic) IBOutlet UILabel *wenduLabel;
@property (weak, nonatomic) IBOutlet UILabel *highTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *lowTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *windLabel;
@property (weak, nonatomic) IBOutlet UILabel *rainLabel;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;

@end

@implementation CCurrentWeatherCell

- (void)setData:(id)data
{
	if (data && [data isKindOfClass:[CLiveWeatherObject class]]) {
		CLiveWeatherObject* object = (CLiveWeatherObject*)data;
		self.wenduLabel.text = [NSString stringWithFormat:@"%ld°c",(long)object.l1];
		self.highTempLabel.text = [NSString stringWithFormat:@"最高 %ld°",(long)object.daymax];
		self.lowTempLabel.text = [NSString stringWithFormat:@"最低 %ld°",(long)object.daymin];
		self.rainLabel.text = object.l6 > 0 ? [NSString stringWithFormat:@"%@mm",object.l6] : @"无";
		self.weatherLabel.text = WEATHER_NAME_DICT[@(object.l5)];
		self.icon.image = IMAGE(WEATHER_IMAGE_DICT[@(object.l5)]);
		self.windLabel.text = [NSString stringWithFormat:@"%@%@",WIND_DIRECTION_DICT[@(object.l4)],WIND_LEVEL_DICT[@(object.l3)]];

	}
	
}
@end
