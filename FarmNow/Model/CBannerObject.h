//
//  CBannerObject.h
//  FarmNow
//
//  Created by zheliang on 15/11/16.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CJSONModel.h"

typedef enum NSInteger {
	eSystem = 1,
	eWeatherOrNongye,
	eNongYan
} EBannerType;

@protocol CBannerObject
@end

@interface CBannerObject : CJSONModel
@property (assign, nonatomic) NSInteger id;
@property (assign, nonatomic) EBannerType type;
@property (strong, nonatomic) NSString<Optional>* picName;
@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString<Optional>* content;
@property (strong, nonatomic) NSString* url;

@end
