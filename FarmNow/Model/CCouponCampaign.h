//
//  CCouponCampaign.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/14.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CJSONModel.h"
#import "CStore.h"

@protocol CCouponCampaign
@end

@interface CCouponCampaign : CJSONModel
@property (assign, nonatomic) NSInteger id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString<Optional> *campaignDescription;
@property (nonatomic) float amount;
@property (nonatomic, strong) NSArray<Optional> *pictureUrls;
@property (assign, nonatomic) NSTimeInterval claimTimeStart;
@property (assign, nonatomic) NSTimeInterval claimTimeEnd;
@property (assign, nonatomic) NSTimeInterval redeemTimeStart;
@property (assign, nonatomic) NSTimeInterval redeemTimeEnd;
@property (nonatomic, strong) NSDictionary<Optional> *institution;
@property (nonatomic, strong) NSArray<Optional, CStore> *stores;

- (BOOL)isInsurance;
@end
