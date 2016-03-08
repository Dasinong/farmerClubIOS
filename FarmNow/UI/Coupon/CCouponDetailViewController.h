//
//  CCouponDetailViewController.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/14.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CBaseViewController.h"
#import "CCouponCampaign.h"
#import <CoreLocation/CoreLocation.h>

extern CLLocationDegrees gLatitude;
extern CLLocationDegrees gLongitude;

@interface CCouponDetailViewController : CBaseViewController
@property (nonatomic,strong) CCouponCampaign *couponCampaign;
@property (nonatomic, assign) BOOL scanned;
@end
