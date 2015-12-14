//
//  CVarietyBrowseObjectModel.h
//  FarmNow
//
//  Created by zheliang on 15/10/22.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CJSONModel.h"

@protocol CVarietyBrowseObjectModel
@end

@interface CVarietyBrowseObjectModel : CJSONModel

@property (assign, nonatomic) NSInteger varietyId;		//品种ID
@property (assign, nonatomic) NSInteger cropId;			//关联的作物Id
@property (strong, nonatomic) NSString* varietyName;	//品种名称
@property (strong, nonatomic) NSString* varietyNamePY;	//品种名称拼音

@end
