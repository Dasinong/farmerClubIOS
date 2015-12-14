//
//  CSubScribeListCell.m
//  FarmNow
//
//  Created by zheliang on 15/11/27.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CSubScribeListCell.h"
#import "CSubscriptionObject.h"

@interface CSubScribeListCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation CSubScribeListCell

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
//		CSubscriptionObject* object = data;
		self.nameLabel.text = data[@"name"];
	}
}

@end
