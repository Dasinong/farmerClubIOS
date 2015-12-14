//
//  CImageTitleCell.m
//  FarmNow
//
//  Created by zheliang on 15/11/9.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CImageTitleCell.h"
#import "CPetDisSpecBrowseObject.h"

@interface CImageTitleCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end

@implementation CImageTitleCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setData:(id)data
{
	if (data && [data isKindOfClass:[CPetDisSpecBrowseObject class]]) {
		CPetDisSpecBrowseObject* object = data;
		[self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kImageServerAddress,object.thumbnailId]]];
		self.titleLabel.text = object.petDisSpecName;
		self.descLabel.text = object.sympthon;
	}
}

@end
