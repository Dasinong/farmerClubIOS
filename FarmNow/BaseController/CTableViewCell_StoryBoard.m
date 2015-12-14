//
//  CTableViewCell_StoryBoard.m
//  FarmNow
//
//  Created by zheliang on 15/10/16.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CTableViewCell_StoryBoard.h"

@implementation CTableViewCell_StoryBoard


- (void)awakeFromNib {
	// Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];
	
	// Configure the view for the selected state
}

- (void)setData:(id)data
{
	
}
- (void)doAction:(NSInteger)tag
{
	if (self.delegate && [self.delegate respondsToSelector:@selector(doAction:tag:data:)]) {
		[self.delegate doAction:self.indexPath tag:tag data:self.cellData];
	}
}


@end
