//
//  CGetCropDetailsModel.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/24.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CResponseBase.h"
#import "CCropDetail.h"

@interface CGetCropDetailsParam : CRequestBaseParams
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, strong) NSString *subStageId;
@end

@interface CGetCropDetailsModel : CResponseModel
@property (nonatomic, strong) CCropDetail *cropDetail;
@end
