//
//  CBrowseCPProductByModelModel.h
//  FarmNow
//
//  Created by zheliang on 15/10/24.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CResponseBase.h"
#import "CIngredientBrowseObject.h"

@interface CBrowseCPProductByModelParams : CRequestBaseParams
@property (strong, nonatomic) NSString* model;//农药大类
@end

@interface CBrowseCPProductByModelModel : CResponseModel
@property (strong, nonatomic) NSArray<CIngredientBrowseObject, Optional>* data;

@end
