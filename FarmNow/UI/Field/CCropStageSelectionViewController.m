//
//  CCropStageSelectionViewController.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/22.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CCropStageSelectionViewController.h"
#import <ActionSheetPicker.h>
#import "CGetStagesModel.h"
#import "CSubStage.h"
#import "CCreateFieldModel.h"

@interface CCropStageSelectionViewController () {
    NSInteger currentSelectionIndex;
}
@property (weak, nonatomic) IBOutlet UIButton *stagePicker;
@property (nonatomic, strong) NSArray *stageNameArray;
@property (nonatomic, strong) NSArray *stageArray;
@end

@implementation CCropStageSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.stagePicker.layer.borderWidth = 1.0;
    self.stagePicker.layer.borderColor = COLOR(0xBCBDBE).CGColor;
    
    self.stagePicker.imageEdgeInsets = UIEdgeInsetsMake(0, SCREEN_WIDTH - 30 - 40, 0, 0);
    
    currentSelectionIndex = 0;
    self.stageNameArray = @[];
    
    
    CGetStagesParam *param = [CGetStagesParam new];
    param.cropId = [CCropStageSelectionViewController shared_].cropId;
    [CGetStagesModel requestWithParams:GET params:param completion:^(CGetStagesModel *model, JSONModelError *err) {
        if (!err) {
            self.stageArray = model.data;
            
            NSMutableArray *array = [NSMutableArray array];
            for (CSubStage *stage in model.data) {
                [array addObject:[stage stageDisplayName]];
            }
            
            self.stageNameArray = array;
        }
    }];
    
}

- (IBAction)pickStage:(id)sender {
    if (self.stageNameArray.count > 0) {
        [ActionSheetStringPicker showPickerWithTitle:@"请选择生长周期" rows:self.stageNameArray initialSelection:currentSelectionIndex doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
            currentSelectionIndex = selectedIndex;
            
            [self.stagePicker setTitle:selectedValue forState:UIControlStateNormal];
        } cancelBlock:^(ActionSheetStringPicker *picker) {
            
        } origin:sender];
    }
    else {
        [MBProgressHUD alert:@"正在下载数据..."];
    }
}

- (IBAction)sure:(id)sender {
    if ([self.stagePicker.titleLabel.text isEqualToString:@"请选择"]) {
        [MBProgressHUD alert:@"请完善作物生长阶段，或者选择我不知道"];
        return;
    }
    
    [self submit];
}

- (IBAction)notSure:(id)sender {
    currentSelectionIndex = 0;
    [self submit];
}

- (void)submit {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    CCreateFieldParam *param = [CCreateFieldParam new];
    param.cropId = [CCropStageSelectionViewController shared_].cropId;
    param.area = [CCropStageSelectionViewController shared_].area;
    
    CSubStage *stage = self.stageArray[currentSelectionIndex];
    param.currentStageId = stage.subStageId;
    param.locationId = [CCropStageSelectionViewController shared_].locationId;
    
    param.fieldName = [NSString stringWithFormat:@"%@%@",[CCropStageSelectionViewController shared_].cunName, [CCropStageSelectionViewController shared_].cropName];
    
    [CCreateFieldModel requestWithParams:POST params:param completion:^(id model, JSONModelError *err) {
        [MBProgressHUD hideHUDForView:self.view animated:NO];
        
        if (!err) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }];
}
@end
