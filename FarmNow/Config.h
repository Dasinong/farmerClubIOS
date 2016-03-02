//
//  EMConversation_Config.h
//  Laundry System
//
//  Created by liangzhe on 14-9-1.
//  Copyright (c) 2014年 liangzhe. All rights reserved.
//

//#define kServer @"http://120.55.85.23"
#define kServer @"http://120.26.208.198"
#define kServerAddress [kServer stringByAppendingString:@"/farmerClub/"]
#define kImageServerAddress [kServer stringByAppendingString:@"/pic/"]
#define kAvaterServerAddress [kServer stringByAppendingString:@"/avater/"]

#define kAPIServer kServerAddress
#define kWXAPP_ID @"wxa7ebd13ec0f05131"
#define kWXAPP_SECRET @"a0ef5bdab8c98792c06fe152ac3dce5c"
#define kWXScope  @"snsapi_userinfo,snsapi_base";
#define kWXAuthState  @"527";
#define kWXGetUserInfoResponse @"getUserInfoResponse"

#define kMOBSMSAPP_ID @"80424b5493c0"
#define kMOBSMSAPP_SECRET @"3c1b73e6af8f059c2e6b25f7065d77a3"

#define USER_DEFAULTS [NSUserDefaults standardUserDefaults]
#define USER [[CPersonalCache defaultPersonalCache] cacheUserInfo]

#define SCREEN_WIDTH [UIApplication sharedApplication].delegate.window.frame.size.width
#define SCREEN_HEIGHT [UIApplication sharedApplication].delegate.window.frame.size.height

#define __TencentDemoAppid_ @"1104698311"