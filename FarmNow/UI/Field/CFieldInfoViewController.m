//
//  CFieldInfoViewController.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/22.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CFieldInfoViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "CCropStageSelectionViewController.h"
#import "CSearchNearUserModel.h"

@interface CFieldInfoViewController()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollContentWidth;

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

@end

@implementation CFieldInfoViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollContentWidth.constant = SCREEN_WIDTH - 40;
    self.topConstraint.constant = (SCREEN_HEIGHT - 230 - 64 - 60) / 2;
    
    self.infoLabel.text = @"";
    [self searchNearUser];
}

- (void)searchNearUser {
    // 啊呀，你附近有414个用户
    // 也在使用我们服务哦
    CSearchNearUserParam *param = [CSearchNearUserParam new];
    [CSearchNearUserModel requestWithParams:param completion:^(CSearchNearUserModel *model, JSONModelError *err) {
        if (model && model.data > 0) {
            self.infoLabel.text = [NSString stringWithFormat:@"啊呀，你附近有%d个用户\n也在使用我们服务哦", (int)model.data];
        }
    }];
}

- (IBAction)commit:(id)sender {
    NSInteger area = [self.inputTextField.text integerValue];
    if (area > 0) {
        [CCropStageSelectionViewController shared_].area = area;
        CCropStageSelectionViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CCropStageSelectionViewController"];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else {
        [MBProgressHUD alert:@"请输入亩数"];
    }
}
@end
