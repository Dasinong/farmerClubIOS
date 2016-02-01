//
//  CIdentifyingCodeController.m
//  FarmNow
//
//  Created by zheliang on 15/10/26.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CIdentifyingCodeController.h"
#import <SMS_SDK/SMSSDK.h>
#import "CAuthRegLogModel.h"
#import "CPersonalCache.h"
#import "CSelectIdentityController.h"
#import "MZTimerLabel.h"

@interface CIdentifyingCodeController ()
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UITextField *identifyingCodeField;
@property (weak, nonatomic) IBOutlet UILabel *countDownLabel;
@property (weak, nonatomic) IBOutlet UIButton *resendBotton;

@property (strong, nonatomic) MZTimerLabel *timer;
@end

@implementation CIdentifyingCodeController

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.phoneLabel.text = self.phoneNumber;
    [self getVerificationCodeBySMS:nil];
    
    self.timer = [[MZTimerLabel alloc] initWithLabel:self.countDownLabel andTimerType:MZTimerLabelTypeTimer];
    [self.timer setCountDownTime:60];
    [self.timer setTimeFormat:@"接收短信大约需要ss秒"];
    [self.timer startWithEndingBlock:^(NSTimeInterval countTime) {
        self.countDownLabel.hidden = YES;
        self.resendBotton.hidden = NO;
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.identifyingCodeField becomeFirstResponder];
}

- (IBAction)getVerificationCodeBySMS:(id)sender
{
    if (sender) {
        self.countDownLabel.hidden = NO;
        self.resendBotton.hidden = YES;
        [self.timer reset];
        [self.timer start];
    }
    
	[SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneNumber
								   zone:@"+86"
					   customIdentifier:nil
								 result:^(NSError *error)
	 {
		 
		 if (!error)
		 {
			 NSLog(@"验证码发送成功");
			 [MBProgressHUD alert:@"验证码发送成功"];
		 }
		 else
		 {
			 UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"出错啦"
															 message:[error.userInfo objectForKey:@"getVerificationCode"]
															delegate:self
												   cancelButtonTitle:@"确定"
												   otherButtonTitles:nil, nil];
			 [alert show];
		 }
		 
	 }];
}
- (IBAction)nextBtnClick:(id)sender {
	[SMSSDK commitVerificationCode:self.identifyingCodeField.text phoneNumber:self.phoneNumber zone:@"+86" result:^(NSError *error) {
		
		if (!error) {
			
			NSLog(@"验证成功");
			CAuthRegLogParams* params = [CAuthRegLogParams new];
			params.cellphone = self.phoneNumber;
			[CAuthRegLogModel requestWithParams:POST params:params completion:^(CAuthRegLogModel* model, JSONModelError *err) {
				if (model && err== nil) {
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
				else
				{
					[MBProgressHUD alert:@"登录失败"];

				}
			}];
			
		}
		else
		{
			NSDictionary* userinfo = error.userInfo;
			NSString* msg = userinfo[@"commitVerificationCode"];
			if (msg && [msg isKindOfClass:[NSString class]]) {
				[MBProgressHUD alert:msg];

			}
			else
			{
				[MBProgressHUD alert:@"登录失败"];

			}
			
		}
	}];
}

@end
