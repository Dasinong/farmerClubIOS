//
//  CTaskCell.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/24.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CTaskCell.h"
#import "CTaskSpec.h"
#import "CTaskStep.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface CTaskCell ()
@property (weak, nonatomic) IBOutlet UIImageView *taskImageView;
@property (weak, nonatomic) IBOutlet UILabel *taskNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *taskDescriptionLabel;

@end

@implementation CTaskCell
- (void)setupWithModel:(id)model {
    CTaskSpec *taskSpec = (CTaskSpec *)model;
    CTaskStep *taskStep = taskSpec.steps[0];
    
    [self.taskImageView sd_setImageWithURL:[NSURL URLWithString:taskStep.thumbnailPicture]];
    self.taskNameLabel.text = taskStep.stepName;
    self.taskDescriptionLabel.text = taskStep.desc;
}
@end
