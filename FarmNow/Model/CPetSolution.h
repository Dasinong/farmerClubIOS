//
//  CSolution.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/23.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CJSONModel.h"

@protocol CPetSolution
@end

@interface CPetSolution : CJSONModel
@property (nonatomic, assign) NSInteger isCPSolu;
@property (nonatomic, assign) NSInteger isRemedy;
@property (nonatomic, assign) NSInteger petDisSpecId;
@property (nonatomic, strong) NSString *petSoluDes;
@property (nonatomic, assign) NSInteger petSoluId;
@property (nonatomic, strong) NSString *providedBy;
@property (nonatomic, assign) NSInteger rank;
@property (nonatomic, strong) NSString *snapshotCP;
@property (nonatomic, strong) NSString *subStageId;
@end
