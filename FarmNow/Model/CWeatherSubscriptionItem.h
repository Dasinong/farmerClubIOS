//
//  CWeatherSubscriptionItem.h
//  FarmNow
//
//  Created by zheliang on 15/10/31.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CJSONModel.h"

@protocol CWeatherSubscriptionItem
@end

@interface CWeatherSubscriptionItem : CJSONModel
@property (assign, nonatomic) NSInteger weatherSubscriptionId;
@property (assign, nonatomic) NSInteger userId;
@property (assign, nonatomic) NSInteger locationId;
@property (assign, nonatomic) NSInteger monitorLocationId;
@property (strong, nonatomic) NSString* locationName;
@property (strong, nonatomic) NSString* type;
@property (assign, nonatomic) NSInteger createdAt;//单位 millisecond
//@property (assign, nonatomic) NSInteger ordering;
@end
