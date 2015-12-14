//
//  CPasswordViewController.m
//  FarmNow
//
//  Created by zheliang on 15/11/8.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CPasswordViewController.h"
#import "CLoginModel.h"
#import "CPersonalCache.h"
#import "CSelectIdentityController.h"

@interface CPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *passwdField;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@end

@implementation CPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//	self.title = @"修改密码";
    // Do any additional setup after loading the view.
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
- (IBAction)next:(id)sender {
	if (self.passwdField.text == nil || self.passwdField.text.length == 0) {
		[MBProgressHUD alert:@"请输入密码"];
		return;
	}
	CLoginParams* params = [CLoginParams new];
	params.password = self.passwdField.text;
	params.cellphone = self.cellphone;
	[CLoginModel requestWithParams:POST params:params completion:^(CLoginModel* model, JSONModelError *err) {
		if (model && err == nil) {
			[MBProgressHUD alert:@"登录成功" ];
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
		else{
			[MBProgressHUD alert:@"登录失败" ];

		}
	}];
}

@end
