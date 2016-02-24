//
//  CCropDetailViewController.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/22.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CCropDetailViewController.h"
#import "CWeatherSectionView.h"
#import "CGetFieldModel.h"
#import "CCropDetailHeaderCell.h"
#import "CGetCropDetailsModel.h"
#import "MJRefresh.h"
#import "CTaskCell.h"
#import "CPetDisCell.h"
#import "CTaskListViewController.h"

@interface CCropDetailViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) CField *field;
@property (nonatomic, strong) CCropDetail *cropDetail;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation CCropDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CTaskCell class]) bundle:nil] forCellReuseIdentifier:@"CTaskCell"];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CPetDisCell class]) bundle:nil] forCellReuseIdentifier:@"CPetDisCell"];
    
    [self requestData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestData];
    }];
}

- (void)requestData {
    if (self.subscription.fields.count > 0) {
        CGetFieldParam *param = [CGetFieldParam new];
        NSString *fieldId = [self.subscription.fields allKeys][0];
        param.id = [fieldId integerValue];
        [CGetFieldModel requestWithParams:param completion:^(CGetFieldModel *model, JSONModelError *err) {
            
            [self.tableView.mj_header endRefreshing];
            if (model) {
                self.field = model.field;
                [self.tableView reloadData];
            }
        }];
    }
    else {
        // 暂时没种
        CGetCropDetailsParam *param = [CGetCropDetailsParam new];
        param.id = self.subscription.crop.cropId;
        
        // 没有stageId
        [CGetCropDetailsModel requestWithParams:param completion:^(CGetCropDetailsModel *model, JSONModelError *err) {
            
            [self.tableView.mj_header endRefreshing];
            if (model) {
                self.cropDetail = model.cropDetail;
                [self.tableView reloadData];
            }
        }];
    }
}

- (IBAction)goToWiki:(id)sender {
    NSLog(@"goToWiki");
}

- (IBAction)changeStage:(id)sender {
    NSLog(@"KDK");
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section > 0) {
        return 36;
    }
    
    return CGFLOAT_MIN;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section > 0) {
        NSArray *countNib = [[NSBundle mainBundle] loadNibNamed:@"CWeatherSectionView" owner:self options:nil];
        CWeatherSectionView* sectionView = [countNib objectAtIndex:0];
        
        if (section == 1) {
            [sectionView setTitle:@"近期农事任务"];
        }
        else if (section == 2) {
            [sectionView setTitle:@"常见病虫草害"];
        }
        else {
            [sectionView setTitle:@""];
        }
        
        return sectionView;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 2) {
        return CGFLOAT_MIN;
    }
    return 10;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 152;
        case 1:
            return 100;
        case 2:
            return 230;
        default:
            break;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
        case 1:
            if (self.field) {
                return self.field.taskspecws.count;
            }
            
            if (self.cropDetail) {
                return self.cropDetail.taskspecws.count;
            }
            
            return 0;
        case 2:
            if (self.field) {
                return self.field.petdisspecws.count;
            }
            
            if (self.cropDetail) {
                return self.cropDetail.petdisspecws.count;
            }
            
            return 0;
        default:
            break;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CCropDetailHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeaderCell" forIndexPath:indexPath];
        
        if (self.field) {
            [cell setupWithModel:self.field];
        }
        else if (self.cropDetail) {
            [cell setupWithModel:self.cropDetail];
        }
        
        return cell;
    }
    
    if (indexPath.section == 1) {
        CTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CTaskCell" forIndexPath:indexPath];
        
        CTaskSpec *task;
        if (self.field) {
            task = self.field.taskspecws[indexPath.row];
        }
        
        if (self.cropDetail) {
            task = self.cropDetail.taskspecws[indexPath.row];
        }
        
        if (task) {
            [cell setupWithModel:task];
        }
        
        return cell;
    }
    
    if (indexPath.section == 2) {
        CPetDisCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CPetDisCell" forIndexPath:indexPath];
        
        CPetDisCell *petDis;
        if (self.field) {
            petDis = self.field.petdisspecws[indexPath.row];
        }
        
        if (self.cropDetail) {
            petDis = self.cropDetail.petdisspecws[indexPath.row];
        }
        
        if (petDis) {
            [cell setupWithModel:petDis];
        }
        
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        CTaskSpec *task;
        if (self.field) {
            task = self.field.taskspecws[indexPath.row];
        }
        
        if (self.cropDetail) {
            task = self.cropDetail.taskspecws[indexPath.row];
        }
        
        CTaskListViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CTaskListViewController"];
        controller.taskSpec = task;
        [self.navigationController pushViewController:controller animated:YES];
    }
}
@end
