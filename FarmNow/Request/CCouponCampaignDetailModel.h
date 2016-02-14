//
//  CCouponCampaignDetailModel.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/14.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CResponseBase.h"
#import "CCouponCampaign.h"

@interface CCouponCampaignDetailParam : CRequestBaseParams
@property (assign, nonatomic) NSInteger couponCampaignId;
@end

@interface CCouponCampaignDetailModel : CResponseModel
@property (strong, nonatomic) CCouponCampaign<Optional>* campaign;
@end
