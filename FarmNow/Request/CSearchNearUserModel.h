//
//  CSearchNearUserModel.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/26.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CResponseBase.h"

@interface CSearchNearUserParam : CRequestBaseParams
@end

@interface CSearchNearUserModel : CResponseModel
@property (nonatomic, assign) NSInteger data;
@end
