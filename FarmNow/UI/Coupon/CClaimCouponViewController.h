//
//  CClaimCouponViewController.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/14.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CBaseViewController.h"
#import "CCouponCampaign.h"
#import "CCoupon.h"

@protocol CClaimCouponViewControllerDelegate <NSObject>
- (void)couponGet:(CCoupon *)coupon;
@end

@interface CClaimCouponViewController : CBaseViewController
@property (nonatomic,strong) CCouponCampaign *couponCampaign;

@property (nonatomic,weak) id<CClaimCouponViewControllerDelegate> delegate;
@end
