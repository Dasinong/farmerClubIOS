//
//  CPersonalCache.h
//  FarmNow
//
//  Created by zheliang on 15-06-18.
//  Copyright (c) 2013年 zheliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CUserObject.h"

@interface CPersonalCache : NSObject
+ (CPersonalCache *)defaultPersonalCache;
- (void)cacheCookie;
- (void)reloadCookie;

- (void)reloadCacheValueFromCacheFile;

//用来保存简单的字符串数据
- (NSString *)cacheValueForKey:(NSString *)key;
- (void)saveCacheValue:(NSString *)value forKey:(NSString *)key;
- (NSString *)cacheValueForTag:(NSInteger)tag;
- (void)saveCacheValue:(NSString *)value forTag:(NSInteger)tag;

//用来保存简单的字符串数据
- (void)clearUserInfo;
- (CUserObject *)cacheUserInfo;
- (void)saveCacheUserInfo:(CUserObject *)value;
@end
