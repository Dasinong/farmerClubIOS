//
// CResponseBase.m
//
// Created by pre-team on 14-4-9.
// Copyright (c) 2014年 pre-team. All rights reserved.
//

#import "CResponseBase.h"
#import <AFNetworking/AFNetworking.h>
#import <objc/runtime.h>
#import "CPersonalCache.h"

const NSString*    kResponseSuccess = @"200";

@implementation NSObject (Request)

- (NSMutableDictionary*)requests
{
    NSMutableDictionary   *requests = objc_getAssociatedObject( self, @selector(requests) );

    if (!requests)
    {
        requests = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, @selector(requests), requests, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }

    return requests;
} /* requests */

@end

@implementation CResponseModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
	if ([propertyName isEqualToString:@"respCode"]) {
		return YES;
	}
	return NO;
}
+ (void)requestWithParams:(CRequestBaseParams*)params
               completion:(JSONModelBlock)completeBlock
{
 #if 0
    [[HSRequest shared_] getObjectFromPath:[[params class] path]
                                withParams:params
                               objectClass:[self class]
                                completion:completeBlock];
 #else
    [[self class] getWithParams:params completion:completeBlock];
 #endif
} /* requestWithParams */

+ (void)requestWithParams:(REQUEST_METHOD)method params:(CRequestBaseParams*)params completion:(JSONModelBlock)completeBlock
{
    if (method == GET) {
        [[self class] getWithParams:params completion:completeBlock];
    }
    else if(method == POST)
    {
        [[self class] postWithParams:params attachments:nil completion:completeBlock];
    }
}
- (NSString*)errorMessageWithError:(NSError*)error
{
    if ([self.respCode isEqualToString: kResponseSuccess])
    {
        return nil;
    }

    return self.message ? self.message : [error localizedDescription];
}

+ (id)manager
{
    static AFHTTPRequestOperationManager   *manager = nil;
    static dispatch_once_t                  onceToken;

    dispatch_once(&onceToken, ^{
        manager = [AFHTTPRequestOperationManager manager];
    });

    return manager;
}

+ (JSONModelError*)jsonModelError:(NSError*)error
{
    JSONModelError   *jsonError = [JSONModelError errorWithDomain:error.domain code:error.code userInfo:error.userInfo];

    return jsonError;
}

+ (void)success:(AFHTTPRequestOperation*)operation object:(id)responseObject completion:(JSONModelBlock)completeBlock
{
    if (!completeBlock)
    {
        return;
    }
	Info(@"result=%@",responseObject);
    
    if (responseObject[@"accessToken"]) {
        // 在这里把AccessToken存入
        NSUserDefaults *userDefaults = USER_DEFAULTS;
        [userDefaults setObject:responseObject[@"accessToken"] forKey:@"accessToken"];
        [userDefaults synchronize];
    }
    
    if (responseObject[@"clientConfig"]) {
        // 客户端配置
        NSUserDefaults *userDefaults = USER_DEFAULTS;
        [userDefaults setObject:responseObject[@"clientConfig"] forKey:@"clientConfig"];
        [userDefaults synchronize];
    }
    
    if (responseObject && [responseObject isKindOfClass:[NSDictionary class]])
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSError *error = nil;

            id model = [[[self class] alloc] initWithDictionary:responseObject error:&error];
            if (model && !error)
            {
                dispatch_async( dispatch_get_main_queue(), ^{
//					if (![((CResponseModel*)model).respCode isEqualToString:@"200"] && ((CResponseModel*)model).message.length >0) {
//						[MBProgressHUD alert:((CResponseModel*)model).message];
//					}
//                    if ([((CResponseModel*)model).respCode isEqualToString:@"2"]|| [((CResponseModel*)model).respCode isEqualToString: @"1"]) {
//                        
//                        nc_post(SessionExpired, nil);
//                        return;
//                    }
		
					CResponseModel* retModel = (CResponseModel*)model;

					if ([retModel.respCode isEqualToString:@"100"] || [retModel.respCode isEqualToString:@"110"]) {
						[[CPersonalCache defaultPersonalCache] clearUserInfo];
						[MBProgressHUD alert:@"您没有登录或登录已过期，请重新登录"];
						UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
						UINavigationController* naviController = [storyboard controllerWithID:@"loginNavigationController"];
						UINavigationController* currentNavController = SharedAPPDelegate.currentController;
						UIViewController* topController = currentNavController;
						if (currentNavController.presentedViewController) {
							topController = currentNavController.presentedViewController;
						}
						else if ([currentNavController isKindOfClass:[UINavigationController class]]) {
							topController = [currentNavController topViewController];
						}
						
						
						[topController presentViewController:naviController animated:YES completion:nil];
						
					}
					if (retModel.respCode == nil) {
						completeBlock(model, nil);
						return ;
					}
					if (![retModel.respCode isEqualToString:@"200"])
					{
						completeBlock(nil, nil);
                        [MBProgressHUD alert:[model errorMessage]];

						return ;
					}
                    completeBlock(model, nil);
                });
            }
            else
            {
                // 解析失败,构建HSResponseModel对象获取信息
                NSError *baseError = nil;
                CResponseModel *errorModel = [[CResponseModel alloc] initWithDictionary:responseObject error:&baseError ];
                
                if (baseError) {
                    Error(@"%@",[baseError localizedDescription]);
                }

                dispatch_async( dispatch_get_main_queue(), ^{
					CResponseModel* retModel = (CResponseModel*)errorModel;
					if ([retModel.respCode isEqualToString:@"100"] || [retModel.respCode isEqualToString:@"110"] ) {
						[[CPersonalCache defaultPersonalCache] clearUserInfo];

						[MBProgressHUD alert:@"您没有登录或登录已过期，请重新登录"];
						UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
						UINavigationController* naviController = [storyboard controllerWithID:@"loginNavigationController"];
						UINavigationController* currentNavController = SharedAPPDelegate.currentController;
						UIViewController* topController = currentNavController;
						if (currentNavController.presentedViewController) {
							topController = currentNavController.presentedViewController;
						}
						else if ([currentNavController isKindOfClass:[UINavigationController class]]) {
							topController = [currentNavController topViewController];
						}
						
						
						[topController presentViewController:naviController animated:YES completion:nil];

					}
//					if (errorModel.message.length >0) {
//						[MBProgressHUD alert:errorModel.message];
//					}
//                    if ([errorModel.respCode isEqualToString: @"2"] || [errorModel.respCode isEqualToString: @"1"]) {
//                        
//                        nc_post(SessionExpired, nil);
//                        return;
//                    }
                    
                    if (error) {
                        Error(@"%@",[error localizedDescription]);
                    }
                    
                    completeBlock(errorModel, [self jsonModelError:error]);
                });
            }
        });
    }
    else
    {
        NSError   *error = nil;

        error = operation.error ? : [NSError errorWithDomain:@"" code:-1 userInfo:@{@"desciption":@"无效的返回对象"}];
        completeBlock(nil, [self jsonModelError:error]);
    }
} /* success */

+ (void)failed:(AFHTTPRequestOperation*)operation error:(NSError*)error completion:(JSONModelBlock)completeBlock
{
    if (completeBlock)
    {
        completeBlock(nil, [self jsonModelError:error]);
    }
}

+ (void)getWithParams:(CRequestBaseParams*)params completion:(JSONModelBlock)completeBlock
{
    AFHTTPRequestOperationManager   *manager = [[self class] manager];
//	manager
    NSString                        *URL     = [CRequest generatorGetRequestURLWithParams:params];
    
    
    NSUserDefaults *userDefaults = USER_DEFAULTS;
    if ([userDefaults objectForKey:@"accessToken"]) {
        NSString *accessToken = [[userDefaults objectForKey:@"accessToken"] urlencode];
        if ([URL containsString:@"?"]) {
            URL = [NSString stringWithFormat:@"%@&accessToken=%@", URL, accessToken];
        }
        else {
            URL = [NSString stringWithFormat:@"%@?accessToken=%@", URL, accessToken];
        }
    }
    
	manager.requestSerializer = [AFJSONRequestSerializer serializer];
	manager.responseSerializer = [AFJSONResponseSerializer serializer];
    /* AFHTTPRequestOperation *operation      =*/
    [manager GET:URL parameters:nil success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        [self success:operation object:responseObject completion:completeBlock];
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        [self failed:operation error:error completion:completeBlock];
    }];

    // Info(@"%@", operation);
} /* getWithParams */

+ (void)deleteWithParams:(CRequestBaseParams*)params pathParams:(NSString*)pathParams completion:(JSONModelBlock)completeBlock;
{
	AFHTTPRequestOperationManager   *manager = [[self class] manager];
	//	manager
	NSString                        *URL     =  [NSString stringWithFormat:@"%@/%@",[CRequest generatorRequestURL:params],pathParams];
    
    NSUserDefaults *userDefaults = USER_DEFAULTS;
    if ([userDefaults objectForKey:@"accessToken"]) {
        NSString *accessToken = [[userDefaults objectForKey:@"accessToken"] urlencode];
        if ([URL containsString:@"?"]) {
            URL = [NSString stringWithFormat:@"%@&accessToken=%@&appId=2", URL, accessToken];
        }
        else {
            URL = [NSString stringWithFormat:@"%@?accessToken=%@&appId=2", URL, accessToken];
        }
    }
    
	Info(@"URL:%@", URL);
    
	
//	Info(@"parameters:%@", parameters);
	manager.requestSerializer = [AFJSONRequestSerializer serializer];
	manager.responseSerializer = [AFJSONResponseSerializer serializer];
	/* AFHTTPRequestOperation *operation      =*/
    [manager DELETE:URL parameters:nil success: ^(AFHTTPRequestOperation *operation, id responseObject) {
		[self success:operation object:responseObject completion:completeBlock];
	} failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
		[self failed:operation error:error completion:completeBlock];
	}];

}
+ (void)postWithParams:(id)params
           attachments:(_TYPE(ATTACHMENT) NSArray*)attachments
            completion:(JSONModelBlock)completeBlock
{
    AFHTTPRequestOperationManager   *manager = [[self class] manager];
    NSString                        *URL     = [CRequest generatorRequestURL:params];

	NSDictionary* parameters = [params paramDictionary];
	Info(@"URL:%@", URL);

    NSUserDefaults *userDefaults = USER_DEFAULTS;
    if ([userDefaults objectForKey:@"accessToken"]) {
        NSString *accessToken = [userDefaults objectForKey:@"accessToken"];
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:parameters];
        [dict setObject:accessToken forKey:@"accessToken"];
        [dict setObject:@(2) forKey:@"appId"];
        parameters = dict;
    }
    
	Info(@"parameters:%@", parameters);

	
	/*AFHTTPRequestOperation *operation      =*/
    [manager POST:URL parameters:parameters constructingBodyWithBlock: ^(id < AFMultipartFormData > formData) {
        for (NSDictionary * attachment in attachments)
        {
            NSURL *fileURL = [NSURL fileURLWithPath:attachment[@"path"]];
            NSString *name = attachment[@"name"];

            NSError *error = nil;
            [formData appendPartWithFileURL:fileURL name:name error:&error];
            if (error)
            {
                Error(@"%@", error);
            }
        }
    } success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        [self success:operation object:responseObject completion:completeBlock];
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        [self failed:operation error:error completion:completeBlock];
    }];


    // Info(@"%@", operation);
} /* postWithParams */

+ (void)postWithPath:(NSString*)path
           attachments:(_TYPE(ATTACHMENT) NSArray*)attachments
                params:(NSDictionary*)params
            completion:(JSONModelBlock)completeBlock
{
    AFHTTPRequestOperationManager   *manager = [[self class] manager];
    NSString                        *URL     = [NSString stringWithFormat:@"%@%@", kAPIServer, path];
    
    
    NSUserDefaults *userDefaults = USER_DEFAULTS;
    if ([userDefaults objectForKey:@"accessToken"]) {
        NSString *accessToken = [userDefaults objectForKey:@"accessToken"];
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:params];
        [dict setObject:accessToken forKey:@"accessToken"];
        [dict setObject:@(2) forKey:@"appId"];
        params = dict;
    }
    
    
    /*AFHTTPRequestOperation *operation      =*/ [manager POST:URL parameters:params constructingBodyWithBlock: ^(id < AFMultipartFormData > formData) {
        for (NSDictionary * attachment in attachments)
        {
            NSData *imageData = attachment[@"data"];
            NSString *name = attachment[@"name"];
            NSString *filename = attachment[@"filename"];

            NSError *error = nil;
            [formData appendPartWithFileData:imageData name:name fileName:filename mimeType:@"image/jpeg"];
            if (error)
            {
                Error(@"%@", error);
            }
        }
    } success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        [self success:operation object:responseObject completion:completeBlock];
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        [self failed:operation error:error completion:completeBlock];
    }];
}
- (BOOL)success
{
    return self.respCode == 0;
}

- (NSString*)errorMessage
{
    return (self.respCode != 0) ? self.message : nil;
}

- (NSString*)successMessage
{
    return (self.respCode == 0) ? self.message : nil;
}

@end
