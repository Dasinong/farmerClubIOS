//
//  CTaskSpec.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/23.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CJSONModel.h"
#import "CTaskStep.h"

@protocol CTaskSpec
@end

@interface CTaskSpec : CJSONModel
@property (nonatomic, strong) NSArray<CTaskStep> *steps;
@property (nonatomic, assign) NSInteger subStageId;
@property (nonatomic, assign) NSInteger taskSpecId;
@property (nonatomic, strong) NSString *taskSpecName;
@property (nonatomic, strong) NSString *type;
@end
