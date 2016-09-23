//
//  CWeatherHourItemView.m
//  FarmNow
//
//  Created by zheliang on 15/11/3.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CWeatherHourItemView.h"

@interface CWeatherHourItemView ()


@end

@implementation CWeatherHourItemView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setData:(CForecastHourInfoModel *)model
{
//	NSData* da
	NSDate* date = [NSDate dateWithTimeIntervalSince1970:model.time / 1000];
	self.time.text = [date stringWithFormat:@"HH:mm"];
    
    if (model.icon == nil || model.icon.length == 0) {
        //Warning(@"Icon is nil");
    }
    else {
        self.icon.image = IMAGE(WEATHER_IMAGE_DICT[model.icon]);
    }
	
	self.tempLabel.text = [NSString stringWithFormat:@"%ld℃",(long)model.temperature];
	
}

@end
