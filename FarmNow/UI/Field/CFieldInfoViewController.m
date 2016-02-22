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

@interface CFieldInfoViewController()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollContentWidth;

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;

@end

@implementation CFieldInfoViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollContentWidth.constant = SCREEN_WIDTH - 40;
    self.topConstraint.constant = (SCREEN_HEIGHT - 230 - 64) / 2;
}

- (IBAction)commit:(id)sender {
    CCropStageSelectionViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CCropStageSelectionViewController"];
    [self.navigationController pushViewController:controller animated:YES];
}
@end
