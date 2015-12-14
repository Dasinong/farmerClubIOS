//
//  CWikiCell.m
//  FarmNow
//
//  Created by zheliang on 15/10/20.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CWikiCell.h"

@interface CWikiCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@end

@implementation CWikiCell

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
		self.iconView.image = [UIImage image_s:data[@"icon"]];
		self.titleLabel.text = data[@"title"];
		self.subTitleLabel.text = data[@"sub"];

	}
}

@end
