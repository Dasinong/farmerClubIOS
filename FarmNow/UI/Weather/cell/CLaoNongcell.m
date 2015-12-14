//
//  CLaoNongcell.m
//  FarmNow
//
//  Created by zheliang on 15/12/4.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CLaoNongcell.h"
#import "CBannerObject.h"

@interface CLaoNongcell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation CLaoNongcell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setData:(id)data
{
	if (data && [data isKindOfClass:[CBannerObject class]]) {
		CBannerObject* object = data;
		self.iconImageView.image = IMAGE(object.picName);
//		self.iconImageView =
		self.contentLabel.text = object.content;
	}
}

@end
