//
// CRequestRegister.h
//
// Created by pre-team on 14-5-22.
// Copyright (c) 2014年 pre-team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <AFNetworking/AFNetworking.h>
#import <JSONModel/JSONModelLib.h>


@class CRequestBaseParams;

@interface CRequest : NSObject
/**
 *  生成get请求拼接参数后的URL
 *
 *  @param params 请求参数实例，每个请求应派生CRequestBaseParams
 *
 *  @return 生成的URL
 */
+ ( NSString*)generatorGetRequestURLWithParams:(CRequestBaseParams*)params;

/**
 *  生成请求的URL 不拼接参数
 *
 *  @param params 请求参数实例，每个请求应派生CRequestBaseParams
 *
 *  @return 请求的URL(不拼接参数)
 */
+ ( NSString*)generatorRequestURL:(CRequestBaseParams*)params;
@end

@protocol CRequestParams <NSObject>
+ (NSString*)path;
+ (NSString*)serverAddress;
- (NSString*)paramString;
- (NSDictionary*)paramDictionary;
- (id)valueForKey:(id)key;
@optional
/*更新用户名等动态数据*/
- (void)updateDynamicValue;
+ (NSString*)stringDescriptionForObject:(id)object;
/**
 *  自动生成请求参数时忽略类变量
 *
 *  @param propertyName 类变量名称
 *
 *  @return 当return YES时 propertyName对应的类变量将不加入请求参数，反之则假如请求参数.
 */
+(BOOL)propertyIsIgnored:(NSString*)propertyName;

@end
@interface CRequestBaseParams : NSObject <CRequestParams>

- (NSString*)paramString;
- (NSDictionary*)paramDictionary;
@end
