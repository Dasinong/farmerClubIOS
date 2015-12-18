//
//  CChangePasswordController.m
//  FarmNow
//
//  Created by zheliang on 15/11/8.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CChangePasswordController.h"
#import "CPersonalCache.h"
#import "CUpdatePasswordModel.h"

@interface CChangePasswordController ()
@property (weak, nonatomic) IBOutlet UITextField *oldPasswordField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *passwordFieldTop;

@end

@implementation CChangePasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	CUserObject* userInfo = [[CPersonalCache defaultPersonalCache] cacheUserInfo];
	if (!userInfo.isPassSet) {
		self.oldPasswordField.hidden = YES;
		self.passwordFieldTop.constant = 20.f;
	}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)doneClick:(id)sender {
	if (self.passwordField.text == nil || self.passwordField.text.length == 0) {
		[MBProgressHUD alert:@"请输入新密码"];
		return;
	}
	if (![self.passwordField.text isEqualToString:self.passwordField2.text]) {
		[MBProgressHUD alert:@"确认新密码错误，请重新输入"];
		return;
	}
	CUpdatePasswordParams* params = [CUpdatePasswordParams new];
	params.oPassword = self.oldPasswordField.text;
	params.nPassword = self.passwordField.text;
	[CUpdatePasswordModel requestWithParams:POST params:params completion:^(CUpdatePasswordModel* model, JSONModelError *err) {
		if (model && err == nil) {
			[[CPersonalCache defaultPersonalCache] cacheCookie];

			[MBProgressHUD alert:@"修改成功"];
			CUserObject* userInfo = [[CPersonalCache defaultPersonalCache] cacheUserInfo];
			if (userInfo.isPassSet == NO) {
				userInfo.isPassSet = YES;
				[[CPersonalCache defaultPersonalCache] saveCacheUserInfo:userInfo];
			}
			[self.navigationController popViewControllerAnimated:YES];
		}
	}];
	
}

@end
