//
//  CCropStageSelectionViewController.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/22.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CCropStageSelectionViewController.h"
#import <ActionSheetPicker.h>

@interface CCropStageSelectionViewController () {
    NSInteger currentSelectionIndex;
}
@property (weak, nonatomic) IBOutlet UIButton *stagePicker;
@property (nonatomic, strong) NSArray *stageNameArray;
@end

@implementation CCropStageSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.stagePicker.layer.borderWidth = 1.0;
    self.stagePicker.layer.borderColor = COLOR(0xBCBDBE).CGColor;
    
    currentSelectionIndex = 0;
    self.stageNameArray = @[@"播种前",@"播种"];
}

- (IBAction)pickStage:(id)sender {
    [ActionSheetStringPicker showPickerWithTitle:@"请选择生长周期" rows:self.stageNameArray initialSelection:currentSelectionIndex doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        currentSelectionIndex = selectedIndex;
        
        [self.stagePicker setTitle:selectedValue forState:UIControlStateNormal];
    } cancelBlock:^(ActionSheetStringPicker *picker) {
        
    } origin:sender];
}

- (IBAction)sure:(id)sender {
    if ([self.stagePicker.titleLabel.text isEqualToString:@"请选择"]) {
        [MBProgressHUD alert:@"请完善作物生长阶段，或者选择我不知道"];
        return;
    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)notSure:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
