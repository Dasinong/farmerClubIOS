//
//  CAddCropViewController.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/22.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CAddCropViewController.h"
#import "CCrop.h"
#import "CSubscriableCropsModel.h"
#import "CCreateCropSubscriptionModel.h"

@interface CAddCropViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSMutableArray *selectedArray;
@end

@implementation CAddCropViewController
- (void)awakeFromNib {
    [super awakeFromNib];
    self.hidesBottomBarWhenPushed = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = @[];
    self.selectedArray = [NSMutableArray array];
    
    // Request Data
    CSubscriableCropsParam *param = [CSubscriableCropsParam new];
    [CSubscriableCropsModel requestWithParams:param completion:^(CSubscriableCropsModel *model, JSONModelError *err) {
        self.dataArray = model.crops;
        [self.selectedArray removeAllObjects];
        for (int i=0; i<self.dataArray.count; i++) {
            [self.selectedArray addObject:@(NO)];
        }
        [self.tableView reloadData];
    }];
}

- (IBAction)submit:(id)sender {
    NSMutableArray *selectedCrops = [NSMutableArray array];
    for (int i=0; i<self.dataArray.count; i++) {
        CCrop *crop = self.dataArray[i];
        BOOL selected = [self.selectedArray[i] boolValue];
        
        if (selected) {
            [selectedCrops addObject:[NSString stringWithFormat:@"%d", (int)crop.cropId]];
        }
    }
    
    CCreateCropSubscriptionParam *param = [CCreateCropSubscriptionParam new];
    param.cropId = [selectedCrops componentsJoinedByString:@","];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [CCreateCropSubscriptionModel requestWithParams:POST params:param completion:^(CCreateCropSubscriptionModel *model, JSONModelError *err) {
        [MBProgressHUD hideHUDForView:self.view animated:NO];
        
        if (model) {
            if ([self.delegate respondsToSelector:@selector(addCropCompelted)]) {
                [self.delegate addCropCompelted];
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    BOOL selected = [self.selectedArray[indexPath.row] boolValue];
    CCrop *crop = self.dataArray[indexPath.row];
    
    UIImageView *checkbox = (UIImageView*)[cell.contentView viewWithTag:1];
    UILabel *cropNameLabel = (UILabel*)[cell.contentView viewWithTag:2];
    
    if (selected) {
        checkbox.image = [UIImage image_s:@"crop_checkbox_selected"];
    }
    else {
        checkbox.image = [UIImage image_s:@"crop_checkbox"];
    }
    
    cropNameLabel.text = crop.cropName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BOOL selected = ![self.selectedArray[indexPath.row] boolValue];
    [self.selectedArray replaceObjectAtIndex:indexPath.row withObject:@(selected)];
    
    [self.tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];
}
@end
