//
//  EMConversation_Config.h
//  Laundry System
//
//  Created by liangzhe on 14-9-1.
//  Copyright (c) 2014年 liangzhe. All rights reserved.
//

//#define kServer @"http://120.55.85.23"
#define kServer @"http://120.26.208.198:8080"
#define kServerAddress [kServer stringByAppendingString:@"/farmerClub/"]
#define kImageServerAddress [kServer stringByAppendingString:@"/pic/"]
#define kAvaterServerAddress [kServer stringByAppendingString:@"/avater/"]

#define kAPIServer kServerAddress
#define kWXAPP_ID @"wx4d695a8b93857af1"
#define kWXAPP_SECRET @"e4d2e28f0dc7123145aeacfb93e70ca7"
#define kWXScope  @"snsapi_userinfo,snsapi_base";
#define kWXAuthState  @"527";
#define kWXGetUserInfoResponse @"getUserInfoResponse"

#define kMOBSMSAPP_ID @"80424b5493c0"
#define kMOBSMSAPP_SECRET @"3c1b73e6af8f059c2e6b25f7065d77a3"

#define USER_DEFAULTS [NSUserDefaults standardUserDefaults]

#define __TencentDemoAppid_ @"1104698311"