//
//  CClaimCouponViewController.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/14.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CClaimCouponViewController.h"
#import "TPKeyboardAvoidingTableView.h"
#import "CClaimCouponTableViewCell.h"
#import <ActionSheetPicker-3.0/ActionSheetPicker.h>
#import "NSString+Validation.h"
#import "CRequestCouponModel.h"
#import "CClaimCouponModel.h"

@interface CClaimCouponViewController () <UITableViewDelegate, UITableViewDataSource, CClaimCouponTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingTableView *tableView;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *company;
@property (nonatomic, strong) NSString *crop;
@property (nonatomic, strong) NSString *area;
@property (nonatomic, strong) NSString *yield;
@property (nonatomic, strong) NSString *experience;
@property (nonatomic, strong) NSString *contactNumber;

@end

@implementation CClaimCouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submit:(id)sender {
    // Sanity Check
    NSString *cleanName = [self.name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *cleanCompany = [self.company stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *cleanCrop = [self.crop stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *cleanArea = [self.area stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //NSString *cleanYield = [self.yield stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //NSString *cleanContact = [self.contactNumber stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
    if (cleanName.length == 0) {
        [MBProgressHUD alert:@"请填写姓名"];
        return;
    }
    if (cleanCrop.length == 0) {
        [MBProgressHUD alert:@"请填写作物"];
        return;
    }
    if (cleanArea.length == 0) {
        [MBProgressHUD alert:@"请填写面积"];
        return;
    }
//    if (cleanYield.length == 0) {
//        [MBProgressHUD alert:@"请填写去年产量"];
//        return;
//    }
//    if (cleanContact.length == 0) {
//        [MBProgressHUD alert:@"请填写联系电话"];
//        return;
//    }
    
    if (self.experience.length == 0) {
        [MBProgressHUD alert:@"请选择种植经验"];
        return;
    }
    
    if (cleanCompany == nil) {
        cleanCompany = @"";
    }
    
//    if (![cleanContact validatePhoneNumber]) {
//        [MBProgressHUD alert:@"联系电话格式不正确"];
//        return;
//    }
    
    if (![cleanArea validateNumeric]) {
        [MBProgressHUD alert:@"面积格式不正确"];
        return;
    }
    
//    if (![cleanYield validateNumeric]) {
//        [MBProgressHUD alert:@"去年产量格式不正确"];
//        return;
//    }
    
    if ([cleanArea doubleValue] <= 0) {
        [MBProgressHUD alert:@"面积必须大于0"];
        return;
    }
    
//    if ([cleanYield doubleValue] < 0) {
//        [MBProgressHUD alert:@"去年产量必须大于等于0"];
//        return;
//    }
//    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    CClaimCouponParams *claimParams = [CClaimCouponParams new];
    claimParams.campaignId = self.couponCampaign.id;
    
    [CClaimCouponModel requestWithParams:POST params:claimParams completion:^(CClaimCouponModel *claimModel, JSONModelError *err) {
        
        if (err == nil && claimModel) {
            CRequestCouponParams *params = [CRequestCouponParams new];
            params.name = cleanName;
            params.company = @"";
            params.crop = cleanCrop;
            params.area = [cleanArea doubleValue];
            params.yield = 0;
            params.experience = self.experience;
            params.contactNumber = @"";
            params.productUseHistory = @"";
            
            [CRequestCouponModel requestWithParams:POST params:params completion:^(CRequestCouponModel *model, JSONModelError *err) {
                [MBProgressHUD hideHUDForView:self.view animated:NO];
                
                // 跳转到我的优惠券页面
                claimModel.coupon.campaign = self.couponCampaign;
                [self.navigationController popViewControllerAnimated:NO];
                if ([self.delegate respondsToSelector:@selector(couponGet:)]) {
                    [self.delegate couponGet:claimModel.coupon];
                }
            }];
        }
        else {
            [MBProgressHUD hideHUDForView:self.view animated:NO];
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)openPicker:(id)sender {
    [self.view endEditing:NO];
    NSArray *exps = [NSArray arrayWithObjects:@"第一年的新手", @"2-3年有些经验", @"3-5年的老手", @"5-10年的专家", @"10年以上资深专家", nil];
    
    [ActionSheetStringPicker showPickerWithTitle:@"选择种植经验"
                                            rows:exps
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           self.experience = selectedValue;
                                           [self.tableView reloadData];
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         
                                     }
                                          origin:sender];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5; //多一个为keyboard空出位子
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CClaimCouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.separator.hidden = NO;
    cell.fieldLabel.hidden = NO;
    cell.valueTextField.hidden = NO;
    cell.valueTextField.keyboardType = UIKeyboardTypeDefault;
    cell.pickerButton.hidden = YES;
    cell.delegate = self;
    cell.valueTextField.tag = indexPath.row;
    
    if (indexPath.row == 0) {
        static BOOL firstTime = YES;
        
        if (firstTime) {
            //[cell.valueTextField becomeFirstResponder];
            firstTime = NO;
        }
        
        NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:@"姓名 *"];
        [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor colorwithHexString:@"#666666"] range:NSMakeRange(0, 3)];
        [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor colorwithHexString:@"#ff8400"] range:NSMakeRange(3, 1)];
        cell.fieldLabel.attributedText = attriString;
    }
    else if (indexPath.row == 1) {
        NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:@"作物 *"];
        [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor colorwithHexString:@"#666666"] range:NSMakeRange(0, 3)];
        [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor colorwithHexString:@"#ff8400"] range:NSMakeRange(3, 1)];
        cell.fieldLabel.attributedText = attriString;
    }
    else if (indexPath.row == 2) {
        NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:@"面积 *"];
        [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor colorwithHexString:@"#666666"] range:NSMakeRange(0, 3)];
        [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor colorwithHexString:@"#ff8400"] range:NSMakeRange(3, 1)];
        cell.fieldLabel.attributedText = attriString;
        
        cell.valueTextField.keyboardType = UIKeyboardTypeDecimalPad;
    }
    else if (indexPath.row == 3) {
        NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:@"种植经验 *"];
        [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor colorwithHexString:@"#666666"] range:NSMakeRange(0, 5)];
        [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor colorwithHexString:@"#ff8400"] range:NSMakeRange(5, 1)];
        cell.fieldLabel.attributedText = attriString;
        
        cell.valueTextField.hidden = YES;
        cell.pickerButton.hidden = NO;
        
        if (self.experience) {
            [cell.pickerButton setTitle:self.experience forState:UIControlStateNormal];
        }
    }
    else {
        cell.valueTextField.hidden = YES;
        cell.fieldLabel.hidden = YES;
        cell.pickerButton.hidden = YES;
        cell.separator.hidden = YES;
        cell.delegate = nil;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark - CClaimCouponTableViewCellDelegate
- (void)textFieldEndEditing:(UITextField *)textField {
    if (textField.tag == 0) {
        self.name = textField.text;
    }
    else if (textField.tag == 1) {
        self.crop = textField.text;
    }
    else if (textField.tag == 2) {
        self.area = textField.text;
    }
}
@end
