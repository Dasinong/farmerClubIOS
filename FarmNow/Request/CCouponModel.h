//
//  CCouponModel.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/17.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CResponseBase.h"
#import "CCoupon.h"

@interface CCouponParam : CRequestBaseParams

@end

@interface CCouponModel : CResponseModel
@property (strong, nonatomic) NSArray<CCoupon>* coupons;
@end
