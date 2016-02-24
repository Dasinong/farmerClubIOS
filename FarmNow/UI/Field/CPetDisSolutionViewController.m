//
//  CPetDisSolutionViewController.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/24.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CPetDisSolutionViewController.h"

@interface CPetDisSolutionViewController ()
@property (weak, nonatomic) IBOutlet UILabel *solutionNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *solutionTextView;

@end

@implementation CPetDisSolutionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.solutionNameLabel.text = self.solutionName;
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
