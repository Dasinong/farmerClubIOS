//
//  CSalesViewController.m
//  FarmNow
//
//  Created by zheliang on 15/11/22.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CSalesViewController.h"
#import "CInstitutionEmployeeApplicationsModel.h"

@interface CSalesViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *telField;
@property (weak, nonatomic) IBOutlet UITextField *codeField;
@property (weak, nonatomic) IBOutlet UITextField *postField;
@property (weak, nonatomic) IBOutlet UITextField *areaField;

@end

@implementation CSalesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
- (IBAction)submit:(id)sender {
	if (self.nameField.text == nil || self.nameField.text.length == 0) {
		[MBProgressHUD alert:@"请填写姓名"];
		return;
	}
	if (self.telField.text == nil || self.telField.text.length == 0) {
		[MBProgressHUD alert:@"请填写手机"];
		return;
	}
	if (self.codeField.text == nil || self.codeField.text.length == 0) {
		[MBProgressHUD alert:@"请填写合作机构代码"];
		return;
	}
	if (self.postField.text == nil || self.postField.text.length == 0) {
		[MBProgressHUD alert:@"请填写职务"];
		return;
	}
	if (self.areaField.text == nil || self.areaField.text.length == 0) {
		[MBProgressHUD alert:@"请填写业务区域"];
		return;
	}
	CInstitutionEmployeeApplicationsParams* params = [CInstitutionEmployeeApplicationsParams new];
	params.contactName = self.nameField.text;
	params.cellphone = self.telField.text;
	params.code = self.codeField.text;
	params.title = self.postField.text;
	params.region = self.areaField.text;
	
	[CInstitutionEmployeeApplicationsModel requestWithParams:POST params:params completion:^(id model, JSONModelError *err) {
		if (model && err == nil) {
			[MBProgressHUD alert:@"提交成功"];
			if (SharedAPPDelegate.currentController.presentedViewController) {
				[self dismissViewControllerAnimated:YES completion:nil];

			}
			else
			{
				[self.navigationController popToRootViewControllerAnimated:YES];
			}
		}
		else
		{
			[MBProgressHUD alert:@"提交失败"];

		}
	}];
}

@end
