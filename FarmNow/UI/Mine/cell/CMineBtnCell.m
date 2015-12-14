//
//  CMineBtnCell.m
//  FarmNow
//
//  Created by zheliang on 15/11/21.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CMineBtnCell.h"

@interface CMineBtnCell ()
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end
@implementation CMineBtnCell

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
	self.btn.layer.cornerRadius = 5.f;
	self.btn.layer.masksToBounds = YES;
}
- (void)setData:(id)data
{
	if ([data isKindOfClass:[NSDictionary class]]) {
		UIColor* color = data[@"color"];
		NSString* title = data[@"title"];
		[self.btn setTitle:title forState:UIControlStateNormal];
		self.btn.backgroundColor = color;
	}
	
}

@end
