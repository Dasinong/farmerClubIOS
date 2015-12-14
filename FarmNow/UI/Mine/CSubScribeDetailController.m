//
//  CSubScribeDetailController.m
//  FarmNow
//
//  Created by zheliang on 15/11/27.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CSubScribeDetailController.h"
#import <FMDatabase.h>
#import <ActionSheetPicker-3.0/ActionSheetPicker.h>
#import "Global.h"
#import "CInsertSubScribeListModel.h"
#import "CUpdateSubScribeListModel.h"
#import "CLoadSubScribeListModel.h"

@interface CSubScribeDetailController ()
@property (weak, nonatomic) IBOutlet UIButton *shengBtn;
@property (weak, nonatomic) IBOutlet UIButton *shiBtn;
@property (weak, nonatomic) IBOutlet UIButton *quBtn;
@property (weak, nonatomic) IBOutlet UIButton *zhenBtn;
@property (weak, nonatomic) IBOutlet UIButton *cropBtn;

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *areaField;

@property (strong, nonatomic) NSString* sheng;
@property (strong, nonatomic) NSString* shi;
@property (strong, nonatomic) NSString* qu;
@property (strong, nonatomic) NSString* zhen;
@property (strong, nonatomic) NSString* crop;

@property (strong, nonatomic) NSArray* shengContents;
@property (strong, nonatomic) NSArray* shiContents;
@property (strong, nonatomic) NSArray* quContents;
@property (strong, nonatomic) NSArray* zhenContents;
@property (strong, nonatomic) NSDictionary* cropDic;

@property (weak, nonatomic) IBOutlet UIButton *checkWeather;

@property (weak, nonatomic) IBOutlet UIButton *checkWarning;
@property (weak, nonatomic) IBOutlet UIButton *checkAssistant;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

@end

@implementation CSubScribeDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	// Do any additional setup after loading the view.
	self.shengBtn.layer.borderWidth =
	self.shiBtn.layer.borderWidth =
	self.quBtn.layer.borderWidth =
	self.zhenBtn.layer.borderWidth =
	self.cropBtn.layer.borderWidth =
	self.nameField.layer.borderWidth =
	self.phoneField.layer.borderWidth =
	self.areaField.layer.borderWidth =1.0;
	self.shengBtn.layer.borderColor =
	self.shiBtn.layer.borderColor =
	self.quBtn.layer.borderColor =
	self.zhenBtn.layer.borderColor =
	self.cropBtn.layer.borderColor =
	self.nameField.layer.borderColor =
	self.phoneField.layer.borderColor =
	self.areaField.layer.borderColor = COLOR(0xBCBDBE).CGColor;
	
	self.shengContents = [self getAddressBytype:eSheng];
	
	if (self.subscribeId == nil) {
		[self.commitBtn setTitle:@"保存" forState:UIControlStateNormal];
	}
	else
	{
		[self.commitBtn setTitle:@"修改" forState:UIControlStateNormal];

	}
	[self loadSubscribeList:self.subscribeId];
}
- (void)viewDidLayoutSubviews
{
	[super viewDidLayoutSubviews];
	self.shengBtn.imageEdgeInsets =
	self.shiBtn.imageEdgeInsets =
	self.quBtn.imageEdgeInsets =
	self.zhenBtn.imageEdgeInsets =
	self.cropBtn.imageEdgeInsets = UIEdgeInsetsMake(0, self.shengBtn.width - 30, 0, 0);
	
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

- (void)loadSubscribeList:(NSNumber*)subscribeId
{
	CLoadSubScribeListParams* params = [CLoadSubScribeListParams new];
	params.id = [subscribeId intValue];
	[MBProgressHUD showHUDAddedTo:self.view animated:YES];
	[CLoadSubScribeListModel requestWithParams:params completion:^(CLoadSubScribeListModel* model, JSONModelError *err) {
		[MBProgressHUD hideHUDForView:self.view animated:YES];
		if (model && err == nil) {
			CSubscriptionObject* object = model.data;
			self.nameField.text = object.targetName;
			self.phoneField.text = object.cellphone;
			[self.shengBtn setTitle:object.province forState:UIControlStateNormal];
			self.sheng = object.province;
			
			[self.shiBtn setTitle:object.city forState:UIControlStateNormal];
			self.shi = object.city;
			
			[self.quBtn setTitle:object.country forState:UIControlStateNormal];
			self.qu = object.country;
		
			[self.zhenBtn setTitle:object.district forState:UIControlStateNormal];
			self.zhen = object.district;
			
			self.areaField.text = [NSString stringWithFormat:@"%f",object.area];
			
			[self.cropBtn setTitle:object.cropName forState:UIControlStateNormal];
			self.crop = object.cropName;
			self.checkWeather.selected = object.isAgriWeather;
			self.checkWarning.selected = object.isNatAler;
			self.checkAssistant.selected = object.isRiceHelper;
		}
	}];
}

- (IBAction)cancel:(id)sender {
	[self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)doneClick:(id)sender {
	if (self.sheng == nil) {
		[MBProgressHUD alert:@"请选择省"];
		return;
	}
	else if (self.shi == nil) {
		[MBProgressHUD alert:@"请选择市"];
		return;
	}
	else if (self.qu == nil) {
		[MBProgressHUD alert:@"请选择区"];
		return;
	}
	else if (self.zhen == nil) {
		[MBProgressHUD alert:@"请选择镇"];
		return;
	}
	else if (self.crop == nil) {
		[MBProgressHUD alert:@"请选择作物"];
		return;
	}
	else if (self.nameField.text == nil) {
		[MBProgressHUD alert:@"请输入姓名"];
		return;
	}
	else if (self.phoneField.text == nil) {
		[MBProgressHUD alert:@"请输入对方手机"];
		return;
	}
	else if (self.areaField.text == nil) {
		[MBProgressHUD alert:@"请输入农田大小"];
		return;
	}
	
	if (self.subscribeId == nil) {
		CInsertSubScribeListParams *params = [CInsertSubScribeListParams new];
		params.id = self.subscribeId;
		params.targetName = self.nameField.text;
		params.cellphone = self.phoneField.text;
		params.province = self.sheng;
		params.city = self.shi;
		params.country = self.qu;
		params.district = self.zhen;
		params.area = [self.areaField.text doubleValue];
		params.cropId = [self getCropIdWithCropName:self.crop];
		params.cropName = self.crop;
		params.isAgriWeather = self.checkWeather ? YES:NO;
		params.isNatAlter = self.checkWarning ? YES:NO;
		params.isRiceHelper = self.checkAssistant ? YES:NO;
		
		[CInsertSubScribeListModel requestWithParams:POST params:params completion:^(id model, JSONModelError *err) {
			if (model && err == nil) {
				[MBProgressHUD alert:@"订阅成功"];
				[self.navigationController popViewControllerAnimated:YES];
			}
			else{
				[MBProgressHUD alert:@"订阅失败"];

			}
		}];

	}
	else{
		CUpdateSubScribeListParams *params = [CUpdateSubScribeListParams new];
		params.targetName = self.nameField.text;
		params.cellphone = self.phoneField.text;
		params.province = self.sheng;
		params.city = self.shi;
		params.country = self.qu;
		params.district = self.zhen;
		params.area = [self.areaField.text doubleValue];
		params.cropId = [self getCropIdWithCropName:self.crop];
		params.cropName = self.crop;
		params.isAgriWeather = self.checkWeather ? YES:NO;
		params.isNatAlter = self.checkWarning ? YES:NO;
		params.isRiceHelper = self.checkAssistant ? YES:NO;
		
		[CUpdateSubScribeListModel requestWithParams:POST params:params completion:^(id model, JSONModelError *err) {
			if (model && err == nil) {
				[MBProgressHUD alert:@"订阅成功"];
				[self.navigationController popViewControllerAnimated:YES];
			}
			else{
				[MBProgressHUD alert:@"订阅失败"];
				
			}
		}];
	}
	
}
- (IBAction)click:(id)sender {
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
			SCLAlertView *alert = [[SCLAlertView alloc] init];
			[alert showWarning:self title:nil subTitle:@"请先选择区" closeButtonTitle:@"关闭" duration:0];
			return;
		}
		[ActionSheetStringPicker showPickerWithTitle:@"请选择镇" rows:self.zhenContents initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
			if (![self.zhen isEqualToString:selectedValue]) {
				
				self.zhen = selectedValue;
				[self.zhenBtn setTitle:selectedValue forState:UIControlStateNormal];
			}
		} cancelBlock:^(ActionSheetStringPicker *picker) {
			
		} origin:sender];
		
	}
	else if (sender == self.cropBtn){
		[ActionSheetStringPicker showPickerWithTitle:@"请选择作物" rows:SMS_Crop_Array initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
			if (![self.crop isEqualToString:selectedValue]) {
				
				self.crop = selectedValue;
				[self.cropBtn setTitle:selectedValue forState:UIControlStateNormal];
			}
		} cancelBlock:^(ActionSheetStringPicker *picker) {
			
		} origin:sender];
	}
	
}

- (IBAction)checkClick:(id)sender {
	UIButton* check = sender;
	check.selected = !check.selected;
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

- (NSInteger)getCropIdWithCropName:(NSString*)cropName
{
	NSString *newPath=[[NSBundle mainBundle] pathForResource:@"dns" ofType:@"db"];
	NSInteger ret = -1;
	FMDatabase* database = [FMDatabase databaseWithPath:newPath];
	if (![database open]) {
		return ret;
	}
	NSString* queryString = [NSString stringWithFormat:@"SELECT cropId FROM \"crop\" WHERE \"cropName\" == '%@';",cropName];
	FMResultSet *s = [database executeQuery:queryString];
	while ([s next]) {
		ret = [s intForColumn:@"cropId"];
		
		
	}
	[database close];
	return ret;
}

@end
