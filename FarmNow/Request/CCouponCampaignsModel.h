//
//  CCouponCampaignsModel.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/14.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CResponseBase.h"
#import "CCouponCampaign.h"

@interface CCouponCampaignsParam : CRequestBaseParams

@end

@interface CCouponCampaignsModel : CResponseModel
@property (strong, nonatomic) NSArray<CCouponCampaign, Optional>* campaigns;
@end
