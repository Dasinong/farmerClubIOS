//
//  CRecommendController1.m
//  FarmNow
//
//  Created by zheliang on 15/11/7.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CRecommendController1.h"
#import "CPersonalCache.h"
#import "CSetRefModel.h"
#import "CRefappModel.h"

@interface CRecommendController1 ()
@property (weak, nonatomic) IBOutlet UITextField *jigouField;
@property (weak, nonatomic) IBOutlet UIButton *bindBtn;
@property (weak, nonatomic) IBOutlet UIButton *forgetBtn;
@property (weak, nonatomic) IBOutlet UILabel *codeLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;

@end

@implementation CRecommendController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	CUserObject* userInfo = [[CPersonalCache defaultPersonalCache] cacheUserInfo];
	if (userInfo) {
		self.codeLabel.text = userInfo.refcode;
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
- (IBAction)bindClick:(id)sender {
	if (self.jigouField.text == nil || self.jigouField.text.length == 0) {
		[MBProgressHUD alert:@"请填写机构代码"];
		return;
	}
	CSetRefParams* params = [CSetRefParams new];
	params.refcode = self.jigouField.text;
	[CSetRefModel requestWithParams:POST params:params completion:^(id model, JSONModelError *err) {
		if (model && err== nil) {
			[MBProgressHUD alert:@"绑定成功"];
		}
	}];
}

- (IBAction)forgetClick:(id)sender {
	SCLAlertView *alert = [[SCLAlertView alloc] init];
	[alert showInfo:self title:nil subTitle:@"机构代码为四位数英文字母，如果遗失请联系公司项目负责人，不要随便填写其他公司的代码哦" closeButtonTitle:@"关闭" duration:0];
}

- (IBAction)sendClick:(id)sender {
	if (self.phoneField.text && self.phoneField.text.length == 0) {
		[MBProgressHUD alert:@"请填写手机号"];
		return;
	}
	CRefappParams* params = [CRefappParams new];
	params.cellPhones = self.phoneField.text;
	[CRefappModel requestWithParams:POST params:params completion:^(id model, JSONModelError *err) {
		if (model && err== nil) {
			[MBProgressHUD alert:@"发送成功"];
		}
	}];
}

@end
