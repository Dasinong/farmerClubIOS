//
//  NSBundle+Xib.h
//  BuildeTower
//
//  Created by liangzhe on 13-6-27.
//  Copyright (c) 2013年 liangzhe. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kTestFlightAppToken @"TestFlightAppToken"
#define kBaiduMapAppToken   @"BaiduMapAppToken"
#define kUMengAppToken      @"UMengAppToken"
#define kWechatAppToken     @"WechatAppToken"
#define kQQAppKey           @"QQAppID"
#define kQQAppToKen         @"QQAppToken"
@interface NSBundle (Xib)
+ (id)objectForClass:(Class)className inNib:(NSString*)xib owner:(id)owner;

+ (NSURL*)urlForResource:(NSString*)resource;
+ (NSString*)pathForResource:(NSString*)resource;

+ (NSString*)version;


+ (NSString*)applicationSettingForKey:(NSString*)key;

+ (NSString*)testFlightAppToken;
+ (NSString*)baiduMapAppToken;
+ (NSString*)UMengAppToken;
+ (NSString*)WechatAppToken;


@end
