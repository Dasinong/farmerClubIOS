//
//  CCoupon.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/14.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CJSONModel.h"
#import "CCouponCampaign.h"

@protocol CCoupon
@end

@interface CCoupon : CJSONModel
@property (assign, nonatomic) NSInteger id;
@property (assign, nonatomic) float amount;
@property (nonatomic, strong) NSString *type;
@property (assign, nonatomic) NSInteger sannerId;
@property (nonatomic, strong) NSString *displayStatus;
@property (assign, nonatomic) NSTimeInterval redeemedAt;
@property (assign, nonatomic) NSTimeInterval claimedAt;
@property (assign, nonatomic) NSTimeInterval createdAt;
@property (nonatomic, strong) CCouponCampaign<Optional> *campaign;
@property (nonatomic, strong) NSString<Optional> *claimerCell;

- (BOOL)expired;
@end
