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


@property (weak, nonatomic) IBOutlet UIImageView *morningImageView;
@property (weak, nonatomic) IBOutlet UIImageView *noonImageView;
@property (weak, nonatomic) IBOutlet UIImageView *nightImageView;
@property (weak, nonatomic) IBOutlet UIImageView *midNightImageView;


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
        
        // 图片
        [self setImageView:self.morningImageView withPossibility:object.morning];
        [self setImageView:self.noonImageView withPossibility:object.noon];
        [self setImageView:self.nightImageView withPossibility:object.night];
        [self setImageView:self.midNightImageView withPossibility:object.nextmidnight];        
	}
}

- (void)setImageView:(UIImageView *)imageView withPossibility:(NSInteger)possibility {
    if (possibility <= 0) {
        [imageView setImage:[UIImage imageNamed:@"pop0"]];
    }
    else if (possibility < 40) {
        [imageView setImage:[UIImage imageNamed:@"pop1"]];
    }
    else if (possibility < 80) {
        [imageView setImage:[UIImage imageNamed:@"pop2"]];
    }
    else if (possibility < 100) {
        [imageView setImage:[UIImage imageNamed:@"pop3"]];
    }
    else {
        [imageView setImage:[UIImage imageNamed:@"pop4"]];
    }
}
@end
