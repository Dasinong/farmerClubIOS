//
//  CWeatherHourItemView.h
//  FarmNow
//
//  Created by zheliang on 15/11/3.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CForecastHourInfoModel.h"

@interface CWeatherHourItemView : UIView
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
- (void)setData:(CForecastHourInfoModel*)model;
@end
