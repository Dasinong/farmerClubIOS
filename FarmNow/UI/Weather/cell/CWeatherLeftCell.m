//
//  CWeatherLeftCell.m
//  FarmNow
//
//  Created by zheliang on 15/10/28.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CWeatherLeftCell.h"
#import "CWeatherSubscriptionItem.h"

@interface CWeatherLeftCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *icon;

@end

@implementation CWeatherLeftCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setData:(id)data
{
	if (data && [data isKindOfClass:[CWeatherSubscriptionItem class]]) {
		CWeatherSubscriptionItem* item = (CWeatherSubscriptionItem*)data;
		self.titleLabel.text = item.locationName;
	}
}

@end
