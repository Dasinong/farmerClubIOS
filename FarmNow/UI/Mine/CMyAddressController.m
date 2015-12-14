//
//  CMyAddressController.m
//  FarmNow
//
//  Created by zheliang on 15/10/21.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CMyAddressController.h"
#import <ActionSheetPicker.h>
#import <FMDatabase.h>



@interface CMyAddressController ()
@property (weak, nonatomic) IBOutlet UIButton *shengBtn;
@property (weak, nonatomic) IBOutlet UIButton *shiBtn;
@property (weak, nonatomic) IBOutlet UIButton *quBtn;
@property (weak, nonatomic) IBOutlet UIButton *zhenBtn;
@property (weak, nonatomic) IBOutlet UITextField *addressField;

@property (strong, nonatomic) NSString* sheng;
@property (strong, nonatomic) NSString* shi;
@property (strong, nonatomic) NSString* qu;
@property (strong, nonatomic) NSString* zhen;

@property (strong, nonatomic) NSArray* shengContents;
@property (strong, nonatomic) NSArray* shiContents;
@property (strong, nonatomic) NSArray* quContents;
@property (strong, nonatomic) NSArray* zhenContents;


@end

@implementation CMyAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.shengBtn.layer.borderWidth =
	self.shiBtn.layer.borderWidth =
	self.quBtn.layer.borderWidth =
	self.zhenBtn.layer.borderWidth =
	self.addressField.layer.borderWidth = 1.0;
	self.shengBtn.layer.borderColor =
	self.shiBtn.layer.borderColor =
	self.quBtn.layer.borderColor =
	self.zhenBtn.layer.borderColor =
	self.addressField.layer.borderColor =COLOR(0xBCBDBE).CGColor;
	
	self.shengContents = [self getAddressBytype:eSheng];
}

- (void)viewDidLayoutSubviews
{
	[super viewDidLayoutSubviews];
	self.shengBtn.imageEdgeInsets =
	self.shiBtn.imageEdgeInsets =
	self.quBtn.imageEdgeInsets =
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
	else if (self.addressField.text == nil) {
		[MBProgressHUD alert:@"请输入详细地址"];
		return;
	}
	NSString* address = [NSString stringWithFormat:@"%@%@%@%@%@",self.sheng, self.shi, self.qu, self.zhen,self.addressField.text ];
	if (self.delegate && [self.delegate respondsToSelector:@selector(addressSelected:)]) {

		[self.delegate performSelector:@selector(addressSelected:) withObject:address];
	}
	[self.navigationController popViewControllerAnimated:YES];
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

@end
