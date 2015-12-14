//
//  CMineContentCell.m
//  FarmNow
//
//  Created by zheliang on 15/10/19.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CMineContentCell.h"

@interface CMineContentCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end


@implementation CMineContentCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setData:(id)data
{
	if ([data isKindOfClass:[NSDictionary class]]) {
		self.titleLabel.text =((NSDictionary*)data).allKeys[0];
		self.contentLabel.text =((NSDictionary*)data).allValues[0];

	}
	else if([data isKindOfClass:[NSString class]])
	{
		self.titleLabel.text =data;
		self.contentLabel.text =nil;
	}
}

@end
