//
//  CStoresViewController.m
//  FarmNow
//
//  Created by zheliang on 15/11/22.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CStoresViewController.h"
#import <ActionSheetPicker.h>
#import <FMDatabase.h>
#import "CGetLocationModel.h"
#import "CStoresModel.h"

@interface CStoresViewController ()
@property (weak, nonatomic) IBOutlet UITextField *storeName;
@property (weak, nonatomic) IBOutlet UIButton *seedCheck;
@property (weak, nonatomic) IBOutlet UIButton *huafeiCheck;
@property (weak, nonatomic) IBOutlet UIButton *nongyaoCheck;
@property (weak, nonatomic) IBOutlet UIButton *pifaCheck;
@property (weak, nonatomic) IBOutlet UITextField *telLabel;
@property (weak, nonatomic) IBOutlet UITextField *contactLabel;
@property (weak, nonatomic) IBOutlet UITextField *descLabel;
@property (weak, nonatomic) IBOutlet UIButton *shengBtn;
@property (weak, nonatomic) IBOutlet UIButton *shiBtn;
@property (weak, nonatomic) IBOutlet UIButton *quBtn;
@property (weak, nonatomic) IBOutlet UIButton *zhenBtn;
@property (weak, nonatomic) IBOutlet UIButton *cunBtn;

@property (weak, nonatomic) IBOutlet UITextField *addressField;

@property (strong, nonatomic) NSString* sheng;
@property (strong, nonatomic) NSString* shi;
@property (strong, nonatomic) NSString* qu;
@property (strong, nonatomic) NSString* zhen;
@property (strong, nonatomic) NSString* cun;

@property (strong, nonatomic) NSArray* shengContents;
@property (strong, nonatomic) NSArray* shiContents;
@property (strong, nonatomic) NSArray* quContents;
@property (strong, nonatomic) NSArray* zhenContents;
@property (strong, nonatomic) NSDictionary* cunDic;

@end

@implementation CStoresViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	self.shengBtn.layer.borderWidth =
	self.shiBtn.layer.borderWidth =
	self.quBtn.layer.borderWidth =
	self.zhenBtn.layer.borderWidth =
	self.cunBtn.layer.borderWidth =

	self.addressField.layer.borderWidth = 1.0;
	self.shengBtn.layer.borderColor =
	self.shiBtn.layer.borderColor =
	self.quBtn.layer.borderColor =
	self.zhenBtn.layer.borderColor =
	self.cunBtn.layer.borderColor =

	self.addressField.layer.borderColor =COLOR(0xBCBDBE).CGColor;
	
	self.shengContents = [self getAddressBytype:eSheng];
}

- (void)viewDidLayoutSubviews
{
	[super viewDidLayoutSubviews];
	self.shengBtn.imageEdgeInsets =
	self.shiBtn.imageEdgeInsets =
	self.quBtn.imageEdgeInsets =
	self.cunBtn.imageEdgeInsets =

	self.zhenBtn.imageEdgeInsets = UIEdgeInsetsMake(0, self.shengBtn.width - 30, 0, 0);
	
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
	if (self.storeName.text == nil || self.storeName.text.length == 0) {
		[MBProgressHUD alert:@"请填写商店名称"];
		return;
	}
	
	if (self.cun == nil) {
		[MBProgressHUD alert:@"请选择村"];
		return;
	}
	
	if (self.addressField.text == nil || self.addressField.text.length == 0) {
		[MBProgressHUD alert:@"请填写详细地址"];
		return;
	}

	if (self.seedCheck.selected == NO && self.huafeiCheck.selected == NO && self.nongyaoCheck.selected == NO && self.pifaCheck.selected == NO) {
		[MBProgressHUD alert:@"请选择农资店类型"];
		return;
	}
	
	if (self.telLabel.text == nil || self.telLabel.text.length == 0) {
		[MBProgressHUD alert:@"请填写电话"];
		return;
	}
	
	if (self.contactLabel.text == nil || self.contactLabel.text.length == 0) {
		[MBProgressHUD alert:@"请填写联系人"];
		return;
	}
	
	if (self.descLabel.text == nil || self.descLabel.text.length == 0) {
		[MBProgressHUD alert:@"请填写农资店描述"];
		return;
	}
	
	CStoresParams* params = [CStoresParams new];
	params.name = self.storeName.text;
	params.desc = self.descLabel.text;
	params.locationId = self.cunDic[self.cun];
	params.streetAndNumber = self.addressField.text;
	params.contactName = self.contactLabel.text;
	params.phone = self.telLabel.text;
	
	int type = 0;
	if (self.seedCheck.selected == YES) {
		type = type|1;
	}
	if (self.huafeiCheck.selected == YES) {
		type = type|2;
	}
	if (self.nongyaoCheck.selected == YES) {
		type = type|4;
	}
	if (self.pifaCheck.selected == YES) {
		type = type|8;
	}
	params.type = type;
	params.source = 0;
	[MBProgressHUD showHUDAddedTo:self.view animated:YES];
	[CStoresModel requestWithParams:POST params:params completion:^(id model, JSONModelError *err) {
		[MBProgressHUD hideHUDForView:self.view animated:YES];
		if (model && err == nil) {
			[MBProgressHUD alert:@"提交成功"];
			
			if (SharedAPPDelegate.currentController.presentationController) {
				[self dismissViewControllerAnimated:YES completion:nil];
				
			}
			else
			{
				[self.navigationController popToRootViewControllerAnimated:YES];
			}
		}
		else
		{
			[MBProgressHUD alert:@"认证失败"];
		}
	}];
}
- (IBAction)click:(id)sender {
	[self.view endEditing:YES];
	if (sender == self.shengBtn) {
		[ActionSheetStringPicker showPickerWithTitle:@"请选择省" rows:self.shengContents initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
			if (![self.sheng isEqualToString:selectedValue]) {
				
				self.sheng = selectedValue;
				[self.shengBtn setTitle:selectedValue forState:UIControlStateNormal];
				[self resetContent:eSheng];
				self.shiContents = [self getAddressBytype:eShi];
			}
		} cancelBlock:^(ActionSheetStringPicker *picker) {
			
		} origin:sender];
	}
	else if (sender == self.shiBtn) {
		if (self.sheng == nil) {
			SCLAlertView *alert = [[SCLAlertView alloc] init];
			[alert showWarning:self title:nil subTitle:@"请先选择省市" closeButtonTitle:@"关闭" duration:0];
			return;
		}
		[ActionSheetStringPicker showPickerWithTitle:@"请选择市" rows:self.shiContents initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
			if (![self.shi isEqualToString:selectedValue]) {
				self.shi = selectedValue;
				[self.shiBtn setTitle:selectedValue forState:UIControlStateNormal];
				[self resetContent:eShi];
				
				self.quContents = [self getAddressBytype:eQu];
				
			}
			
		} cancelBlock:^(ActionSheetStringPicker *picker) {
			
		} origin:sender];
	}
	else if (sender == self.quBtn){
		if (self.shi == nil) {
			SCLAlertView *alert = [[SCLAlertView alloc] init];
			[alert showWarning:self title:nil subTitle:@"请先选择市" closeButtonTitle:@"关闭" duration:0];
			return;
		}
		[ActionSheetStringPicker showPickerWithTitle:@"请选择区" rows:self.quContents initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
			if (![self.qu isEqualToString:selectedValue]) {
				
				self.qu = selectedValue;
				[self.quBtn setTitle:selectedValue forState:UIControlStateNormal];
				[self resetContent:eQu];
				
				self.zhenContents = [self getAddressBytype:eZhen];
			}
		} cancelBlock:^(ActionSheetStringPicker *picker) {
			
		} origin:sender];
	}
	else if (sender == self.zhenBtn){
		if (self.shi == nil) {
			[MBProgressHUD alert:@"请先选择区"];
			
			return;
		}
		[ActionSheetStringPicker showPickerWithTitle:@"请选择镇" rows:self.zhenContents initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
			if (![self.zhen isEqualToString:selectedValue]) {
				
				self.zhen = selectedValue;
				[self.zhenBtn setTitle:selectedValue forState:UIControlStateNormal];
				CGetLocationParams* params = [CGetLocationParams new];
				params.province = self.sheng;
				params.city = self.shi;
				params.country = self.qu;
				params.district = self.zhen;
				[MBProgressHUD showHUDAddedTo:self.view animated:YES];
				[CGetLocationModel requestWithParams:params completion:^(CGetLocationModel* model, JSONModelError *err) {
					[MBProgressHUD hideHUDForView:self.view animated:YES];
					if (model && err == nil) {
						if ([model isKindOfClass:[CGetLocationModel class]]) {
							self.cunDic = model.data;
						}
					}
				}];
			}
		} cancelBlock:^(ActionSheetStringPicker *picker) {
			
		} origin:sender];
	}
	else if (sender == self.cunBtn){
		if (self.zhen
			== nil || self.cunDic == nil) {
			[MBProgressHUD alert:@"请先选择镇"];
			return;
		}
		
		if (self.cunDic == nil) {
			[MBProgressHUD alert:@"暂无村数据，请确认是否登录"];
			return;
		}
		[ActionSheetStringPicker showPickerWithTitle:@"请选择村" rows:[self.cunDic allKeys] initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
			if (![self.cun isEqualToString:selectedValue]) {
				
				self.cun = selectedValue;//self.cunDic[selectedValue];
				[self.cunBtn setTitle:selectedValue forState:UIControlStateNormal];
			}
		} cancelBlock:^(ActionSheetStringPicker *picker) {
			
		} origin:sender];
	}
}

- (void)resetContent:(EAddressType)type
{
	//	self.addressField.text = nil;
	if (type == eZhen) {
		return;
	}
	
	self.zhen = nil;
	self.zhenContents = nil;
	[self.zhenBtn setTitle:@"请选择镇" forState:UIControlStateNormal];
	if (type == eQu) {
		return;
	}
	
	self.qu = nil;
	self.quContents = nil;
	[self.quBtn setTitle:@"请选择区" forState:UIControlStateNormal];
	if (type == eShi) {
		return;
	}
	
	self.shi = nil;
	self.shiContents = nil;
	[self.shiBtn setTitle:@"请选择市" forState:UIControlStateNormal];
	if (type == eSheng) {
		return;
	}
}

- (NSArray*)getAddressBytype:(EAddressType)type
{
	NSString *newPath=[[NSBundle mainBundle] pathForResource:@"dns" ofType:@"db"];
	
	FMDatabase* database = [FMDatabase databaseWithPath:newPath];
	if (![database open]) {
		return nil;
	}
	NSString* queryString = nil;
	switch (type) {
  case eSheng:
			queryString = @"SELECT DISTINCT  province FROM \"city\"";
			
			break;
  case eShi:
			queryString = [NSString stringWithFormat:@"SELECT DISTINCT  city FROM \"city\" WHERE province = \"%@\"",self.sheng];
			
			break;
		case eQu:
			queryString = [NSString stringWithFormat:@"SELECT DISTINCT  county FROM \"city\" WHERE province = \"%@\" AND city = \"%@\"",self.sheng, self.shi];
			
			break;
		case eZhen:
			queryString = [NSString stringWithFormat:@"SELECT DISTINCT  district FROM \"city\" WHERE province = \"%@\" AND city = \"%@\"  AND county = \"%@\"",self.sheng, self.shi, self.qu];
			
			break;
  default:
			break;
	}
	FMResultSet *s = [database executeQuery:queryString];
	NSMutableArray* contents = [NSMutableArray arrayWithCapacity:0x1];
	while ([s next]) {
		NSString* content = [s stringForColumnIndex:0];
		[contents addObject_s:content];
		
	}
	[database close];
	return contents;
}

- (IBAction)checkClick:(id)sender {
	[self.view endEditing:YES];
	UIButton* btn = sender;
	btn.selected = !btn.selected;

}

@end
