//
//  CPetSolutionCell.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/4/26.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CPetSolutionCell.h"
#import "CPetSolution.h"

@interface CPetSolutionCell ()
@property (weak, nonatomic) IBOutlet UILabel *solutionNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *providedByLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *snapshotCPLabel;
@property (weak, nonatomic) IBOutlet UILabel *subStageLabel;

@end

@implementation CPetSolutionCell
- (void)setupWithModel:(id)model index:(NSInteger)index {
    CPetSolution *solution = (CPetSolution*)model;
    
    if (solution.isRemedy == 0) {
        self.solutionNameLabel.text = [NSString stringWithFormat:@"预防方案%c", 'A' + (int)index];
    }
    else {
        self.solutionNameLabel.text = [NSString stringWithFormat:@"治疗方案%c", 'A' + (int)index];
    }
    
    self.descriptionLabel.text = solution.petSoluDes;
    
    self.providedByLabel.text = solution.providedBy;
    
    if ([solution.snapshotCP length] > 0) {
        self.snapshotCPLabel.text = [NSString stringWithFormat:@"相关药物：%@", solution.snapshotCP];
    }
    else {
        self.snapshotCPLabel.text = @"";
    }
    
    if([solution.subStageId length] > 0) {
        self.subStageLabel.text = [NSString stringWithFormat:@"  %@  ", solution.subStageId];
    }
    else {
        self.subStageLabel.text = @"";
    }
    
    self.subStageLabel.layer.cornerRadius = 3.0f;
    self.subStageLabel.layer.masksToBounds = YES;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
@end
