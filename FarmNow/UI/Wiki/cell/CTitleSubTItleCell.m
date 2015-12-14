//
//  CTitleSubTItleCell.m
//  FarmNow
//
//  Created by zheliang on 15/10/22.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CTitleSubTItleCell.h"

@interface CTitleSubTItleCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@end

@implementation CTitleSubTItleCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setData:(id)data
{
	if (data && [data isKindOfClass:[NSDictionary class]]) {
		self.titleLabel.text = data[@"title"];
		self.subTitleLabel.text = data[@"sub"];
	}
}
@end
