//
//  CSelectIdentityController.m
//  FarmNow
//
//  Created by zheliang on 15/12/1.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CSelectIdentityController.h"
#import "CStoresViewController.h"
#import "CSalesViewController.h"
#import "CSetUserTypeModel.h"

@interface CSelectIdentityController ()

@end

@implementation CSelectIdentityController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.title = @"选择身份";
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
- (IBAction)farmerClick:(id)sender {
	CSetUserTypeParams* params = [CSetUserTypeParams new];
	params.type = @"farmer";
	[MBProgressHUD showHUDAddedTo:self.view animated:YES];
	[CSetUserTypeModel requestWithParams:POST params:params completion:^(id model, JSONModelError *err) {
		[MBProgressHUD hideHUDForView:self.view animated:YES];
		if (model && err == nil) {
			[MBProgressHUD alert:@"注册成功"];
			[self dismissViewControllerAnimated:YES completion:nil];
		}
		else
		{
			[MBProgressHUD alert:@"设置关系失败"];

		}
	}];
}

- (IBAction)retailerClick:(id)sender {
    CSetUserTypeParams* params = [CSetUserTypeParams new];
    params.type = @"retailer";
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [CSetUserTypeModel requestWithParams:POST params:params completion:^(id model, JSONModelError *err) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (model && err == nil) {
            CStoresViewController* controller = [self.storyboard controllerWithID:@"CStoresViewController"];
            [self.navigationController pushViewController:controller animated:YES];
        }
        else
        {
            [MBProgressHUD alert:@"设置关系失败"];
            
        }
    }];
}

- (IBAction)salesClick:(id)sender {
    CSetUserTypeParams* params = [CSetUserTypeParams new];
    params.type = @"sales";
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [CSetUserTypeModel requestWithParams:POST params:params completion:^(id model, JSONModelError *err) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (model && err == nil) {
            CSalesViewController* controller = [self.storyboard controllerWithID:@"CSalesViewController"];
            [self.navigationController pushViewController:controller animated:YES];
        }
        else
        {
            [MBProgressHUD alert:@"设置关系失败"];
        }
    }];
}

@end
