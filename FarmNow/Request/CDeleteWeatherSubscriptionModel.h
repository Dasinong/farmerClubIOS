//
//  CDeleteWeatherSubscriptionModel.h
//  FarmNow
//
//  Created by zheliang on 15/10/31.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CResponseBase.h"

@interface CDeleteWeatherSubscriptionParams : CRequestBaseParams
@property (assign, nonatomic) NSInteger id;
@end

@interface CDeleteWeatherSubscriptionModel : CResponseModel

@end
