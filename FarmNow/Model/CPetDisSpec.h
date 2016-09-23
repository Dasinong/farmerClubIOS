//
//  CPetDisSpec.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/23.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CJSONModel.h"
#import "CPetSolution.h"

@protocol CPetDisSpec
@end

@interface CPetDisSpec : CJSONModel
@property (nonatomic, strong) NSString *alias;
@property (nonatomic, strong) NSString *form;
@property (nonatomic, strong) NSString *habbit;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, strong) NSArray *imagesPath;
@property (nonatomic, strong) NSString *petDisSpecName;
@property (nonatomic, strong) NSString *rule;
@property (nonatomic, assign) NSInteger severity;
@property (nonatomic, strong) NSArray<CPetSolution> *solutions;
@property (nonatomic, strong) NSString *sympton;
@property (nonatomic, strong) NSString *type;
@end
