//
//  CRequestCouponModel.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/14.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CResponseBase.h"

@interface CRequestCouponParams : CRequestBaseParams
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* company;
@property (strong, nonatomic) NSString* crop;
@property (strong, nonatomic) NSString* experience;
@property (strong, nonatomic) NSString* contactNumber;
@property (strong, nonatomic) NSString* productUseHistory;
@property (assign, nonatomic) double area;
@property (assign, nonatomic) double yield;
@property (strong, nonatomic) NSString* address;
@property (nonatomic, assign) NSInteger userid;
@property (strong, nonatomic) NSString* postcode;


@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *educationLevel;
@property (nonatomic, strong) NSString *useTimes;
@property (nonatomic, strong) NSString *bestFeature;
@property (nonatomic, strong) NSString *badFeature;
@property (nonatomic, strong) NSString *hopeFeature;
@property (nonatomic, strong) NSString *bestValue;
@property (nonatomic, strong) NSString *othersApp;
@end

@interface CRequestCouponModel : CResponseModel

@end
