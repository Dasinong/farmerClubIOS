//
//  CTaskStep.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/23.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CJSONModel.h"

@protocol CTaskStep
@end

@interface CTaskStep : CJSONModel
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *fitRegion;
@property (nonatomic, assign) NSInteger idx;
@property (nonatomic, strong) NSString *picture;
@property (nonatomic, assign) NSInteger stepId;
@property (nonatomic, strong) NSString *stepName;
@property (nonatomic, strong) NSString *thumbnailPicture;

@end
