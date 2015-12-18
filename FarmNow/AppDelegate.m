//
//  AppDelegate.m
//  FarmNow
//
//  Created by zheliang on 15/10/15.
//  Copyright (c) 2015年 zheliang. All rights reserved.
//

#import "AppDelegate.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import <SMS_SDK/SMSSDK.h>
#import "CPersonalCache.h"
#import "CRemoteControModel.h"

@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	// Override point for customization after application launch.
	self.showQQLogin = YES;
	self.showWXLogin = YES;
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
	[[CPersonalCache defaultPersonalCache] reloadCookie];
	[WXApi registerApp:kWXAPP_ID withDescription:@"weixin"];
	[SMSSDK registerApp:kMOBSMSAPP_ID withSecret:kMOBSMSAPP_SECRET];
	
	NSString* version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
	CRemoteControParams* params = [CRemoteControParams new];
	params.appId = @"2";
	params.version = version;
	[CRemoteControModel requestWithParams:params completion:^(CRemoteControModel* model, JSONModelError *err) {
		if (model && err == nil) {
					self.showQQLogin = model.qqLogin;
					self.showWXLogin = model.weixinLogin;
		}
	}];
	return YES;
}
-(UINavigationController*) currentController
{
	UIViewController *selectViewCtrl = self.tabBarController.selectedViewController;
	if ([selectViewCtrl isKindOfClass:[UISplitViewController class]]) {
		if (!isiOS8) return nil;
		UISplitViewController *theSplitCtrl = (UISplitViewController*) self.tabBarController.selectedViewController;
		NSArray *viewCtrls = theSplitCtrl.viewControllers;
		if (!viewCtrls.count) return nil;
		UINavigationController *primaryViewController = [viewCtrls lastObject];
		return primaryViewController;
	} else if ([selectViewCtrl isKindOfClass:[UINavigationController class]]) {
		return (UINavigationController *) self.tabBarController.selectedViewController;
	}
	return nil;
}
- (void)initSkin
{
//	[UINavigationBar appearance].barTintColor = gl
}
//授权后回调 WXApiDelegate
-(void)onResp:(BaseReq *)resp
{
	/*
	 ErrCode ERR_OK = 0(用户同意)
	 ERR_AUTH_DENIED = -4（用户拒绝授权）
	 ERR_USER_CANCEL = -2（用户取消）
	 code    用户换取access_token的code，仅在ErrCode为0时有效
	 state   第三方程序发送时用来标识其请求的唯一性的标志，由第三方程序调用sendReq时传入，由微信终端回传，state字符串长度不能超过1K
	 lang    微信客户端当前语言
	 country 微信用户当前国家信息
	 */
	SendAuthResp *aresp = (SendAuthResp *)resp;
	if (aresp.errCode== 0) {
		NSString *code = aresp.code;
		
//		NSDictionary *dic = @{@"code":code};
		[self getWXAccess_token:code];
	}
}

-(void)getWXAccess_token:(NSString*)code
{
	//https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=SECRET&code=CODE&grant_type=authorization_code
	
	NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",kWXAPP_ID,kWXAPP_SECRET,code];
	
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		NSURL *zoneUrl = [NSURL URLWithString:url];
		NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
		NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
		dispatch_async(dispatch_get_main_queue(), ^{
			if (data) {
				NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
				/*
				 {
				 "access_token" = "OezXcEiiBSKSxW0eoylIeJDUKD6z6dmr42JANLPjNN7Kaf3e4GZ2OncrCfiKnGWiusJMZwzQU8kXcnT1hNs_ykAFDfDEuNp6waj-bDdepEzooL_k1vb7EQzhP8plTbD0AgR8zCRi1It3eNS7yRyd5A";
				 "expires_in" = 7200;
				 openid = oyAaTjsDx7pl4Q42O3sDzDtA7gZs;
				 "refresh_token" = "OezXcEiiBSKSxW0eoylIeJDUKD6z6dmr42JANLPjNN7Kaf3e4GZ2OncrCfiKnGWi2ZzH_XfVVxZbmha9oSFnKAhFsS0iyARkXCa7zPu4MqVRdwyb8J16V8cWw7oNIff0l-5F-4-GJwD8MopmjHXKiA";
				 scope = "snsapi_userinfo,snsapi_base";
				 }
				 */
				[self getWXUserInfoWithToken:[dic objectForKey:@"access_token"] openId:[dic objectForKey:@"openid"]];
				
			}
		});
	});
}

-(void)getWXUserInfoWithToken:(NSString*)token openId:(NSString*)openId
{
	// https://api.weixin.qq.com/sns/userinfo?access_token=ACCESS_TOKEN&openid=OPENID
	
	NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",token,openId];
	
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		NSURL *zoneUrl = [NSURL URLWithString:url];
		NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
		NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
		dispatch_async(dispatch_get_main_queue(), ^{
			if (data) {
				NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
				NSMutableDictionary *newDic = [NSMutableDictionary dictionaryWithDictionary:dic];
				[newDic setObject:token forKey:@"token"];
//				NSLog(@"%@",dic);
				[[NSNotificationCenter defaultCenter] postNotificationName :kWXGetUserInfoResponse object : nil userInfo : newDic];				/*
				 {
				 city = Haidian;
				 country = CN;
				 headimgurl = "http://wx.qlogo.cn/mmopen/FrdAUicrPIibcpGzxuD0kjfnvc2klwzQ62a1brlWq1sjNfWREia6W8Cf8kNCbErowsSUcGSIltXTqrhQgPEibYakpl5EokGMibMPU/0";
				 language = "zh_CN";
				 nickname = "xxx";
				 openid = oyAaTjsDx7pl4xxxxxxx;
				 privilege =     (
				 );
				 province = Beijing;
				 sex = 1;
				 unionid = oyAaTjsxxxxxxQ42O3xxxxxxs;
				 }
				 */
				
				}
		});
		
	});
}
- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
	return [WXApi handleOpenURL:url delegate:self] || [TencentOAuth HandleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
	return [WXApi handleOpenURL:url delegate:self] || [TencentOAuth HandleOpenURL:url];
}

@end
