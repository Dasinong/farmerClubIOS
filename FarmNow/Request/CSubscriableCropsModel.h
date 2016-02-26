//
//  CSubscriableCropsModel.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/23.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CResponseBase.h"
#import "CCrop.h"

@interface CSubscriableCropsParam : CRequestBaseParams

@end

@interface CSubscriableCropsModel : CResponseModel
@property (strong, nonatomic) NSArray<CCrop, Optional>* crops;
@end