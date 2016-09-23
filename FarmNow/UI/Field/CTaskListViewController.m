//
//  CTaskListViewController.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/24.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CTaskListViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface CTaskListViewController ()

@end

@implementation CTaskListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 280;
    
    self.title = self.taskSpec.taskSpecName;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.dataArray = self.taskSpec.steps;
        [self endRequestData];
    });
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    CTaskStep *step = self.dataArray[indexPath.row];
    
    UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:1];
    UILabel *stepNameLabel = (UILabel *)[cell.contentView viewWithTag:2];
    UILabel *stepDescriptionLabel = (UILabel *)[cell.contentView viewWithTag:3];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:step.picture]];
    stepNameLabel.text = step.stepName;
    stepDescriptionLabel.text = step.desc;
    
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    return cell;
}
@end
