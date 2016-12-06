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
#import "CCouponDetailViewController.h"
#import "CCouponHomeViewController.h"

#define KScreenWidth [UIScreen mainScreen].bounds.size.width

@interface CClaimCouponViewController () <UITableViewDelegate, UITableViewDataSource, CClaimCouponTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingTableView *tableView;
@property (nonatomic, strong) NSString *name; // 姓名
@property (nonatomic, strong) NSString *company;
@property (nonatomic, strong) NSString *crop;
@property (nonatomic, strong) NSString *area;
@property (nonatomic, strong) NSString *yield;
@property (nonatomic, strong) NSString *experience; // cell 显示性别
@property (nonatomic, strong) NSString *contactNumber; // 电话
@property (nonatomic, strong) NSString *address; // 邮寄地址
@property (nonatomic, assign) NSInteger userid;
@property (nonatomic, strong) NSString *postcode;

@property (nonatomic, strong) NSString *jiandaAmount;
@property (nonatomic, strong) NSString *kairunAmount;

@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *use_rate;
@property (nonatomic, strong) NSString *education;
@property (nonatomic, strong) NSString *pleased; // 最满意的
@property (nonatomic, strong) NSString *unPleased; // 最不满意的
@property (nonatomic, strong) NSString *add_function; // 想要添加的功能
@property (nonatomic, strong) NSString *value; // 带来的价值


@property (nonatomic, strong) NSString *suggests;


@property (nonatomic, strong) NSString *experience_sex;
@property (nonatomic, strong) NSString *experience_edu;
@property (nonatomic, strong) NSString *experience_rate;
@property (nonatomic, strong) NSString *experience_pleased;
@property (nonatomic, strong) NSString *experience_unPleaesd;
@property (nonatomic, strong) NSString *experience_add;
@property (nonatomic, strong) NSString *experience_value;


@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;

@end

@implementation CClaimCouponViewController
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"myName"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"myPhone"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"myAddress"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"mySuggest"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"myName"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"myPhone"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"myAddress"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"mySuggest"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([self.couponCampaign isInsurance]) {
        self.title = @"申请表";
    }
    
    if (self.couponCampaign.id != 15) {
        self.tipsLabel.text = @"* 为必填内容";
    }
    else {
        self.crop = @"香蕉";
    }
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
    NSString *cleanJiandaAmount = [self.jiandaAmount stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *cleanKairunAmount = [self.kairunAmount stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //NSString *cleanYield = [self.yield stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //NSString *cleanContact = [self.contactNumber stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];


    
    
    
    if (self.couponCampaign.id == 38 || self.couponCampaign.id == 40) {

        if (cleanName.length == 0) {
            [MBProgressHUD alert:@"请填写姓名"];
            return;
        }
    
        if (self.contactNumber.length == 0) {
            [MBProgressHUD alert:@"请填写联系电话"];
            return;
        }
        else if (self.contactNumber.length != 11) {
        
            [MBProgressHUD alert:@"请填写正确的联系电话"];
            return;
        }
        
        if (self.sex.length == 0) {
            [MBProgressHUD alert:@"请选择性别"];
            return;
        }
        
        if (self.address.length == 0) {
            [MBProgressHUD alert:@"请填写地址"];
            return;
        }
        
        if (self.experience_edu.length == 0) {
            [MBProgressHUD alert:@"请选择教育程度"];
            return;
        }
        
        if (self.experience_rate.length == 0) {
            [MBProgressHUD alert:@"请选择使用频率"];
            return;
        }
        
        if (self.experience_pleased.length == 0) {
            [MBProgressHUD alert:@"请选择最满意的功能"];
            return;
        }
        
        if (self.experience_unPleaesd.length == 0) {
            [MBProgressHUD alert:@"请选择最不满意的功能"];
            return;
        }
        
        if (self.experience_add.length == 0) {
            [MBProgressHUD alert:@"请选择最希望添加的功能"];
        }
        
        if (self.experience_value.length == 0) {
            [MBProgressHUD alert:@"请选择给您带来的价值"];
            return;
        }
        
        if (self.suggests.length == 0) {
            [MBProgressHUD alert:@"请填写是否使用过相似APP"];
            return;
        }
        
        
    }else{
        
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
        if ([cleanArea doubleValue] <= 0) {
            [MBProgressHUD alert:@"面积必须大于0"];
            return;
        }
        
        if ([self.couponCampaign isInsurance]) {
            self.experience = @"无";
        }
        
        if (self.experience.length == 0) {
            [MBProgressHUD alert:@"请选择种植经验"];
            return;
        }
        
        if (cleanCompany == nil) {
            cleanCompany = @"";
        }
    }
    

    

    
    NSMutableCharacterSet *characterSet = [NSMutableCharacterSet decimalDigitCharacterSet];
    [characterSet addCharactersInString:@"."];

    if ([self.couponCampaign isInsurance]) {
        if (![cleanJiandaAmount validateInCharacterSet:characterSet]) {
            [MBProgressHUD alert:@"健达购买数量格式不正确"];
            return;
        }
        if (![cleanKairunAmount validateInCharacterSet:characterSet]) {
            [MBProgressHUD alert:@"凯润购买数量格式不正确"];
            return;
        }
        
        if ([cleanJiandaAmount doubleValue] < 1 && [cleanKairunAmount doubleValue] < 3) {
            [MBProgressHUD alert:@"购买数量太少"];
            return;
        }
    }
    
    
//    if (![cleanYield validateNumeric]) {
//        [MBProgressHUD alert:@"去年产量格式不正确"];
//        return;
//    }
    
//    if ([cleanArea doubleValue] <= 0) {
//        [MBProgressHUD alert:@"面积必须大于0"];
//        return;
//    }
    
//    if ([cleanYield doubleValue] < 0) {
//        [MBProgressHUD alert:@"去年产量必须大于等于0"];
//        return;
//    }
//    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    CClaimCouponParams *claimParams = [CClaimCouponParams new];
    claimParams.campaignId = self.couponCampaign.id;
    claimParams.comment = [NSString stringWithFormat:@"凯润:%@;健达:%@", cleanKairunAmount, cleanJiandaAmount];
    
    [CClaimCouponModel requestWithParams:POST params:claimParams completion:^(CClaimCouponModel *claimModel, JSONModelError *err) {
        
        if (err == nil && claimModel) {
            
            CRequestCouponParams *params = [CRequestCouponParams new];
            params.name = cleanName;
            params.company = @"";
            params.crop = cleanCrop;
            params.area = [cleanArea doubleValue];
            params.yield = 0;
            params.experience = self.experience;
            params.contactNumber = self.contactNumber;
            params.productUseHistory = @"";
            params.address = self.address;
            params.postcode = self.postcode;
        
            params.sex = self.experience_sex;
            params.educationLevel = self.experience_edu;
            params.useTimes = self.experience_rate;
            params.bestFeature = self.experience_pleased;
            params.badFeature = self.experience_unPleaesd;
            params.hopeFeature = self.experience_add;
            params.bestValue = self.experience_value;
            params.othersApp = self.suggests;
            
            [CRequestCouponModel requestWithParams:POST params:params completion:^(CRequestCouponModel *model, JSONModelError *err) {
                [MBProgressHUD hideHUDForView:self.view animated:NO];
              
                // 跳转到我的优惠券页面
                claimModel.coupon.campaign = self.couponCampaign;
                if (self.couponCampaign.id==38 || self.couponCampaign.id==40){
                    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提交成功"
                                                                    message:@"成功参与活动！请等待短信通知中奖"
                                                                   delegate:self
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil, nil];
                    [alert show];

                    [self.navigationController popViewControllerAnimated:NO];

                }else{
                    [self.navigationController popViewControllerAnimated:NO];
                    if ([self.delegate respondsToSelector:@selector(couponGet:)]) {
                        [self.delegate couponGet:claimModel.coupon];
                    }
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
- (void)storyInfo {
    CClaimCouponTableViewCell *nameCell = (CClaimCouponTableViewCell *)[self.tableView viewWithTag:1000];
    NSString *name = nameCell.valueTextField.text;
    CClaimCouponTableViewCell *addressCell = (CClaimCouponTableViewCell *)[self.tableView viewWithTag:1002];
    NSString *address = addressCell.valueTextField.text;
    CClaimCouponTableViewCell *phoneCell = (CClaimCouponTableViewCell *)[self.tableView viewWithTag:1003];
    NSString *phone = phoneCell.valueTextField.text ;
    CClaimCouponTableViewCell *suggestCell = (CClaimCouponTableViewCell *)[self.tableView viewWithTag:1010];
    NSString *suggest = suggestCell.valueTextField.text;
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"myName"];
    [[NSUserDefaults standardUserDefaults] setObject:address forKey:@"myAddress"];
    [[NSUserDefaults standardUserDefaults] setObject:phone forKey:@"myPhone"];
    [[NSUserDefaults standardUserDefaults] setObject:suggest forKey:@"mySuggest"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    

}
- (IBAction)openPicker:(id)sender {
    [self.view endEditing:NO];
   // [self storyInfo];
        if ([self.couponCampaign isInsurance]) {
        NSArray *exps = [NSArray arrayWithObjects:@"香蕉", @"芒果", @"其他", nil];
        
        [ActionSheetStringPicker showPickerWithTitle:@"选择作物"
                                                rows:exps
                                    initialSelection:0
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                               self.crop = selectedValue;
                                               
                                               [self.tableView reloadData];
                                           }
                                         cancelBlock:^(ActionSheetStringPicker *picker) {
                                             
                                         }
                                              origin:sender];
    }
    else if (self.couponCampaign.id == 38 || self.couponCampaign.id==40){
        
        UIButton *btn = [[UIButton alloc] init];
        btn = sender;
        if (btn.tag == 101) {
            NSArray *exps = [NSArray arrayWithObjects:@"男", @"女", nil];
            [ActionSheetStringPicker showPickerWithTitle:@"性别"
                                                    rows:exps
                                        initialSelection:0
                                               doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                                   self.experience_sex = selectedValue;
                                                   
                                                   [self.tableView reloadData];
                                                   
                                               } cancelBlock:^(ActionSheetStringPicker *picker) {
                                                   
                                               } origin:sender];
        }else if (btn.tag == 102){
            NSArray *exps = [NSArray arrayWithObjects:@"小学", @"初中", @"高中", @"本科及以上", nil];
            [ActionSheetStringPicker showPickerWithTitle:@"教育程度"
                                                    rows:exps
                                        initialSelection:0
                                               doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                                   self.experience_edu = selectedValue;
                                                   [self.tableView reloadData];
                                                   
                                               } cancelBlock:^(ActionSheetStringPicker *picker) {
                                                   
                                               } origin:sender];
            
        }else if (btn.tag == 103){
            NSArray *exps = [NSArray arrayWithObjects:@"一天一次", @"一周一次", @"一月一次", nil];
            [ActionSheetStringPicker showPickerWithTitle:@"使用频率"
                                                    rows:exps
                                        initialSelection:0
                                               doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                                   self.experience_rate = selectedValue;
                                                   [self.tableView reloadData];
                                                   
                                               } cancelBlock:^(ActionSheetStringPicker *picker) {
                                                   
                                               } origin:sender];
            
        }else if (btn.tag == 104){
            NSArray *exps = [NSArray arrayWithObjects:@"种植工具", @"陶氏产品", @"优惠活动", @"金融服务", nil];
            [ActionSheetStringPicker showPickerWithTitle:@"最满意的功能"
                                                    rows:exps
                                        initialSelection:0
                                               doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                                   self.experience_pleased = selectedValue;
                                                   [self.tableView reloadData];
                                                   
                                               } cancelBlock:^(ActionSheetStringPicker *picker) {
                                                   
                                               } origin:sender];
            
            // 最不满意的功能 （多选）
        }else if (btn.tag == 105){
             NSArray *entries = [[NSArray alloc] initWithObjects:@"陶氏产品", @"种植工具", @"优惠活动", @"金融服务", nil];
           
            
            [ActionSheetStringPicker showPickerWithTitle:@"最不满意的功能"
                                                    rows:entries
                                        initialSelection:0
                                               doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
            
                self.experience_unPleaesd = selectedValue;
                [self.tableView reloadData];
            
                                                } cancelBlock:^(ActionSheetStringPicker *picker) {
            
                                                } origin:sender];
            
        }else if (btn.tag == 106){
            NSArray *exps = [NSArray arrayWithObjects:@"更多农药优惠", @"技术指导和分析", @"附近农药店位置分享", @"大农户之间交流经验", @"提供打药服务",  nil];
            [ActionSheetStringPicker showPickerWithTitle:@"最希望增加的功能"
                                                    rows:exps
                                        initialSelection:0
                                               doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                                   self.experience_add = selectedValue;
                                                   [self.tableView reloadData];
                                                   
                                               } cancelBlock:^(ActionSheetStringPicker *picker) {
                                                   
                                               } origin:sender];
            
        }else if (btn.tag == 107){
            NSArray *exps = [NSArray arrayWithObjects:@"作物种植指导", @"了解陶氏产品", @"参与线上优惠活动", @"帮助农资贷款申请", nil];
            [ActionSheetStringPicker showPickerWithTitle:@"给您带来的最大价值"
                                                    rows:exps
                                        initialSelection:0
                                               doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                                   self.experience_value = selectedValue;
                                                   [self.tableView reloadData];
                                                   
                                               } cancelBlock:^(ActionSheetStringPicker *picker) {
                                                   
                                               } origin:sender];
            
        }
        
        
        
    }else{
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
}


#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.couponCampaign.id == 38 || self.couponCampaign.id==40) return 11;
    return 4; //多一个为keyboard空出位子
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

     NSString *identifier = @"Cell";
    NSInteger index = 0;
    
    // 健达 申领cell
    
//    if ([self.couponCampaign isInsurance] && indexPath.row == 3) {
//        identifier = @"Cell2";
//        index = 1;
//    } else {
//        identifier = @"Cell";
//        index = 0;
//    }
    //CClaimCouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    if (!cell ) {
//        cell = [[[NSBundle mainBundle] loadNibNamed:@"CClaimCouponTableViewCell" owner:self options:nil] objectAtIndex:index];
//    }
 //   CClaimCouponTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CClaimCouponTableViewCell class]) owner:self options:nil] objectAtIndex:0];
    
//    NSString *identify = [NSString stringWithFormat:@"cell_%ld",indexPath.row];
//    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CClaimCouponTableViewCell class])  bundle:nil] forCellReuseIdentifier:@"Cell"];
//    CClaimCouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    
    
    
    CClaimCouponTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CClaimCouponTableViewCell class]) owner:self options:nil] objectAtIndex:0];
    }
    
    
    
    cell.separator.hidden = NO;
    cell.fieldLabel.hidden = NO;
    cell.valueTextField.hidden = NO;
    cell.valueTextField.keyboardType = UIKeyboardTypeDefault;
    cell.pickerButton.hidden = YES;
    cell.delegate = self;
    cell.valueTextField.tag = indexPath.row + 100;
    cell.tag = 1000 + indexPath.row;
//    cell.valueTextField.text = @"";
    if (cell.valueTextField2) {
        cell.valueTextField2.tag = indexPath.row + 1;
    }
    
    if (indexPath.row == 0) {
//        cell.valueTextField.text = @"bbbbb";
        static BOOL firstTime = YES;
        
        if (firstTime) {
            //[cell.valueTextField becomeFirstResponder];
            firstTime = NO;
        }
        
        NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:@"姓名 *"];
        [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor colorwithHexString:@"#666666"] range:NSMakeRange(0, 3)];
        [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor colorwithHexString:@"#ff8400"] range:NSMakeRange(3, 1)];
        cell.fieldLabel.attributedText = attriString;
        cell.valueTextField.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"myName"];
        
        
        [[NSUserDefaults standardUserDefaults] synchronize];
           }
    else if (indexPath.row == 1) {
        if (self.couponCampaign.id ==38 || self.couponCampaign.id == 40){
            
            NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:@"性别 *"];
            [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor colorwithHexString:@"#666666"] range:NSMakeRange(0, 3)];
            [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor colorwithHexString:@"#ff8400"] range:NSMakeRange(3, 1)];
            cell.fieldLabel.attributedText = attriString;
            //            cell.valueTextField.keyboardType = UIKeyboardTypeDecimalPad;
            
            //            cell.fieldLabel.hidden = YES;
           cell.valueTextField.hidden = YES;
           [cell.pickerButton addTarget:self action:@selector(openPicker:) forControlEvents:UIControlEventTouchUpInside];

            cell.pickerButton.hidden = NO;
            cell.pickerButton.tag = 101;
            
            if (self.experience_sex) {
                [cell.pickerButton setTitle:self.experience_sex forState:(UIControlStateNormal)];
            }
            
            
        }else{
            NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:@"作物 *"];
            [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor colorwithHexString:@"#666666"] range:NSMakeRange(0, 3)];
            [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor colorwithHexString:@"#ff8400"] range:NSMakeRange(3, 1)];
            cell.fieldLabel.attributedText = attriString;
            
            if ([self.couponCampaign isInsurance]) {
                
                [cell.pickerButton addTarget:self action:@selector(openPicker:) forControlEvents:UIControlEventTouchUpInside];

                cell.valueTextField.hidden = YES;
                cell.pickerButton.hidden = NO;
                
                if (self.crop) {
                    [cell.pickerButton setTitle:self.crop forState:UIControlStateNormal];
                }
            }
        }
    }
    else if (indexPath.row == 2) {
//        cell.valueTextField.text = @"bbbbb";
        if (self.couponCampaign.id ==38 || self.couponCampaign.id==40){
            
        
            NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:@"邮寄地址 *"];
            [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor colorwithHexString:@"#666666"] range:NSMakeRange(0, 5)];
            [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor colorwithHexString:@"#ff8400"] range:NSMakeRange(5, 1)];
            cell.fieldLabel.attributedText = attriString;
            
            
            //            NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:@"邮编 *"];
            //            [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor colorwithHexString:@"#666666"] range:NSMakeRange(0, 3)];
            //            [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor colorwithHexString:@"#ff8400"] range:NSMakeRange(3, 1)];
            //            cell.fieldLabel.attributedText = attriString;
            //            cell.valueTextField.keyboardType = UIKeyboardTypeDecimalPad;
        }else{
            NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:@"面积（亩） *"];
            [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor colorwithHexString:@"#666666"]  range:NSMakeRange(0, 6)];
            [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor colorwithHexString:@"#ff8400"] range:NSMakeRange(6, 1)];
            cell.fieldLabel.attributedText = attriString;
            
            cell.valueTextField.keyboardType = UIKeyboardTypeDecimalPad;
        }
        cell.valueTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"myAddress"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else if (indexPath.row == 3) {
       cell.valueTextField.text = @"bbbbb";
        // 如果是陶氏活动
        if (self.couponCampaign.id==38 || self.couponCampaign.id==40){
            //            cell.fieldLabel.hidden = YES;
            //            cell.valueTextField.hidden = YES;
            //            cell.pickerButton.hidden = YES;
           
            NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:@"联系电话 *"];
            [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor colorwithHexString:@"#666666"] range:NSMakeRange(0, 5)];
            [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor colorwithHexString:@"#ff8400"] range:NSMakeRange(5, 1)];
            cell.fieldLabel.attributedText = attriString;
            
            
            
            
        }else{
            
            if ([self.couponCampaign isInsurance]) {
                NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:@"数量（升） *"];
                [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor colorwithHexString:@"#666666"] range:NSMakeRange(0, 6)];
                [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor colorwithHexString:@"#ff8400"] range:NSMakeRange(6, 1)];
                cell.fieldLabel.attributedText = attriString;
                cell.valueTextField.keyboardType = UIKeyboardTypeDecimalPad;
                cell.valueTextField2.keyboardType = UIKeyboardTypeDecimalPad;
            }
            else {
                NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:@"种植经验 *"];
                [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor colorwithHexString:@"#666666"] range:NSMakeRange(0, 5)];
                [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor colorwithHexString:@"#ff8400"] range:NSMakeRange(5, 1)];
                cell.fieldLabel.attributedText = attriString;
                
                [cell.pickerButton addTarget:self action:@selector(openPicker:) forControlEvents:UIControlEventTouchUpInside];

                
                cell.valueTextField.hidden = YES;
                cell.pickerButton.hidden = NO;
                
                if (self.experience) {
                    [cell.pickerButton setTitle:self.experience forState:UIControlStateNormal];
                }
            }
        }
        cell.valueTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"myPhone"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSLog(@" ==== %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"myPhone"]);
        NSLog(@" ==== %@",cell.valueTextField.text);


    }else if (indexPath.row == 4) {
        
        // 如果是陶氏活动
        if (self.couponCampaign.id==38 || self.couponCampaign.id==40){
            //            cell.fieldLabel.hidden = YES;
                        cell.valueTextField.hidden = YES;
//                        cell.pickerButton.hidden = YES;
            NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:@"教育程度 *"];
            [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor colorwithHexString:@"#666666"] range:NSMakeRange(0, 5)];
            [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor colorwithHexString:@"#ff8400"] range:NSMakeRange(5, 1)];
            cell.fieldLabel.attributedText = attriString;
            [cell.pickerButton   addTarget:self action:@selector(openPicker:) forControlEvents:UIControlEventTouchUpInside];

            cell.pickerButton.hidden = NO;
            cell.pickerButton.tag = 102;
            if (self.experience_edu) {
                [cell.pickerButton setTitle:self.experience_edu forState:(UIControlStateNormal)];
                
            }
        }
    }else if (indexPath.row == 5) {
        
        // 如果是陶氏活动
        if (self.couponCampaign.id==38 || self.couponCampaign.id==40){
            //            cell.fieldLabel.hidden = YES;
                        cell.valueTextField.hidden = YES;
//                    cell.pickerButton.hidden = YES;
            
            cell.fieldLabel.numberOfLines = 0;
            
            NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:@"“大户俱乐部”\nAPP使用频率 *"];
            [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor colorwithHexString:@"#666666"] range:NSMakeRange(0, 16)];
            [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor colorwithHexString:@"#ff8400"] range:NSMakeRange(16, 1)];
            cell.fieldLabel.attributedText = attriString;
            [cell.pickerButton   addTarget:self action:@selector(openPicker:) forControlEvents:UIControlEventTouchUpInside];
            cell.pickerButton.hidden = NO;
            cell.pickerButton.tag = 103;
            if (self.experience_rate) {
                [cell.pickerButton setTitle:self.experience_rate forState:(UIControlStateNormal)];
                

            }
        }    }else if (indexPath.row == 6) {
            
            // 如果是陶氏活动
            if (self.couponCampaign.id==38 || self.couponCampaign.id==40){
                //            cell.fieldLabel.hidden = YES;
                           cell.valueTextField.hidden = YES;
                //            cell.pickerButton.hidden = YES;
                
                cell.fieldLabel.numberOfLines = 0;
                
                NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:@"对于陶氏目前\n”大农户俱乐部”\nAPP使用下来，\n最满意的功能 *"];
                [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor colorwithHexString:@"#666666"] range:NSMakeRange(0, 32)];
                [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor colorwithHexString:@"#ff8400"] range:NSMakeRange(32, 1)];
                cell.fieldLabel.attributedText = attriString;
                [cell.pickerButton   addTarget:self action:@selector(openPicker:) forControlEvents:UIControlEventTouchUpInside];
                cell.pickerButton.hidden = NO;
                cell.pickerButton.tag = 104;
                if (self.experience_pleased) {
                    [cell.pickerButton setTitle:self.experience_pleased forState:(UIControlStateNormal)];
                    

                }
            }
        }else if (indexPath.row == 7) {
            
            // 如果是陶氏活动
            if (self.couponCampaign.id==38 || self.couponCampaign.id==40){
                //            cell.fieldLabel.hidden = YES;
                            cell.valueTextField.hidden = YES;
                //            cell.pickerButton.hidden = YES;
                
                cell.fieldLabel.numberOfLines = 0;
                
                NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:@"对于陶氏目前\n”大农户俱乐部”\nAPP使用下来，\n最不满意的功能 *"];
                [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor colorwithHexString:@"#666666"] range:NSMakeRange(0, 33)];
                [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor colorwithHexString:@"#ff8400"] range:NSMakeRange(33, 1)];
                cell.fieldLabel.attributedText = attriString;
                [cell.pickerButton   addTarget:self action:@selector(openPicker:) forControlEvents:UIControlEventTouchUpInside];
                cell.pickerButton.hidden = NO;
                cell.pickerButton.tag = 105;
                if (self.experience_unPleaesd) {
                    [cell.pickerButton setTitle:self.experience_unPleaesd forState:(UIControlStateNormal)];
                    

                }
            }
        }else if (indexPath.row == 8) {
            
            // 如果是陶氏活动
            if (self.couponCampaign.id==38 || self.couponCampaign.id==40){
                //            cell.fieldLabel.hidden = YES;
                            cell.valueTextField.hidden = YES;
                //            cell.pickerButton.hidden = YES;
                
                cell.fieldLabel.numberOfLines = 0;
                
                NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:@"对于陶氏目前\n”大农户俱乐部”\nAPP最希望未\n来增加的功能 *"];
                [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor colorwithHexString:@"#666666"] range:NSMakeRange(0, 31)];
                [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor colorwithHexString:@"#ff8400"] range:NSMakeRange(31, 1)];
                cell.fieldLabel.attributedText = attriString;
                [cell.pickerButton   addTarget:self action:@selector(openPicker:) forControlEvents:UIControlEventTouchUpInside];
                cell.pickerButton.hidden = NO;
                cell.pickerButton.tag = 106;
                if (self.experience_add) {
                    [cell.pickerButton setTitle:self.experience_add forState:(UIControlStateNormal)];
                    

                }
            }
        }else if (indexPath.row == 9) {
            
            // 如果是陶氏活动
            if (self.couponCampaign.id==38 || self.couponCampaign.id==40){
                //            cell.fieldLabel.hidden = YES;
                           cell.valueTextField.hidden = YES;
                //            cell.pickerButton.hidden = YES;
                
                cell.fieldLabel.numberOfLines = 0;
                
                NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:@"您觉得目前陶氏\n”大农户俱乐部”\nAPP给您带来最\n大的价值是什么？ *"];
                [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor colorwithHexString:@"#666666"] range:NSMakeRange(0, 35)];
                [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor colorwithHexString:@"#ff8400"] range:NSMakeRange(35, 1)];
                cell.fieldLabel.attributedText = attriString;
                [cell.pickerButton   addTarget:self action:@selector(openPicker:) forControlEvents:UIControlEventTouchUpInside];
                cell.pickerButton.hidden = NO;
                cell.pickerButton.tag = 107;
                if (self.experience_value) {
                    [cell.pickerButton setTitle:self.experience_value forState:(UIControlStateNormal)];
                }
            }
        }else if (indexPath.row == 10) {
            
            // 如果是陶氏活动
            if (self.couponCampaign.id==38 || self.couponCampaign.id==40){
                //            cell.fieldLabel.hidden = YES;
                //            cell.valueTextField.hidden = YES;
                //            cell.pickerButton.hidden = YES;
                
                cell.fieldLabel.numberOfLines = 0;
                
                NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:@"您是否用过其他公司类似的大农户APP？如有，您觉得相比陶氏，他们在哪些方面提供的服务更好? *"];
                [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor colorwithHexString:@"#666666"] range:NSMakeRange(0, 46)];
                [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor colorwithHexString:@"#ff8400"] range:NSMakeRange(46, 1)];
                cell.fieldLabel.attributedText = attriString;
                cell.valueTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"mySuggest"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.couponCampaign isInsurance] && indexPath.row == 3) {
        return 100;
    }else if (indexPath.row == 5 || indexPath.row == 6 || indexPath.row == 7 || indexPath.row == 8 || indexPath.row == 9){
        return 100;
    }else if (indexPath.row == 10)
        return 150;
    
    return 50;
}

#pragma mark - CClaimCouponTableViewCellDelegate
- (void)textFieldEndEditing:(UITextField *)textField {
//    if (textField.tag == 0) {
//        self.name = textField.text;
//    }
//    else if (textField.tag == 1) {
//        self.crop = textField.text;
//    }
//    else if (textField.tag == 2) {
//        self.area = textField.text;
//    }
//    else if (textField.tag == 3) {
//        self.jiandaAmount = textField.text;
//    }
//    else if (textField.tag == 4) {
//        self.kairunAmount = textField.text;
//    }
//    if (self.couponCampaign.id ==38 || self.couponCampaign.id==40){
//        if (textField.tag == 0) {
//            self.name = textField.text;
//        }
//        else if (textField.tag == 1) {
//            self.address = textField.text;
//        }
//        else if (textField.tag == 2) {
//            self.postcode = textField.text;
//        }
//        else if (textField.tag == 3) {
//            self.contactNumber = textField.text;
//        }
//    }
    
    
    if (self.couponCampaign.id == 38 || self.couponCampaign.id == 40)
    {
        if (textField.tag == 100) {
            self.name = textField.text;
                        NSLog(@"%@", self.name);
            [[NSUserDefaults standardUserDefaults] setObject:self.name forKey:@"myName"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        else if (textField.tag == 101) {
            self.sex = textField.text;
                        NSLog(@"%@", self.sex);
        }
        else if (textField.tag == 102) {
            self.address = textField.text;
                        NSLog(@"%@", self.address);
            [[NSUserDefaults standardUserDefaults] setObject:self.address forKey:@"myAddress"];
            [[NSUserDefaults standardUserDefaults] synchronize];

            
        }else if (textField.tag == 103) {
            self.contactNumber = textField.text;
                        NSLog(@"%@", self.contactNumber);
            [[NSUserDefaults standardUserDefaults] setObject:self.contactNumber forKey:@"myPhone"];
            [[NSUserDefaults standardUserDefaults] synchronize];

            
        }else if (textField.tag == 104) {
            self.experience_edu = textField.text;
            //            NSLog(@"%@", self.experience_edu);
            
        }else if (textField.tag == 105) {
            self.use_rate = textField.text;
            //            NSLog(@"%@", self.use_rate);
            
        }else if (textField.tag == 106) {
            self.pleased = textField.text;
            //            NSLog(@"%@", self.pleased);
            
        }else if (textField.tag == 107) {
            self.unPleased = textField.text;
            //            NSLog(@"%@", self.unPleased);
            
        }else if (textField.tag == 108) {
            self.add_function = textField.text;
            
        }else if (textField.tag == 109) {
            self.value = textField.text;
            //            NSLog(@"%@", self.value);
            
        }else if (textField.tag == 110) {
            self.suggests = textField.text;
            //            NSLog(@"%@", self.suggests);
            [[NSUserDefaults standardUserDefaults] setObject:self.suggests forKey:@"mySuggest"];
            [[NSUserDefaults standardUserDefaults] synchronize];

        }
        

    }else {
    
            if (textField.tag == 0) {
                self.name = textField.text;
            }
            else if (textField.tag == 1) {
                self.crop = textField.text;
            }
            else if (textField.tag == 2) {
                self.area = textField.text;
            }
            else if (textField.tag == 3) {
                self.jiandaAmount = textField.text;
            }
            else if (textField.tag == 4) {
                self.kairunAmount = textField.text;
            }
    }
}

#pragma mark - Delegate


@end
