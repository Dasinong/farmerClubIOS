//
//  CBrowseVarietyByCropIdModel.h
//  FarmNow
//
//  Created by zheliang on 15/10/22.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CResponseBase.h"
#import "CVarietyBrowseObjectModel.h"
//该API用于显示品种大全第3级列表

@interface CBrowseVarietyByCropIdParams : CRequestBaseParams

@property (assign, nonatomic) NSInteger cropId;

@end

@interface CBrowseVarietyByCropIdModel : CResponseModel

@property (strong, nonatomic) NSArray<CVarietyBrowseObjectModel, Optional>* data;
@end
