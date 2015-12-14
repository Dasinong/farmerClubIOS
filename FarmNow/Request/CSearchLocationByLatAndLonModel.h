//
//  CSearchLocationByLatAndLonModel.h
//  FarmNow
//
//  Created by zheliang on 15/11/2.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CResponseBase.h"
#import "CSearchLocationByLatAndLonObject.h"

@interface CSearchLocationByLatAndLonParams : CRequestBaseParams

@property (assign, nonatomic) double lat;
@property (assign, nonatomic) double lon;


@end

@interface CSearchLocationByLatAndLonModel : CResponseModel
@property (strong, nonatomic) CSearchLocationByLatAndLonObject* data;
@end
