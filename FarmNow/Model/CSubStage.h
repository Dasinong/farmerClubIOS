//
//  CSubStage.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/23.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CJSONModel.h"

@protocol CSubStage
@end


@interface CSubStage : CJSONModel
@property (nonatomic, strong) NSString *stageName;
@property (nonatomic, assign) NSInteger subStageId;
@property (nonatomic, strong) NSString *subStageName;

- (NSString *)stageDisplayName;
@end
