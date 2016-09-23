//
//  CCreateCropSubscriptionModel.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/23.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CResponseBase.h"

@interface CCreateCropSubscriptionParam : CRequestBaseParams
@property (nonatomic, strong) NSString *cropId;
@end

@interface CCreateCropSubscriptionModel : CResponseModel

@end
