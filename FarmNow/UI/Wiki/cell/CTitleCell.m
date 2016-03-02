//
//  CTitleCell.m
//  FarmNow
//
//  Created by zheliang on 15/10/23.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CTitleCell.h"
#import "CVarietyBrowseObjectModel.h"
#import "CPetDisSpecBrowseObject.h"
#import "CIngredientBrowseObject.h"
#import "CCPProductObject.h"
#import "CIngredientDetailObject.h"

@interface CTitleCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation CTitleCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setData:(id)data
{
	if (data && [data isKindOfClass:[CVarietyBrowseObjectModel class]]) {
		CVarietyBrowseObjectModel* item = (CVarietyBrowseObjectModel*)data;
		self.titleLabel.text = item.varietyName;
		//		self.subTitleLabel.text = item.v
	}
	else if (data && [data isKindOfClass:[CPetDisSpecBrowseObject class]]) {
		CPetDisSpecBrowseObject* item = (CPetDisSpecBrowseObject*)data;
		self.titleLabel.text = item.petDisSpecName;
	}
	else if(data && [data isKindOfClass:[CIngredientBrowseObject class]])
	{
		CIngredientBrowseObject* item = (CIngredientBrowseObject*)data;
		self.titleLabel.text = item.activeIngredient;
	}
	else if (data && [data isKindOfClass:[CCPProductObject class]])
	{
		CCPProductObject* item = (CCPProductObject*)data;
		self.titleLabel.text = item.name;
    }
    else if (data && [data isKindOfClass:[CIngredientDetailObject class]])
    {
        CIngredientDetailObject* item = (CIngredientDetailObject*)data;
        self.titleLabel.text = item.name;
    }
	else if (data && [data isKindOfClass:[NSString class]]){
		self.titleLabel.text = data;
	}
}
@end
