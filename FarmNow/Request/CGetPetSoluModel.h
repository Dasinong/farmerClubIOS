//
//  CGetPetSoluModel.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/27.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CResponseBase.h"
#import "CIngredientDetailObject.h"

@interface CGetPetSoluParam : CRequestBaseParams
@property (nonatomic, assign) NSInteger petSoluId;
@end

@interface CGetPetSoluModel : CResponseModel
@property (nonatomic, strong) NSArray<CIngredientDetailObject> *cPProducts;
@end
