//
//  CStoresModel.h
//  FarmNow
//
//  Created by zheliang on 15/11/23.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CResponseBase.h"

@interface CStoresParams : CRequestBaseParams

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* desc;
@property (strong, nonatomic) NSNumber* locationId;
@property (strong, nonatomic) NSString* streetAndNumber;
@property (assign, nonatomic) double latitude;
@property (assign, nonatomic) double longtitude;
@property (strong, nonatomic) NSString* ownerName;
@property (strong, nonatomic) NSString* phone;
@property (strong, nonatomic) NSString* contactName;
@property (assign, nonatomic) NSInteger type;//
@property (assign, nonatomic) NSInteger source;


@end

@interface CStoresModel : CResponseModel

@end
