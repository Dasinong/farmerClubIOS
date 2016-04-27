//
//  CPetDisSolutionViewController.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/24.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CPetDisSolutionViewController.h"
#import "CGetPetSoluModel.h"

@interface CPetDisSolutionViewController ()
@property (weak, nonatomic) IBOutlet UILabel *solutionNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *solutionTextView;

@end

@implementation CPetDisSolutionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.solution.isRemedy == 0) {
        self.solutionNameLabel.text = [NSString stringWithFormat:@"预防方案%c", 'A' + (int)self.solutionIndex];
        self.title = @"预防方案详情";
    }
    else {
        self.solutionNameLabel.text = [NSString stringWithFormat:@"治疗方案%c", 'A' + (int)self.solutionIndex];
        self.title = @"治疗方案详情";
    }
    
    //solution
    self.solutionTextView.text = self.solution.petSoluDes;
    self.solutionTextView.font = [UIFont systemFontOfSize:15.0f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
