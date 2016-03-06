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
#import "CBrowseCPProductByModelModel.h"
#import "CGetCpprductsByIngredientModel.h"
#import "CBrowseCustomizedCPProductModel.h"
#import "CIngredientDetailObject.h"
#import "CCpproductDetailController.h"
#import "CWebViewController.h"

@interface CKindViewController ()
@property (nonatomic, strong) NSArray *sections;
@end

@implementation CKindViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.sections = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", @"#"];
    
    if (self.type == ePinZhong) {
        self.title                              = self.seedItem.cropName;
        
        CBrowseVarietyByCropIdParams* params    = [CBrowseVarietyByCropIdParams new];
        params.cropId                           = self.seedItem.cropId ;
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [CBrowseVarietyByCropIdModel requestWithParams:params completion:^(CBrowseVarietyByCropIdModel* model, JSONModelError *err) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            if (err == nil && model ) {
                UITableViewModel* talbeModel            = [UITableViewModel new];
                for (CVarietyBrowseObjectModel* object in [self sortedArray:model.data]) {
                    [talbeModel addRow:TABLEVIEW_ROW(@"titlecell", object) forSection:[self sectionForString:object.varietyNamePY]];
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
                for (CIngredientBrowseObject* object in [self sortedArray:model.data]) {
                    [talbeModel addRow:TABLEVIEW_ROW(@"titlecell", object) forSection:[self sectionForString:object.activeIngredientPY]];
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
                for (CIngredientDetailObject* object in model.data) {
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
    else if (self.type == eBASF){
        
        CBrowseCustomizedCPProductParams* params = [CBrowseCustomizedCPProductParams new];
        params.manufacturer = @"巴斯夫";
        
        if ([self.title isEqualToString:@"公共卫生"]) {
            params.model = @"专业解决方案 有害生物控制";
        }
        else {
            params.model = self.title;
        }
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        [CBrowseCustomizedCPProductModel requestWithParams:params completion:^(CBrowseCustomizedCPProductModel* model, JSONModelError *err) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            if (err == nil && model ) {
                UITableViewModel* talbeModel            = [UITableViewModel new];
                for (CIngredientDetailObject* object in model.data) {
                    [talbeModel addRow:TABLEVIEW_ROW(@"titlecell", object) forSection:0];
                }
                [self updateModel:talbeModel];
            }
        }];
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
        
        CCpproductDetailController *controller = [self.storyboard controllerWithID:@"CCpproductDetailController"];
        controller.type = @"variety";
        controller.id = object.varietyId;
        [self.navigationController pushViewController:controller animated:YES];
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
        CCpproductDetailController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CCpproductDetailController"];
        controller.detailObject = data;
        [self.navigationController pushViewController:controller animated:YES];
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
    else if (self.type == eBASF)
    {
        CCpproductDetailController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CCpproductDetailController"];
        controller.detailObject = data;
        [self.navigationController pushViewController:controller animated:YES];
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.type == ePinZhong || self.type == eIngredient) {
        return 27;
    }
    else {
        return 1;
    }
}


- (BOOL)isAlphabet:(char)initialChar {
    return (initialChar >= 'a' && initialChar <= 'z') || (initialChar >= 'A' && initialChar <= 'Z');
}

- (NSArray *)sortedArray:(NSArray *)data {
    return [data sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([obj1 isKindOfClass:[CVarietyBrowseObjectModel class]]) {
            CVarietyBrowseObjectModel *m1 = (CVarietyBrowseObjectModel*)obj1;
            CVarietyBrowseObjectModel *m2 = (CVarietyBrowseObjectModel*)obj2;
            
            char m1char = [[m1.varietyNamePY lowercaseString] characterAtIndex:0];
            char m2char = [[m2.varietyNamePY lowercaseString] characterAtIndex:0];
            
            if ([self isAlphabet:m1char] && ![self isAlphabet:m2char]) {
                return NSOrderedAscending;
            }
            
            if (![self isAlphabet:m1char] && [self isAlphabet:m2char]) {
                return NSOrderedDescending;
            }
            
            return [[m1.varietyNamePY lowercaseString] compare:[m2.varietyNamePY lowercaseString]];
        }
        
        if ([obj1 isKindOfClass:[CIngredientBrowseObject class]]) {
            CIngredientBrowseObject *m1 = (CIngredientBrowseObject*)obj1;
            CIngredientBrowseObject *m2 = (CIngredientBrowseObject*)obj2;
            
            char m1char = [[m1.activeIngredientPY lowercaseString] characterAtIndex:0];
            char m2char = [[m2.activeIngredientPY lowercaseString] characterAtIndex:0];
            
            if ([self isAlphabet:m1char] && ![self isAlphabet:m2char]) {
                return NSOrderedAscending;
            }
            
            if (![self isAlphabet:m1char] && [self isAlphabet:m2char]) {
                return NSOrderedDescending;
            }
            
            return [[m1.activeIngredientPY lowercaseString] compare:[m2.activeIngredientPY lowercaseString]];
        }
        
        return NSOrderedSame;
    }];
}

- (NSInteger)sectionForString:(NSString *)titleString {
    if (titleString.length > 0) {
        if ([self isAlphabet:[titleString characterAtIndex:0]]) {
            NSString *firstChar = [titleString substringToIndex:1];
            
            return [self.sections indexOfObject:[firstChar uppercaseString]];
        }
    }
    
    return [self.sections count] - 1;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (self.type == ePinZhong || self.type == eIngredient) {
        return self.sections;
    }
    else {
        return nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    [MBProgressHUD info:title];
    return [self sectionForString:title];
}

@end
