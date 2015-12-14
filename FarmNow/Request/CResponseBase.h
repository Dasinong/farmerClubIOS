//
// CResponseBase.h
//
// Created by pre-team on 14-4-9.
// Copyright (c) 2014年 pre-team. All rights reserved.
//

#import <JSONModel/JSONModelLib.h>
#import "CRequest.h"

typedef enum : NSUInteger {
    GET,
    POST,
	DELETE
} REQUEST_METHOD;
@interface NSObject (Request)
@property (nonatomic, readonly) NSMutableDictionary   *requests;
@end

/**
 *    服务器交互数据
 */
@interface CResponseModel : JSONModel
@property (strong, nonatomic) NSString*         respCode;
@property (nonatomic) NSString          *message;

@property (nonatomic) NSError<Ignore>   *error;
+ (void)requestWithParams:(CRequestBaseParams*)params completion:(JSONModelBlock)completeBlock;
+ (void)requestWithParams:(REQUEST_METHOD)method params:(CRequestBaseParams*)params completion:(JSONModelBlock)completeBlock;
+ (void)postWithPath:(NSString*)path
                attachments:(_TYPE(ATTACHMENT) NSArray*)attachments
                params:(NSDictionary*)params
            completion:(JSONModelBlock)completeBlock;
+ (void)deleteWithParams:(CRequestBaseParams*)params pathParams:(NSString*)pathParams completion:(JSONModelBlock)completeBlock;

- (NSString*)errorMessageWithError:(NSError*)error;
- (BOOL)success;
- (NSString*)errorMessage;
- (NSString*)successMessage;
@end

// post 请求的附件
#define ATTACHMENT(name_, path_) @{name_:path_}
extern const NSString*    kResponseSuccess;
