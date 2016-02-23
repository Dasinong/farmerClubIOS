//
//  CField.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/23.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CJSONModel.h"
#import "CCrop.h"
#import "CSubStage.h"

@protocol CField
@end

@interface CField : CJSONModel
@property (assign, nonatomic) NSInteger cropId;
@property (assign, nonatomic) NSInteger fieldId;
@property (assign, nonatomic) NSInteger area;
@property (assign, nonatomic) NSInteger currentStageId;
@property (nonatomic, strong) CCrop *crop;
@property (nonatomic, strong) NSString *fieldName;
@property (assign, nonatomic) NSInteger locationId;
@property (assign, nonatomic) NSInteger monitorLocationId;
@property (nonatomic, strong) NSArray<CSubStage> *stagelist;
@end
