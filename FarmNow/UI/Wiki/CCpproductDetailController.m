//
//  CCpproductDetailController.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/3/1.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CCpproductDetailController.h"
#import "SDCycleScrollView.h"
#import "CGetFormattedCPProductByIdModel.h"
#import "CGetVarietyBaiKeByIdModel.h"
#import "CGetPetDisSpecBaiKeByIdModel.h"
@interface CCpproductDetailController ()  <UITableViewDataSource, UITableViewDelegate>  {
    NSInteger currentSegmentIndex;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CCpproductDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = self.detailObject.name;
    
    if (self.detailObject == nil) {
        
        NSLog(@"%@",self.type); // pesticide,variety, pest
        
        if ([self.type isEqualToString:@"variety"]) {
            CGetVarietyBaiKeByIdParams *param = [CGetVarietyBaiKeByIdParams new];
            param.id = self.id;
            [CGetVarietyBaiKeByIdModel requestWithParams:param completion:^(CGetVarietyBaiKeByIdModel *model, JSONModelError *err) {
                if (err == nil) {
                    NSDictionary *dict = model.data;
                    self.detailObject = [self varietyToIngredientDetailObject:dict];
                    self.title = self.detailObject.name;
                    [self.tableView reloadData];
                }
            }];
        }
        else if ([self.type isEqualToString:@"pest"]) {
            CGetPetDisSpecBaiKeByIdParams *param = [CGetPetDisSpecBaiKeByIdParams new];
            param.id = self.id;
            [CGetPetDisSpecBaiKeByIdModel requestWithParams:param completion:^(CGetPetDisSpecBaiKeByIdModel *model, JSONModelError *err) {
                if (err == nil) {
                    NSDictionary *dict = model.data;
                    self.detailObject = [self pestToIngredientDetailObject:dict];
                    self.title = self.detailObject.name;
                    [self.tableView reloadData];
                }
            }];
        }
        else {
            CGetFormattedCPProductByIdParams *param = [CGetFormattedCPProductByIdParams new];
            param.id = self.id;
            
            [CGetFormattedCPProductByIdModel requestWithParams:param completion:^(CGetFormattedCPProductByIdModel *model, JSONModelError *err) {
                if (err == nil) {
                    self.detailObject = model.data;
                    self.title = self.detailObject.name;
                    [self.tableView reloadData];
                }
            }];

        }
    }
}

// 这里不想建很多很类了，做个桥接
- (CIngredientDetailObject *)varietyToIngredientDetailObject:(NSDictionary *)dict {
    CIngredientDetailObject *detailObject= [[CIngredientDetailObject alloc] init];
    
    detailObject.id = [dict[@"id"] integerValue];
    detailObject.activeIngredient = @[dict[@"registrationId"]];
    detailObject.activeIngredientUsage = @[@""];
    detailObject.type = dict[@"owner"];
    detailObject.manufacturer = dict[@"suitableArea"];
    detailObject.name = dict[@"varietyName"];
    detailObject.desc = dict[@"yieldPerformance"];
    detailObject.tip = dict[@"characteristics"];
    
    return detailObject;
}
- (CIngredientDetailObject *)pestToIngredientDetailObject:(NSDictionary *)dict {
    CIngredientDetailObject *detailObject= [[CIngredientDetailObject alloc] init];
    
    detailObject.id = [dict[@"id"] integerValue];
    detailObject.activeIngredient = @[dict[@"registrationId"]];
    detailObject.activeIngredientUsage = @[@""];
    detailObject.name = dict[@"varietyName"];
    
    return detailObject;
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

- (NSInteger)adjustSementedIndex {
    if ([self.type isEqualToString:@"variety"]) {
        return currentSegmentIndex+1;
    }
    
    return currentSegmentIndex;
}

- (IBAction)segmentChanged:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    currentSegmentIndex = segmentedControl.selectedSegmentIndex;
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 9 + self.detailObject.instructions.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 8) {
        return 2;
    }
    
    if (section >= 9) {
        //NSDictionary *instruction = self.detailObject.instructions[section - 9];
        //return instruction.allKeys.count;
        
        return 5;
    }
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (self.detailObject.pictures.count > 0) {
            return 180; // Image
        }
        else {
            return 0;
        }
    }
    else if (indexPath.section == 1) {
        if (self.detailObject.slogan.length > 0) {
            return 44;
        }
        else {
            return 0;
        }
    }
    else if (indexPath.section == 2) { // 有效成分
        if (self.detailObject.activeIngredient.count > 0) {
            return UITableViewAutomaticDimension;
        }
        else {
            return 0;
        }
    }
    else if (indexPath.section == 3) { // 剂型
        if (self.detailObject.type.length > 0) {
            return UITableViewAutomaticDimension;
        }
        else {
            return 0;
        }
    }
    else if (indexPath.section == 4) { // 剂型
        if (self.detailObject.manufacturer.length > 0) {
            return UITableViewAutomaticDimension;
        }
        else {
            return 0;
        }
    }
    else if (indexPath.section == 5) { // 登记号
        if (self.detailObject.registrationId.length > 0) {
            return UITableViewAutomaticDimension;
        }
        else {
            return 0;
        }
    }
    else if (indexPath.section == 6) { // 联系方式
        if (self.detailObject.telephone.length > 0) {
            return UITableViewAutomaticDimension;
        }
        else {
            return 0;
        }
    }
    else if (indexPath.section == 7) { // SegementCell
        return 85;
    }
    else if (indexPath.section == 8) { // 长label
        
        NSInteger adjustedIndex = [self adjustSementedIndex];
        
        if (adjustedIndex == 0) {
            return 0;
        }
        
        if (adjustedIndex == 1) {
            if (indexPath.row == 0) {
                if (self.detailObject.desc.length > 0) {
                    return UITableViewAutomaticDimension;
                }
                else {
                    return 0;
                }
            }
            
            if (indexPath.row == 1) {
                if (self.detailObject.feature.length > 0 || self.detailObject.guideline.length > 0) {
                    return UITableViewAutomaticDimension;
                }
                else {
                    return 0;
                }
            }
        }
        else {
            if (indexPath.row == 0) {
                return UITableViewAutomaticDimension;
            }
            else {
                return 0;
            }
        }
    }
    else if (indexPath.section >= 9) { // 表格
        if ([self adjustSementedIndex] != 0) {
            return 0;
        }
        
        NSDictionary *instruction = self.detailObject.instructions[indexPath.section - 9];
        if (indexPath.row == 0) {
            if (instruction[@"crop"] && ![instruction[@"crop"] isKindOfClass:[NSNull class]]) {
                return UITableViewAutomaticDimension;
            }
        }
        else if (indexPath.row == 1) {
            if (instruction[@"disease"] && ![instruction[@"disease"] isKindOfClass:[NSNull class]]) {
                return UITableViewAutomaticDimension;
            }
        }
        else if (indexPath.row == 2) {
            if (instruction[@"volume"] && ![instruction[@"volume"] isKindOfClass:[NSNull class]]) {
                return UITableViewAutomaticDimension;
            }
        }
        else if (indexPath.row == 3) {
            if (instruction[@"method"] && ![instruction[@"method"] isKindOfClass:[NSNull class]]) {
                return UITableViewAutomaticDimension;
            }
        }
        else if (indexPath.row == 4) {
            if (instruction[@"guideline"] && ![instruction[@"guideline"] isKindOfClass:[NSNull class]]) {
                return UITableViewAutomaticDimension;
            }
        }
        
        return 0;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ImageCell" forIndexPath:indexPath];
        
        SDCycleScrollView *cycleScrollView = [cell.contentView viewWithTag:1];
        cycleScrollView.infiniteLoop = NO;
        cycleScrollView.autoScroll = NO;
        cycleScrollView.backgroundColor = [UIColor whiteColor];
        cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFit;
        cycleScrollView.imageURLStringsGroup = self.detailObject.pictures;
        return cell;
    }
    else if (indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SloganCell" forIndexPath:indexPath];
        
        UILabel *sloganLabel = [cell.contentView viewWithTag:1];
        sloganLabel.text = self.detailObject.slogan;
        return cell;
    }
    else if (indexPath.section == 2) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OutlineCell" forIndexPath:indexPath];
        
        UILabel *titleLabel = [cell.contentView viewWithTag:1];
        UILabel *contentLabel = [cell.contentView viewWithTag:2];
        UIButton *button = [cell.contentView viewWithTag:3];
        button.hidden = YES;
        
        if ([self.type isEqualToString:@"variety"]) {
            titleLabel.text = @"审核号";
        }
        else if ([self.type isEqualToString:@"pest"]) {
            titleLabel.text = @"是";
        }
        else {
            titleLabel.text = @"有效成分";
        }
        
        NSString *content = @"";
        for (int i=0; i<self.detailObject.activeIngredient.count; i++) {
            NSString *activeIngredient = self.detailObject.activeIngredient[i];
            NSString *activeIngredientUsage = self.detailObject.activeIngredientUsage[i];
            
            if (i > 0) {
                content = [content stringByAppendingString:@"\n"];
            }
            content = [NSString stringWithFormat:@"%@%@  %@", content, activeIngredient, activeIngredientUsage];
        }
        contentLabel.text = content;
        contentLabel.hidden = NO;
        
        [cell setNeedsLayout];
        [cell layoutIfNeeded];
        
        return cell;
    }
    else if (indexPath.section == 3) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OutlineCell" forIndexPath:indexPath];
        
        UILabel *titleLabel = [cell.contentView viewWithTag:1];
        UILabel *contentLabel = [cell.contentView viewWithTag:2];
        UIButton *button = [cell.contentView viewWithTag:3];
        button.hidden = YES;
        
        if ([self.type isEqualToString:@"variety"]) {
            titleLabel.text = @"育种单位";
        }
        else if ([self.type isEqualToString:@"pest"]) {
            titleLabel.text = @"是";
        }
        else {
            titleLabel.text = @"剂型";
        }
        
        contentLabel.hidden = NO;
        contentLabel.text = self.detailObject.type;
        
        [cell setNeedsLayout];
        [cell layoutIfNeeded];
        
        return cell;
    }
    else if (indexPath.section == 4) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OutlineCell" forIndexPath:indexPath];
        
        UILabel *titleLabel = [cell.contentView viewWithTag:1];
        UILabel *contentLabel = [cell.contentView viewWithTag:2];
        UIButton *button = [cell.contentView viewWithTag:3];
        button.hidden = YES;
        
        if ([self.type isEqualToString:@"variety"]) {
            titleLabel.text = @"适宜地区";
        }
        else if ([self.type isEqualToString:@"pest"]) {
            titleLabel.text = @"是";
        }
        else {
            titleLabel.text = @"生产厂家";
        }
        
        contentLabel.hidden = NO;
        contentLabel.text = self.detailObject.manufacturer;
        
        [cell setNeedsLayout];
        [cell layoutIfNeeded];
        
        return cell;
    }
    else if (indexPath.section == 5) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OutlineCell" forIndexPath:indexPath];
        
        UILabel *titleLabel = [cell.contentView viewWithTag:1];
        UILabel *contentLabel = [cell.contentView viewWithTag:2];
        UIButton *button = [cell.contentView viewWithTag:3];
        button.hidden = YES;
        titleLabel.text = @"登记号";
        contentLabel.hidden = NO;
        contentLabel.text = self.detailObject.registrationId;
        
        [cell setNeedsLayout];
        [cell layoutIfNeeded];
        
        return cell;
    }
    else if (indexPath.section == 6) { // 联系方式
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OutlineCell" forIndexPath:indexPath];
        
        UILabel *titleLabel = [cell.contentView viewWithTag:1];
        UILabel *contentLabel = [cell.contentView viewWithTag:2];
        UIButton *button = [cell.contentView viewWithTag:3];
        titleLabel.text = @"联系方式";
        contentLabel.hidden = YES;
        button.hidden = NO;
        
        [button setTitle:self.detailObject.telephone forState:UIControlStateNormal];
        
        [cell setNeedsLayout];
        [cell layoutIfNeeded];
        
        return cell;
    }
    else if (indexPath.section == 7) { // SegementCell
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SegementCell" forIndexPath:indexPath];
        
        UISegmentedControl *segmentedControl = (UISegmentedControl *)[cell.contentView viewWithTag:1];
        
        if ([self.type isEqualToString:@"variety"]) {
            [segmentedControl setTitle:@"产量表现" forSegmentAtIndex:0];
            [segmentedControl setTitle:@"品种特性" forSegmentAtIndex:1];
          
            if (segmentedControl.numberOfSegments > 2) {
                [segmentedControl removeSegmentAtIndex:2 animated:NO];
            }
        }
        else if ([self.type isEqualToString:@"pest"]) {
            if (self.detailObject.guideline.length > 0) {
                [segmentedControl setTitle:@"用药指导" forSegmentAtIndex:1];
            }
            else {
                [segmentedControl setTitle:@"产品特点" forSegmentAtIndex:1];
            }
        }
        else {
            if (self.detailObject.guideline.length > 0) {
                [segmentedControl setTitle:@"用药指导" forSegmentAtIndex:1];
            }
            else {
                [segmentedControl setTitle:@"产品特点" forSegmentAtIndex:1];
            }
        }
        
        return cell;
    }
    else if (indexPath.section == 8) { // 长label
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MutilLabelCell" forIndexPath:indexPath];
        
        UILabel *titleLabel = [cell.contentView viewWithTag:1];
        UILabel *contentLabel = [cell.contentView viewWithTag:2];
        
        NSInteger adjustedSegmentIndex = [self adjustSementedIndex];
        
        if (adjustedSegmentIndex == 1) {
            if (indexPath.row == 0) {
                if ([self.type isEqualToString:@"variety"]) {
                    titleLabel.text = @"产量表现";
                }
                else if ([self.type isEqualToString:@"pest"]) {
                    titleLabel.text = @"是";
                }
                else {
                    titleLabel.text = @"产品介绍";
                }
                contentLabel.text = self.detailObject.desc;
            }
            else if (indexPath.row == 1) {
                if (self.detailObject.guideline.length > 0) {
                    titleLabel.text = @"用药指导";
                    contentLabel.text = self.detailObject.guideline;
                }
                else {
                    titleLabel.text = @"产品特性";
                    contentLabel.text = self.detailObject.feature;
                }
            }
        }
        else if (adjustedSegmentIndex == 2) {
            if ([self.type isEqualToString:@"variety"]) {
                titleLabel.text = @"品种特性";
            }
            else if ([self.type isEqualToString:@"pest"]) {
                titleLabel.text = @"是";
            }
            else {
                titleLabel.text = @"注意事项";
            }
            
            if (self.detailObject.tip.length > 0) {
                contentLabel.text = self.detailObject.tip;
            }
            else {
                contentLabel.text = @"无";
            }
        }
        
        [cell setNeedsLayout];
        [cell layoutIfNeeded];
        
        return cell;
    }
    else if (indexPath.section >= 9) { // 表格
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableCell" forIndexPath:indexPath];
        
        UILabel *titleLabel = [cell.contentView viewWithTag:1];
        UILabel *contentLabel = [cell.contentView viewWithTag:2];
        UIView *topLine = [cell.contentView viewWithTag:3];
        
        topLine.hidden = indexPath.row != 0;
        
        NSDictionary *instruction = self.detailObject.instructions[indexPath.section - 9];
        
        if (indexPath.row == 0) {
            titleLabel.text = @"使用作物";
            contentLabel.text = instruction[@"crop"];
        }
        else if (indexPath.row == 1) {
            titleLabel.text = @"防止对象";
            contentLabel.text = instruction[@"disease"];
        }
        else if (indexPath.row == 2) {
            titleLabel.text = @"用药量";
            contentLabel.text = instruction[@"volume"];
        }
        else if (indexPath.row == 3) {
            titleLabel.text = @"施用方法";
            contentLabel.text = instruction[@"method"];
        }
        else if (indexPath.row == 4) {
            titleLabel.text = @"施药指导";
            
            if (instruction[@"guideline"] && ![instruction[@"guideline"] isKindOfClass:[NSNull class]]) {
                contentLabel.text = instruction[@"guideline"];
            }
        }
        
        [cell setNeedsLayout];
        [cell layoutIfNeeded];
        
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if ([self adjustSementedIndex] == 0) {
        if (section >= 9) {
            return 20;
        }
    }

    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [self tableView:self.tableView heightForFooterInSection:section])];
    bg.backgroundColor = [UIColor whiteColor];
    return bg;
}

- (IBAction)call:(id)sender {
    NSString *phoneNum = [NSString stringWithFormat:@"tel://%@" , self.detailObject.telephone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNum]];
}
@end
