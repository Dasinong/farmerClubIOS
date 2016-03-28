//
//  CStockViewController.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/3/28.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CStockViewController.h"
#import "CGetWinsafeProductInfoModel.h"

@interface CStockViewController ()
@property (weak, nonatomic) IBOutlet UILabel *boxcodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *proidLabel;
@property (weak, nonatomic) IBOutlet UILabel *prospecialLabel;

@end

@implementation CStockViewController

- (void)viewDidLoad {
    self.boxcodeLabel.text = self.boxcode;
    
    CGetWinsafeProductInfoParams *params = [CGetWinsafeProductInfoParams new];
    params.boxcode = self.boxcode;
    params.stocking = YES;
    
    [CGetWinsafeProductInfoModel requestWithParams:params completion:^(CGetWinsafeProductInfoModel *model, JSONModelError *err) {
        if (model) {
            self.nameLabel.text = model.data[@"proname"];
            self.proidLabel.text = model.data[@"proid"];
            self.prospecialLabel.text = model.data[@"prospecial"];
        }
    }];
}

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)continueScan:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    if ([self.delegate respondsToSelector:@selector(continueScan)]) {
        [self.delegate continueScan];
    }
}

@end
