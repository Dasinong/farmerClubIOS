//
//  CClaimCouponModel.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/14.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CResponseBase.h"

@interface CClaimCouponParams : CRequestBaseParams
@property (assign, nonatomic) NSInteger campaignId;
@end

@interface CClaimCouponModel : CResponseModel

@end
