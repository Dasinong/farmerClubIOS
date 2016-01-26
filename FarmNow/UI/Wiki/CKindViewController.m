//
//  CKindViewController.m
//  FarmNow
//
//  Created by zheliang on 15/10/22.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CKindViewController.h"
#import "CSeedViewController.h"
#import "CBrowseVarietyByCropIdModel.h"
#import "CWebViewController.h"
#import "CBrowseCPProductByModelModel.h"
#import "CGetCpprductsByIngredientModel.h"

@interface CKindViewController ()

@end

@implementation CKindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	if (self.type == ePinZhong) {
        self.title                              = self.seedItem.cropName;

        CBrowseVarietyByCropIdParams* params    = [CBrowseVarietyByCropIdParams new];
        params.cropId                           = self.seedItem.cropId ;
		[MBProgressHUD showHUDAddedTo:self.view animated:YES];
		[CBrowseVarietyByCropIdModel requestWithParams:params completion:^(CBrowseVarietyByCropIdModel* model, JSONModelError *err) {
			[MBProgressHUD hideHUDForView:self.view animated:YES];

			if (err == nil && model ) {
        UITableViewModel* talbeModel            = [UITableViewModel new];
				for (CVarietyBrowseObjectModel* object in model.data) {
					[talbeModel addRow:TABLEVIEW_ROW(@"titlecell", object) forSection:0];
				}
				[self updateModel:talbeModel];
			}
		}];
	}
	else if (self.type == eIngredient){
        CBrowseCPProductByModelParams* params   = [CBrowseCPProductByModelParams new];
        params.model                            = self.title;
		[MBProgressHUD showHUDAddedTo:self.view animated:YES];

		[CBrowseCPProductByModelModel requestWithParams:params completion:^(CBrowseCPProductByModelModel* model, JSONModelError *err) {
			[MBProgressHUD hideHUDForView:self.view animated:YES];

			if (err == nil && model ) {
        UITableViewModel* talbeModel            = [UITableViewModel new];
				for (CIngredientBrowseObject* object in model.data) {
					[talbeModel addRow:TABLEVIEW_ROW(@"titlecell", object) forSection:0];
				}
				[self updateModel:talbeModel];
			}
		}];
	}
	else if (self.type == eCpproduct)
	{
        CGetCpprductsByIngredientParams* params = [CGetCpprductsByIngredientParams new];
        params.ingredient                       = self.title;
		[MBProgressHUD showHUDAddedTo:self.view animated:YES];

		[CGetCpprductsByIngredientModel requestWithParams:params completion:^(CGetCpprductsByIngredientModel* model, JSONModelError *err) {
			[MBProgressHUD hideHUDForView:self.view animated:YES];

			if (err == nil && model ) {
        UITableViewModel* talbeModel            = [UITableViewModel new];
				for (CCPProductObject* object in model.data) {
					[talbeModel addRow:TABLEVIEW_ROW(@"titlecell", object) forSection:0];
				}
				[self updateModel:talbeModel];
			}
		}];
	}
	else if (self.type == eSoil){
        NSArray* items                          = @[@"为什么要测土",
						   @"采样须知",
						   @"测土报告解读",
						   @"哪里可以测土?"];
        UITableViewModel* talbeModel            = [UITableViewModel new];
		for (NSString* title in items) {
			[talbeModel addRow:TABLEVIEW_ROW(@"titlecell", title) forSection:0];
		}
		[self updateModel:talbeModel];
	}
	else if (self.type == eXiaoChangShi){

		UITableViewModel* talbeModel            = [UITableViewModel new];
		for (NSString* title in XIAOCHANGSHI_DICT.allKeys) {
			[talbeModel addRow:TABLEVIEW_ROW(@"titlecell", title) forSection:0];
		}
		[self updateModel:talbeModel];
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

- (void)didSelect:(NSIndexPath *)indexPath identifier:(NSString*)identifier data:(id)data
{
	if (self.type == ePinZhong) {
        CVarietyBrowseObjectModel* object       = (CVarietyBrowseObjectModel*)data;
        CWebViewController* webController       = [self.storyboard controllerWithID:@"CWebViewController"];
        webController.address                       = [NSString stringWithFormat:@"%@/ploughHelper/baike?id=%ld&type=%@", kServer, (long)object.varietyId,@"variety"];
        webController.title                     = object.varietyName;
		[self.navigationController pushViewController:webController animated:YES];
	}
	else if (self.type == eIngredient)
	{
        CIngredientBrowseObject* object         = (CIngredientBrowseObject*)data;
        CKindViewController* controller         = [self.storyboard controllerWithID:@"CKindViewController"];
        controller.title                        = object.activeIngredient;
        controller.type                         = eCpproduct;
		[self.navigationController pushViewController:controller animated:YES];
	}
	else if (self.type == eCpproduct){
        CCPProductObject* object                = (CCPProductObject*)data;
        CWebViewController* webController       = [self.storyboard controllerWithID:@"CWebViewController"];
        webController.address                       = [NSString stringWithFormat:@"%@baike?id=%ld&type=%@",kServerAddress, (long)object.id,@"pesticide"];
        webController.title                     = object.name;
		[self.navigationController pushViewController:webController animated:YES];
	}
	else if (self.type == eSoil){
		
		switch (indexPath.row) {
			case 0:
			{
				CWebViewController* webController  = [self.storyboard controllerWithID:@"CWebViewController"];
				webController.title                     = data;
				webController.address = [NSString stringWithFormat:@"%@html/SamplingImportance.html", kAPIServer];
				[self.navigationController pushViewController:webController animated:YES];
			}
    break;
			case 1:
			{
				CWebViewController* webController  = [self.storyboard controllerWithID:@"CWebViewController"];
				webController.title                     = data;
				webController.address = [NSString stringWithFormat:@"%@html/SamplingNotice.html", kAPIServer];
				[self.navigationController pushViewController:webController animated:YES];
			}
    break;
			case 2:
			{
				CWebViewController* webController  = [self.storyboard controllerWithID:@"CWebViewController"];
				webController.title                     = data;
				webController.address = [NSString stringWithFormat:@"%@html/soiltest-sample.html", kAPIServer];
				[self.navigationController pushViewController:webController animated:YES];
			}
    break;
			case 3:
			{
				SCLAlertView *alert = [[SCLAlertView alloc] init];
				[alert showNotice:self title:@"测土服务即将上线" subTitle:@"我们的全国免费测土点,会在近期开放,敬请期待" closeButtonTitle:@"确定" duration:0];
			}
				break;
			default:
    break;
		}

	}
	else if (self.type == eXiaoChangShi)
	{
		NSString* url = XIAOCHANGSHI_DICT[data];
		CWebViewController* webController       = [self.storyboard controllerWithID:@"CWebViewController"];
		webController.address                       = url;
		webController.title                     = data;
		[self.navigationController pushViewController:webController animated:YES];
	}

}

@end
