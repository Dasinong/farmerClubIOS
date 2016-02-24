//
//  CCropDetail.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/24.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CJSONModel.h"
#import "CCrop.h"
#import "CSubStage.h"
#import "CPetDisSpec.h"
#import "CTaskSpec.h"

@protocol CCropDetail
@end

@interface CCropDetail : CJSONModel
@property (nonatomic, strong) CCrop *crop;
@property (nonatomic, strong) NSArray<CSubStage> *substagews;
@property (nonatomic, strong) NSArray<CPetDisSpec> *petdisspecws;
@property (nonatomic, strong) NSArray<CTaskSpec> *taskspecws;

@property (nonatomic, assign) NSInteger subStageId;
@end
