//
//  CWeatherSectionView.m
//  FarmNow
//
//  Created by zheliang on 15/11/4.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CWeatherSectionView.h"

@interface CWeatherSectionView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineHeight;

@end

@implementation CWeatherSectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib
{
	[super awakeFromNib];
	self.lineHeight.constant = (1.0 / [UIScreen mainScreen].scale);
}

- (void)setTitle:(NSString *)title
{
	self.titleLabel.text = title;
}
@end
