//
//  CRecommendController2.m
//  FarmNow
//
//  Created by zheliang on 15/11/7.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CRecommendController2.h"
#import "CSetRefModel.h"

@interface CRecommendController2 ()
@property (weak, nonatomic) IBOutlet UITextField *codeField;

@end

@implementation CRecommendController2

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
- (IBAction)doneClick:(id)sender {
	if (self.codeField.text == nil || self.codeField.text.length == 0) {
		[MBProgressHUD alert:@"请填写邀请码"];
		return;
	}
	CSetRefParams* params = [CSetRefParams new];
	params.refcode = self.codeField.text;
	[CSetRefModel requestWithParams:POST params:params completion:^(id model, JSONModelError *err) {
		if (model && err== nil) {
			[MBProgressHUD alert:@"发送成功"];
		}
	}];

}

@end