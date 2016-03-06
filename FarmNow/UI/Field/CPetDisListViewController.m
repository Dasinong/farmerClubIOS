//
//  CPetDisListViewController.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/24.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CPetDisListViewController.h"
#import "CWeatherSectionView.h"
#import "SDCycleScrollView.h"
#import "CPetDisSolutionViewController.h"
#import "CGetPetDisSpecBaiKeByIdModel.h"

@interface CPetDisListViewController () {
    NSInteger currentSegmentIndex;
}

@end

@implementation CPetDisListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.estimatedRowHeight = 200;
    
    if (self.petDis == nil) {
        CGetPetDisSpecBaiKeByIdParams *param = [CGetPetDisSpecBaiKeByIdParams new];
        param.id = self.id;
        [CGetPetDisSpecBaiKeByIdModel requestWithParams:param completion:^(CGetPetDisSpecBaiKeByIdModel *model, JSONModelError *err) {
            if (err == nil) {
                self.petDis = model.data;
                self.title = self.petDis.petDisSpecName;
                [self.tableView reloadData];
            }
        }];
    }
    else {
        self.title = self.petDis.petDisSpecName;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)segmentChanged:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    currentSegmentIndex = segmentedControl.selectedSegmentIndex;
    [self.tableView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 250;
        case 1:
            return UITableViewAutomaticDimension;
        case 2:
            return UITableViewAutomaticDimension;
        default:
            break;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 2) {
        NSArray *countNib = [[NSBundle mainBundle] loadNibNamed:@"CWeatherSectionView" owner:self options:nil];
        CWeatherSectionView* sectionView = [countNib objectAtIndex:0];
        [sectionView setTitle:@"治疗方法"];
        
        return sectionView;
    }
    
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    
    if (section == 1) {
        return 1;
    }
    
    if (section == 2) {
        return self.petDis.solutions.count;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        return 36;
    }
    
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1) {
        return 10;
    }
    return CGFLOAT_MIN;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ImageCell" forIndexPath:indexPath];
        
        SDCycleScrollView *cycleScrollView = [cell.contentView viewWithTag:1];
        if (cycleScrollView == nil) {
            SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:cell.contentView.bounds delegate:nil placeholderImage:nil];
            cycleScrollView.tag = 1;
            cycleScrollView.infiniteLoop = NO;
            cycleScrollView.autoScroll = NO;
            cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFit;
            [cell.contentView addSubview:cycleScrollView];
        }
        
        cycleScrollView.imageURLStringsGroup = self.petDis.imagesPath;
        return cell;
    }
    
    if (indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell" forIndexPath:indexPath];
        
        UILabel *textLabel = (UILabel *)[cell.contentView viewWithTag:1];
        
        switch (currentSegmentIndex) {
            case 0:
                textLabel.text = self.petDis.sympton;
                break;
            case 1:
                textLabel.text = self.petDis.form;
                break;
            case 2:
                textLabel.text = self.petDis.habbit;
                break;
            case 3:
                textLabel.text = self.petDis.rule;
                break;
                
            default:
                break;
        }
        
        [cell setNeedsLayout];
        [cell layoutIfNeeded];
        
        return cell;
    }
    
    if (indexPath.section == 2) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SolutionCell" forIndexPath:indexPath];
        
        UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:1];
        UILabel *textLabel = (UILabel *)[cell.contentView viewWithTag:2];
        
        CPetSolution *solution = self.petDis.solutions[indexPath.row];
        titleLabel.text = [NSString stringWithFormat:@"治疗方案%c", 'A' + (int)indexPath.row];
        textLabel.text = solution.petSoluDes;
        
        [cell setNeedsLayout];
        [cell layoutIfNeeded];
        
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 2) {
        CPetSolution *solution = self.petDis.solutions[indexPath.row];
        NSString *solutionName = [NSString stringWithFormat:@"治疗方案%c", 'A' + (int)indexPath.row];
        
        CPetDisSolutionViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CPetDisSolutionViewController"];
        controller.solution = solution;
        controller.solutionName = solutionName;
        [self.navigationController pushViewController: controller animated:YES];
    }
}
@end
