//
//  CReorderWeatherSubscriptionsModel.h
//  FarmNow
//
//  Created by zheliang on 15/10/31.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CResponseBase.h"

@interface CReorderWeatherSubscriptionsParams : CRequestBaseParams
@property (strong, nonatomic) NSArray* ids;
@end

@interface CReorderWeatherSubscriptionsModel : CResponseModel

@end
