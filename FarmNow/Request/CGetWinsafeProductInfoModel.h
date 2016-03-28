//
//  CGetWinsafeProductInfoModel.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/3/28.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CResponseBase.h"

@interface CGetWinsafeProductInfoParams : CRequestBaseParams
@property (nonatomic, strong) NSString *boxcode;
@property (nonatomic, assign) BOOL stocking;
@end

@interface CGetWinsafeProductInfoModel : CResponseModel
@property (nonatomic, strong) NSDictionary *data;
@end
