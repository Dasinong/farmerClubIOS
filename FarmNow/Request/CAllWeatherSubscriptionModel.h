//
//  CAllWeatherSubscriptionModel.h
//  FarmNow
//
//  Created by zheliang on 15/10/31.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CResponseBase.h"
#import "CWeatherSubscriptionItem.h"

@interface CAllWeatherSubscriptionParams : CRequestBaseParams

@end

@interface CAllWeatherSubscriptionModel : CResponseModel
@property (strong, nonatomic) NSArray<CWeatherSubscriptionItem>* data;

@end
