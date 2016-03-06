//
//  CGetVarietyBaiKeByIdModel.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/3/6.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CResponseBase.h"
#import "CIngredientDetailObject.h"

@interface CGetVarietyBaiKeByIdParams : CRequestBaseParams
@property (nonatomic, assign) NSInteger id;
@end

@interface CGetVarietyBaiKeByIdModel : CResponseModel
@property (strong, nonatomic) NSDictionary<Optional>* data;
@end
