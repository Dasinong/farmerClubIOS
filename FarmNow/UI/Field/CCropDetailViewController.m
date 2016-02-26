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
#import "CPetDisListViewController.h"
#import <ActionSheetPicker.h>
#import "CChangeFieldStageModel.h"
#import "CCropStageSelectionViewController.h"
#import "CAddWeatherFirstViewController.h"
#import "CWikiViewController.h"
#import "CSeedViewController.h"

@interface CCropDetailViewController () <UITableViewDataSource, UITableViewDelegate> {
    NSInteger currentFieldIndex;
    NSInteger currentStageID;
    NSInteger currentStageSelectionIndex;
}

@property (nonatomic, strong) CField *field;
@property (nonatomic, strong) CCropDetail *cropDetail;
@property (nonatomic, strong) UIButton *navigatoinTitleButton;
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
    
    if (self.subscription.fields.allKeys.count > 0) {
        self.navigatoinTitleButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.navigatoinTitleButton addTarget:self
                   action:@selector(changeField:)
         forControlEvents:UIControlEventTouchUpInside];
        
        NSString *firstField = [self.subscription.fields allValues][0];
        
        [self.navigatoinTitleButton setTitle:firstField forState:UIControlStateNormal];
        self.navigatoinTitleButton.frame = CGRectMake(0, 0, SCREEN_WIDTH - 90, 44.0);
        
        self.navigationItem.titleView = self.navigatoinTitleButton;
    }
    else {
        self.title = self.subscription.crop.cropName;
    }
}

- (void)changeField:(id)sender {
    [ActionSheetStringPicker showPickerWithTitle:@"请选择田" rows:self.subscription.fields.allValues initialSelection:currentFieldIndex doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        currentFieldIndex = selectedIndex;
        NSString *field = [self.subscription.fields allValues][currentFieldIndex];
        [self.navigatoinTitleButton setTitle:field forState:UIControlStateNormal];
        [self requestData];
    } cancelBlock:^(ActionSheetStringPicker *picker) {
        
    } origin:sender];
}

- (void)requestData {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    if (self.subscription.fields.count > 0) {
        CGetFieldParam *param = [CGetFieldParam new];
        NSString *fieldId = [self.subscription.fields allKeys][currentFieldIndex];
        param.id = [fieldId integerValue];
        [CGetFieldModel requestWithParams:param completion:^(CGetFieldModel *model, JSONModelError *err) {
            
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            
            [self.tableView.mj_header endRefreshing];
            if (model) {
                self.field = model.field;
                
                for (int i=0; i<self.field.stagelist.count; i++) {
                    CSubStage *stage = self.field.stagelist[i];
                    
                    if (stage.subStageId == self.field.currentStageID) {
                        currentStageSelectionIndex = i;
                        break;
                    }
                }
                
                [self.tableView reloadData];
            }
        }];
    }
    else {
        // 暂时没种
        CGetCropDetailsParam *param = [CGetCropDetailsParam new];
        param.id = self.subscription.crop.cropId;
        if (currentStageID > 0) {
            param.subStageId = [NSString stringWithFormat:@"%d", (int)currentStageID];
        }
        
        // 没有stageId
        [CGetCropDetailsModel requestWithParams:param completion:^(CGetCropDetailsModel *model, JSONModelError *err) {
            
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            
            [self.tableView.mj_header endRefreshing];
            if (model) {
                self.cropDetail = model.cropDetail;
                
                if (currentStageID == 0 && self.cropDetail.substagews.count > 0) {
                    CSubStage *stage = self.cropDetail.substagews[0];
                    currentStageID = stage.subStageId;
                }
                
                self.cropDetail.currentStageID = currentStageID;
                
                [self.tableView reloadData];
            }
        }];
    }
}

- (void)changeFieldStage {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    CChangeFieldStageParam *param = [CChangeFieldStageParam new];
    param.fieldId = self.field.fieldId;
    param.subStageId = currentStageID;
    
    [CChangeFieldStageModel requestWithParams:POST params:param completion:^(CChangeFieldStageModel *model, JSONModelError *err) {
        if (!err) {
            [self requestData];
        }
        else {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        }
    }];
}

- (IBAction)goToWiki:(id)sender {
    CSeedContentItem *item = [[CSeedContentItem alloc] init];
    item.cropId = self.subscription.crop.cropId;
    item.cropName = self.subscription.crop.cropName;
    
    CWikiViewController* controller = [self.storyboard controllerWithID:@"CWikiViewController"];
    controller.seedItem = item;
    controller.type = eChongHai;
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)addField:(id)sender {
    [CCropStageSelectionViewController shared_].cropId = self.subscription.crop.cropId;
    [CCropStageSelectionViewController shared_].cropName = self.subscription.crop.cropName;
    
    CAddWeatherFirstViewController* controller = [self.storyboard controllerWithID:@"CAddWeatherFirstViewController"];
    controller.type = eFarm;
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)changeStage:(id)sender {
    __block NSArray *subStageList = nil;
    
    if (self.field) {
        subStageList = self.field.stagelist;
        currentStageID = self.field.currentStageID;
    }
    else if (self.cropDetail) {
        subStageList = self.cropDetail.substagews;
        currentStageID = self.cropDetail.currentStageID;
    }
    
    if (subStageList) {
        NSMutableArray *stageNameList = [NSMutableArray array];
        
        for (CSubStage *stage in subStageList) {
            [stageNameList addObject:[stage stageDisplayName]];
        }
        
        [ActionSheetStringPicker showPickerWithTitle:@"请选择当前阶段" rows:stageNameList initialSelection:currentStageSelectionIndex doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
            currentStageSelectionIndex = selectedIndex;
            CSubStage *stage = subStageList[selectedIndex];
            currentStageID = stage.subStageId;
            
            if (self.field) {
                [self changeFieldStage];
            }
            else {
                [self requestData];
            }
            
        } cancelBlock:^(ActionSheetStringPicker *picker) {
            
        } origin:sender];
    }
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
        
        CPetDisSpec *petDis;
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
    else if (indexPath.section == 2) {
        
        CPetDisSpec *petDis;
        if (self.field) {
            petDis = self.field.petdisspecws[indexPath.row];
        }
        
        if (self.cropDetail) {
            petDis = self.cropDetail.petdisspecws[indexPath.row];
        }
        
        CPetDisListViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CPetDisListViewController"];
        controller.petDis = petDis;
        [self.navigationController pushViewController:controller animated:YES];
    }
    
}
@end
