//
//  CSearchLocationByLatAndLonObject.h
//  FarmNow
//
//  Created by zheliang on 15/11/2.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CJSONModel.h"

@interface CSearchLocationByLatAndLonObject : CJSONModel

@property (strong, nonatomic) NSString* community;
@property (assign, nonatomic) double	latitude;
@property (assign, nonatomic) double	longtitude;
@property (strong, nonatomic) NSString* province;
@property (strong, nonatomic) NSNumber*	locationId;
@property (strong, nonatomic) NSString* district;
@property (strong, nonatomic) NSString* city;
@property (strong, nonatomic) NSString* country;
@property (assign, nonatomic) NSInteger	region;

@end
