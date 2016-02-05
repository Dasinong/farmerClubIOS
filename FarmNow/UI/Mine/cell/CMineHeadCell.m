//
//  CMineHeadCell.m
//  FarmNow
//
//  Created by zheliang on 15/10/19.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CMineHeadCell.h"

@interface CMineHeadCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headIcon;

@end

@implementation CMineHeadCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setData:(id)data
{
	if (data && [data isKindOfClass:[NSString class]]) {
		NSString* url = data;
		if (![url hasPrefix:@"http://"]) {
            url = [NSString stringWithFormat:@"%@%@",kAvaterServerAddress, url];
		}
        
        [self.headIcon sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:IMAGE(@"default_avatar")];
	}
}
@end
