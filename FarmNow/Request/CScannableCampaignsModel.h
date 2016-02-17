//
//  CScannableCampaignsModel.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/17.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CResponseBase.h"
#import "CCouponCampaign.h"

@interface CScannableCampaignsParam : CRequestBaseParams

@end

@interface CScannableCampaignsModel : CResponseModel
@property (strong, nonatomic) NSArray<CCouponCampaign>* campaigns;
@end
