//
//  CGetPetSoluModel.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/27.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CResponseBase.h"

@interface CGetPetSoluParam : CRequestBaseParams
@property (nonatomic, assign) NSInteger petSoluId;
@end

@interface CGetPetSoluModel : CResponseModel

@end