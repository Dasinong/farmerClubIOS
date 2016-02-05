//
//  CPetDisSpecBrowseObject.h
//  FarmNow
//
//  Created by zheliang on 15/10/24.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CJSONModel.h"

@protocol CPetDisSpecBrowseObject

@end

@interface CPetDisSpecBrowseObject : CJSONModel
@property (assign, nonatomic) NSInteger petDisSpecId;		//病虫草害ID
@property (strong, nonatomic) NSString* type;				//种类
@property (strong, nonatomic) NSString* petDisSpecName;	//品种名称
@property (strong, nonatomic) NSString* petDisSpecNamePY;	//品种名称拼音
@property (strong, nonatomic) NSString* thumbnailId;
@property (strong, nonatomic) NSString<Optional>* sympthon;


@end
