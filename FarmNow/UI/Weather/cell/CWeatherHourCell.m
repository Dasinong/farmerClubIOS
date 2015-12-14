//
//  CWeatherHourCell.m
//  FarmNow
//
//  Created by zheliang on 15/11/3.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CWeatherHourCell.h"
#import "CLoadWeatherModel.h"
#import "CWeatherHourItemView.h"
@interface CWeatherHourCell ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation CWeatherHourCell

- (void)setData:(id)data
{
	if (data && [data isKindOfClass:[CLoadWeatherModel class]]) {
		
		CLoadWeatherModel* model = (CLoadWeatherModel*)data;
		CWeatherHourItemView* view = [self addNewView:nil data:nil];
		view.time.text = @"现在";
		view.icon.image = IMAGE(WEATHER_IMAGE_DICT[@(model.current.l5)]);
		view.tempLabel.text = [NSString stringWithFormat:@"%ld℃",(long)model.current.l1];

		NSLayoutConstraint* heightConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0f];
		heightConstraint.active = YES;

		UIView* leadingView = view;
		NSTimeInterval preTime = 0;
		NSTimeInterval sunrise = model.sunrise ;
		NSTimeInterval sunset = model.sunset;
		for (CForecastHourInfoModel* item in model.n24h) {
			if (item.time > sunrise && preTime < sunrise) {
				CWeatherHourItemView* aView = [self addNewView:leadingView data:nil];
				NSDate* date = [NSDate dateWithTimeIntervalSince1970:sunrise / 1000];

				aView.time.text = [date stringWithFormat:@"HH:mm"];

				aView.icon.image = IMAGE(@"sunrise");
				aView.tempLabel.text = @"日出";
				leadingView = aView;
			}
			else if (item.time > sunset && preTime < sunset)
			{
				CWeatherHourItemView* aView = [self addNewView:leadingView data:nil];
				NSDate* date = [NSDate dateWithTimeIntervalSince1970:sunset / 1000];
				aView.time.text = [date stringWithFormat:@"HH:mm"];
				
				aView.icon.image = IMAGE(@"sunset");
				aView.tempLabel.text = @"日落";
				leadingView = aView;
			}
			CWeatherHourItemView* newView = [self addNewView:leadingView data:item];
			preTime = item.time;
			leadingView = newView;
		}
		NSLayoutConstraint* rightConstraint = [NSLayoutConstraint constraintWithItem:leadingView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f];
		
		rightConstraint.active = YES;
	}
}

- (CWeatherHourItemView*)addNewView:(UIView*)preView data:(CForecastHourInfoModel*)data
{
	CWeatherHourItemView* view = [NSBundle objectForClass:[CWeatherHourItemView class] inNib:@"CWeatherHourItemView" owner:self];
	[view setData:data];
	[self.scrollView addSubview:view];
	NSLayoutConstraint* leftConstraint;
	if (preView == nil) {
		leftConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f];
		
	}
	else
	{
		leftConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:preView attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f];
		
	}
	
	//logoImageView右侧与父视图右侧对齐
	NSLayoutConstraint* bottomConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f];
	
	//logoImageView顶部与父视图顶部对齐
	NSLayoutConstraint* topConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f];
	NSLayoutConstraint* widthConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeWidth multiplier:1.f / 6.f constant:0.0f];
	
	leftConstraint.active =
	bottomConstraint.active =
	topConstraint.active =
	widthConstraint.active =
	YES;
	return view;
}

@end
