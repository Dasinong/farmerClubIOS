//
//  CWeatherSubscriptionItem.m
//  FarmNow
//
//  Created by zheliang on 15/10/31.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CWeatherSubscriptionItem.h"

@implementation CWeatherSubscriptionItem
+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    if ([propertyName isEqualToString: @"createdAt"]) return YES;
    
    return NO;
}
@end
