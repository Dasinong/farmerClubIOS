//
//  CGetCpprductsByIngredientModel.h
//  FarmNow
//
//  Created by zheliang on 15/10/24.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CResponseBase.h"
#import "CIngredientDetailObject.h"

@interface CGetCpprductsByIngredientParams : CRequestBaseParams
@property (strong, nonatomic) NSString* ingredient;	//有效成分

@end

@interface CGetCpprductsByIngredientModel : CResponseModel
@property (strong, nonatomic) NSArray<CIngredientDetailObject, Optional>* data;

@end
