//
//  CSearchCell.m
//  FarmNow
//
//  Created by zheliang on 15/10/27.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CSearchCell.h"
#import "CSearchEntry.h"

@interface CSearchCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@end

@implementation CSearchCell

- (void)awakeFromNib
{
	[super awakeFromNib];
	//self.titleLabel.textColor = [UIColor blackColor];

}
- (void)setData:(id)data
{
	if (data && [data isKindOfClass:[CSearchEntry class]]) {
		CSearchEntry* entry = (CSearchEntry*)data;
		[self.titleLabel setHtml:entry.name] ;
		[self.subTitleLabel setHtml: [NSString stringWithFormat:@"<font color=\"grey\">%@</font>", entry.source]];
//		self.subTitleLabel.lin
	}
}

@end
