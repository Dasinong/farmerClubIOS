//
//  CWeatherSubscriptionModel.h
//  FarmNow
//
//  Created by zheliang on 15/10/31.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CResponseBase.h"
#import "CWeatherSubscriptionItem.h"

@interface CWeatherSubscriptionParams : CRequestBaseParams

@property (strong, nonatomic) NSNumber* locationId;

@end


@interface CWeatherSubscriptionModel : CResponseModel
@property (strong, nonatomic) CWeatherSubscriptionItem* data;

@end
