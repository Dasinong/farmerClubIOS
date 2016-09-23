//
//  CChangeFieldStageModel.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/24.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CResponseBase.h"

@interface CChangeFieldStageParam : CRequestBaseParams
@property (nonatomic, assign) NSInteger fieldId;
@property (nonatomic, assign) NSInteger subStageId;
@end

@interface CChangeFieldStageModel : CResponseModel

@end
