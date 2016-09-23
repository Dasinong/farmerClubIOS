//
//  CBrowseCustomizedCPProductModel.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/29.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CResponseBase.h"
#import "CIngredientDetailObject.h"

@interface CBrowseCustomizedCPProductParams : CRequestBaseParams
@property (nonatomic, strong) NSString *model;
@property (nonatomic, strong) NSString *manufacturer;
@end

@interface CBrowseCustomizedCPProductModel : CResponseModel
@property (nonatomic, strong) NSArray<CIngredientDetailObject> *data;
@end
