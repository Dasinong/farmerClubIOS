//
//  CGetPetDisSpecBaiKeByIdModel.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/3/6.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CResponseBase.h"
#import "CPetDisSpec.h"

@interface CGetPetDisSpecBaiKeByIdParams : CRequestBaseParams
@property (nonatomic, assign) NSInteger id;
@end

@interface CGetPetDisSpecBaiKeByIdModel : CResponseModel
@property (strong, nonatomic) CPetDisSpec<Optional>* data;
@end
