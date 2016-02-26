//
//  CGetStagesModel.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/24.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CResponseBase.h"
#import "CSubStage.h"

@interface CGetStagesParam : CRequestBaseParams
@property (nonatomic, assign) NSInteger cropId;
@end

@interface CGetStagesModel : CResponseModel
@property (nonatomic, strong) NSArray<CSubStage> *data;
@end
