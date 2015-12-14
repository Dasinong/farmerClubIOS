//
//  CLaonongsModel.h
//  FarmNow
//
//  Created by zheliang on 15/11/16.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CResponseBase.h"
#import "CBannerObject.h"

@interface CLaonongsParams : CRequestBaseParams
@property (assign, nonatomic) double lat;
@property (assign, nonatomic) double lon;
@property (strong, nonatomic) NSNumber* monitorLocationId;
@end


@interface CLaonongsModel : CResponseModel
@property (strong, nonatomic) NSArray<CBannerObject>* laonongs;
@end
