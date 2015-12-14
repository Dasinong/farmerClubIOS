//
//  CWeatherPOPCell.m
//  FarmNow
//
//  Created by zheliang on 15/11/2.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CWeatherPOPCell.h"
#import "CPOPObject.h"

@interface CWeatherPOPCell ()
@property (weak, nonatomic) IBOutlet UILabel *morningLabel;
@property (weak, nonatomic) IBOutlet UILabel *noonLabel;
@property (weak, nonatomic) IBOutlet UILabel *nightLabel;
@property (weak, nonatomic) IBOutlet UILabel *midNight;

@end

@implementation CWeatherPOPCell
- (void)setData:(id)data
{
	if ([data isKindOfClass:[CPOPObject class]]) {
		CPOPObject* object = (CPOPObject*)data;
		self.morningLabel.text = [NSString stringWithFormat:@"%ld%%",(long)object.morning];
		self.noonLabel.text = [NSString stringWithFormat:@"%ld%%",(long)object.noon];
		self.nightLabel.text = [NSString stringWithFormat:@"%ld%%",(long)object.night];
		self.midNight.text = [NSString stringWithFormat:@"%ld%%",(long)object.nextmidnight];
	}
}

@end
