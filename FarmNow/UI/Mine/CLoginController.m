//
//  CLoginController.m
//  FarmNow
//
//  Created by zheliang on 15/10/24.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CLoginController.h"
#import "sdkCall.h"
#import "CQQAuthRegLogModel.h"
#import "CWeiXinAuthRegLogModel.h"
#import "WXApi.h"
#import "CIdentifyingCodeController.h"
#import "CPersonalCache.h"
#import "CCheckUserModel.h"
#import "CIsPassSetModel.h"
#import "CPasswordViewController.h"
#import "CSelectIdentityController.h"
#import "Global.h"

@interface CLoginController ()
@property (weak, nonatomic) IBOutlet UIButton *qqLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *wxLoginBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;

@end

@implementation CLoginController

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	[self centerImageAndTitle:self.qqLoginBtn];
	[self centerImageAndTitle:self.wxLoginBtn];
	
	if (SharedAPPDelegate.showQQLogin) {
		self.qqLoginBtn.hidden = NO;
	}
	else
	{
		self.qqLoginBtn.hidden = YES;

	}
	
	if (SharedAPPDelegate.showWXLogin) {
		self.wxLoginBtn.hidden = NO;
	}
	else
	{
		self.wxLoginBtn.hidden = YES;
	}
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessed) name:kLoginSuccessed object:[sdkCall getinstance]];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginFailed) name:kLoginFailed object:[sdkCall getinstance]];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getUserInfo:) name:kGetUserInfoResponse object:[sdkCall getinstance]];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getWxUserInfo:) name:kWXGetUserInfoResponse object:nil];


}
- (IBAction)nextBtnClick:(id)sender {
	if (self.phoneField.text.length > 0) {
		
		__weak CLoginController* weakSelf = self;
		CCheckUserParams* params = [CCheckUserParams new];
		params.cellphone = self.phoneField.text;
		[CCheckUserModel requestWithParams:params completion:^(CCheckUserModel* model, JSONModelError *err) {
			if (model && err == nil) {
				//用户注册了
				if (model.data == YES) {
					CIsPassSetParams* param = [CIsPassSetParams new];
					param.cellphone = weakSelf.phoneField.text;
					[CIsPassSetModel requestWithParams:params completion:^(CIsPassSetModel* model, JSONModelError *err) {
						if (model && err == nil) {
							//设置了密码
							if (model.data) {
								CPasswordViewController* controller = [self.storyboard controllerWithID:@"CPasswordViewController"];
								controller.cellphone = weakSelf.phoneField.text;
								[self.navigationController pushViewController:controller animated:YES];
							}
							//没有设置密码
							else{
								[weakSelf gotoIdentifyingController];
							}
						}
					}];
				}
				//用户注册了
				else
				{
					[weakSelf gotoIdentifyingController];
				}
			}
		}];

	}
}

- (void)gotoIdentifyingController
{
	CIdentifyingCodeController* controller = [self.storyboard controllerWithID:@"CIdentifyingCodeController"];
	controller.phoneNumber = self.phoneField.text;
	[self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)cancel:(id)sender {
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)qqLogin:(id)sender {
	NSArray* permissions = [NSArray arrayWithObjects:kOPEN_PERMISSION_GET_INFO, kOPEN_PERMISSION_GET_USER_INFO, kOPEN_PERMISSION_GET_SIMPLE_USER_INFO, nil];
	
	[[[sdkCall getinstance] oauth] authorize:permissions inSafari:NO];
}

- (IBAction)weixinLogin:(id)sender
{
	[self sendAuthRequest];
}

-(void)sendAuthRequest
{
	SendAuthReq* req =[[SendAuthReq alloc ] init];
	req.scope = kWXScope;
	req.state = kWXAuthState ;
	[WXApi sendReq:req];
}

#pragma mark message
- (void)getUserInfo:(NSNotification*)sender
{
	if (sender && [sender isKindOfClass:[NSNotification class]] && sender.object) {
		NSDictionary* userInfo = sender.userInfo;
		if (userInfo && [userInfo isKindOfClass:[NSDictionary class]]) {
			APIResponse* response = userInfo[@"kResponse"];
			if (response) {
				CQQAuthRegLogParams* params = [CQQAuthRegLogParams new];

				params.qqtoken = [[sdkCall getinstance] oauth].openId;
				params.avater = response.jsonResponse[@"figureurl_qq_2"];
				params.username = response.jsonResponse[@"nickname"];
				[CQQAuthRegLogModel requestWithParams:POST params:params completion:^(CQQAuthRegLogModel* model, JSONModelError *err) {
					if (model && err==nil) {
						[MBProgressHUD alert:@"登录成功！" ];
						[[CPersonalCache defaultPersonalCache] saveCacheUserInfo:model.data];
						if (model.data.userType == nil) {
							CSelectIdentityController* controller = [self.storyboard controllerWithID:@"CSelectIdentityController"];
							[self.navigationController pushViewController:controller animated:YES];
						}
						else
						{
							[self dismissViewControllerAnimated:YES completion:nil];
						}
					}

				}];
			}
		}

	}

}

- (void)getWxUserInfo:(NSNotification*)sender
{
	[[CPersonalCache defaultPersonalCache] cacheCookie];
	if (sender && [sender isKindOfClass:[NSNotification class]] && sender.object == nil) {
		NSDictionary* userInfo = sender.userInfo;
		if (userInfo && [userInfo isKindOfClass:[NSDictionary class]]) {
				CWeiXinAuthRegLogParams* params = [CWeiXinAuthRegLogParams new];
				
				params.weixintoken = userInfo[@"openid"];
				params.avater = userInfo[@"headimgurl"];
				params.username = userInfo[@"nickname"];
			[CWeiXinAuthRegLogModel requestWithParams:POST params:params completion:^(CQQAuthRegLogModel* model, JSONModelError *err) {
					if (model && err==nil && [model.respCode isEqualToString:@"200"]) {
						[MBProgressHUD alert:@"登录成功！" ];
						[[CPersonalCache defaultPersonalCache] saveCacheUserInfo:model.data];
						if (model.data.userType == nil) {
							CSelectIdentityController* controller = [self.storyboard controllerWithID:@"CSelectIdentityController"];
							[self.navigationController pushViewController:controller animated:YES];
						}
						else
						{
							[self dismissViewControllerAnimated:YES completion:nil];
						}

					}

				}];
		}
		
	}
}

- (void)loginSuccessed
{
	[[CPersonalCache defaultPersonalCache] cacheCookie];
	[[[sdkCall getinstance] oauth] getUserInfo];
//	if (NO == _isLogined)
//	{
//		_isLogined = YES;
//	}
//	
//	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"结果" message:@"登录成功" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
//	[alertView show];
//	
//	NSArray *arrayCell = [[self tableView] visibleCells];
//	for (id cell in arrayCell)
//	{
//		[[cell textLabel] setEnabled:_isLogined];
//	}
}

- (void)loginFailed
{
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"结果" message:@"登录失败" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
	[alertView show];
}

- (void)centerImageAndTitle:(UIButton*)button
{
	CGFloat spacing = 6.0;

	// get the size of the elements here for readability
	CGSize imageSize = button.imageView.frame.size;
	CGSize titleSize = button.titleLabel.frame.size;
 
	// get the height they will take up as a unit
	CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
 
	// raise the image and push it right to center it
	button.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
 
	// lower the text and push it left to center it
	button.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (totalHeight - titleSize.height),0.0);
}
@end
