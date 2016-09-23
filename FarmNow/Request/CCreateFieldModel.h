//
//  CCreateFieldModel.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/25.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CResponseBase.h"

@interface CCreateFieldParam : CRequestBaseParams
@property (nonatomic, strong) NSString *fieldName;
@property (nonatomic, assign) NSInteger area;
@property (nonatomic, assign) NSNumber *locationId;
@property (nonatomic, assign) NSInteger cropId;
@property (nonatomic, assign) NSInteger currentStageId;
@end

@interface CCreateFieldModel : CResponseModel

@end
