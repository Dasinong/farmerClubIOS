//
//  CPersonalCache.m
//  FarmNow
//
//  Created by zheliang on 15-06-18.
//  Copyright (c) 2013年 zheliang. All rights reserved.
//

#import "CPersonalCache.h"

#define kCacheFileName @"cachekeyvalue"
#define kUSER_INFO @"userInfo"

@interface CPersonalCache ()
{
    NSMutableDictionary *_cacheValueDict;
}
@property (strong, nonatomic) CUserObject* userObject;
@end

@implementation CPersonalCache
static CPersonalCache * _defaultPersonalCache = nil;

+ (CPersonalCache *)defaultPersonalCache
{
	if(nil == _defaultPersonalCache)
	{
		_defaultPersonalCache = [[CPersonalCache alloc] init];
	}
	
	return _defaultPersonalCache;
}

+ (NSString *)cacheDirForPersonal
{
	NSString * dir = [CPersonalCache getAppDocPath];
	if(NO == [[NSFileManager defaultManager] fileExistsAtPath:dir])
	{
		[[NSFileManager defaultManager] createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:nil];
	}
	
	return dir;
}

+ (NSString*) getAppDocPath
{
	static NSString* sAPPDOCPATH = nil;
	if (sAPPDOCPATH == nil)
	{
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		if ([paths count] > 0)
		{
			sAPPDOCPATH = [[NSString alloc] initWithString:[paths objectAtIndex:0]];
		}
	}
	return sAPPDOCPATH;
}



+ (NSString*)cachePathForCacheKeyValue
{
    return [NSString stringWithFormat:@"%@/"kCacheFileName, [self cacheDirForPersonal]];
}


- (void)reloadCacheValueFromCacheFile
{
	if(_cacheValueDict)
	{
		_cacheValueDict = nil;
	}
	
	NSString* cacheValuePath = [CPersonalCache cachePathForCacheKeyValue];
	if ([[NSFileManager defaultManager] fileExistsAtPath:cacheValuePath])
	{
		_cacheValueDict = [[NSMutableDictionary alloc] initWithContentsOfFile:cacheValuePath];
	}
	else
	{
		_cacheValueDict = [[NSMutableDictionary alloc] init];
	}
}

- (id)init
{
	self = [super init];
	if(self)
	{
        [self reloadCacheValueFromCacheFile];
	}
	return self;
}



- (NSString *)cacheValueForKey:(NSString *)key
{
	if(nil == key || NO == [key isKindOfClass:[NSString class]])
	{
		return nil;
	}
	
	return [_cacheValueDict valueForKey:key];
}

- (void)saveCacheValue:(NSString *)value forKey:(NSString *)key
{
	if(nil == key || NO == [key isKindOfClass:[NSString class]])
	{
		return;
	}
	
	if(value != nil && [value isKindOfClass:[NSString class]] == NO)
	{
		return;
	}
	
	[_cacheValueDict setValue:value forKey:key];
	[_cacheValueDict writeToFile:[CPersonalCache cachePathForCacheKeyValue] atomically:YES];
}

- (NSString *)cacheValueForTag:(NSInteger)tag
{
    return [self cacheValueForKey:[NSString stringWithFormat:@"%ld", (long)tag]];
}

- (void)saveCacheValue:(NSString *)value forTag:(NSInteger)tag
{
    [self saveCacheValue:value forKey:[NSString stringWithFormat:@"%ld", (long)tag]];
}

- (void)clearUserInfo
{
    NSUserDefaults *userDefaults = USER_DEFAULTS;
    [userDefaults removeObjectForKey:@"accessToken"];
    [userDefaults removeObjectForKey:@"clientConfig"];
    [userDefaults synchronize];
    
	self.userObject = nil;
	[_cacheValueDict removeObjectForKey:kUSER_INFO];
	[_cacheValueDict writeToFile:[CPersonalCache cachePathForCacheKeyValue] atomically:YES];
    
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:kServerAddress]];
    for (NSHTTPCookie *cookie in cookies)
    {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
    
    // 发送注销成功通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notification_signout" object:nil];
}

- (CUserObject *)cacheUserInfo
{
	if (self.userObject == nil) {
		NSData* jsonData =  [_cacheValueDict valueForKey:kUSER_INFO];
		if (jsonData) {
			self.userObject = [[CUserObject alloc] initWithData:jsonData error:nil];
		}
		else{
			return nil;
		}
	}

	return self.userObject;
}

- (void)saveCacheUserInfo:(CUserObject *)value
{
	self.userObject = value;
	
	if(value != nil && [value isKindOfClass:[CUserObject class]] == NO)
	{
		return;
	}
    
    if ([value.weixintoken isKindOfClass:[NSNull class]]) {
        value.weixintoken = nil;
    }
    if ([value.qqtoken isKindOfClass:[NSNull class]]) {
        value.qqtoken = nil;
    }
    
	[_cacheValueDict setValue:[value toJSONData] forKey:kUSER_INFO];
	[_cacheValueDict writeToFile:[CPersonalCache cachePathForCacheKeyValue] atomically:YES];
    
    // 发送登录成功通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notification_signin" object:nil];
}
@end
