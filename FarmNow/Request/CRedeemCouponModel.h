//
//  CRedeemCouponModel.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/17.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CCoupon.h"
#import "CResponseBase.h"

@interface CRedeemCouponParam : CRequestBaseParams
@property (assign, nonatomic) NSInteger couponId;
@property (assign, nonatomic) NSInteger userId;
@end

@interface CRedeemCouponModel : CResponseModel
@property (strong, nonatomic) CCoupon<Optional>* coupon;
@end
