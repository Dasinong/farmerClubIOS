//
//  CPetDisSolutionViewController2.m
//  FarmNow
//  复杂一点的
//  Created by 朱曦炽 on 16/4/26.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CPetDisSolutionViewController2.h"
#import "CWeatherSectionView.h"
#import "CPetSolutionCell.h"
#import "CCpproductDetailController.h"
#import "CGetPetSoluModel.h"
@interface CPetDisSolutionViewController2 ()
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) CGetPetSoluModel *model;
@end

@implementation CPetDisSolutionViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = 400;
    
    if (self.solution.isRemedy == 0) {
        self.title = @"预防方案详情";
    }
    else {
        self.title = @"治疗方案详情";
    }
    
    CGetPetSoluParam *param = [CGetPetSoluParam new];
    param.petSoluId = self.solution.petSoluId;
    
    [CGetPetSoluModel requestWithParams:param completion:^(CGetPetSoluModel *model, JSONModelError *err) {
        if (!err) {
            self.model = model;
            [self.tableView reloadData];
        }
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return UITableViewAutomaticDimension;
        case 1:
            return 70;
        default:
            break;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 1) {
        NSArray *countNib = [[NSBundle mainBundle] loadNibNamed:@"CWeatherSectionView" owner:self options:nil];
        CWeatherSectionView* sectionView = [countNib objectAtIndex:0];
        [sectionView setTitle:@"相关药物"];
        
        return sectionView;
    }
    
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    
    if (section == 1) {
        return [self.model.cPProducts count];
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 36;
    }
    
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 10;
    }
    
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CPetSolutionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SolutionCell" forIndexPath:indexPath];
        
        [cell setupWithModel:self.solution index:self.solutionIndex];
        
        return cell;
    }
    
    if (indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CPCell" forIndexPath:indexPath];
        
        CIngredientDetailObject *detailObject = self.model.cPProducts[indexPath.row];
        
        UILabel *cpNameLabel = (UILabel *)[cell.contentView viewWithTag:1];
        UILabel *cpIngreLabel = (UILabel *)[cell.contentView viewWithTag:2];
        
        cpNameLabel.text = detailObject.name;
        
        if ([detailObject.activeIngredient count] > 0) {
            cpIngreLabel.text = detailObject.activeIngredient[0];
        }
        else {
            cpIngreLabel.text = @"";
        }
        
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        CCpproductDetailController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CCpproductDetailController"];
        
        CIngredientDetailObject *detailObject = self.model.cPProducts[indexPath.row];
        controller.detailObject = detailObject;
        
        [self.navigationController pushViewController:controller animated:YES];
    }
}
@end
