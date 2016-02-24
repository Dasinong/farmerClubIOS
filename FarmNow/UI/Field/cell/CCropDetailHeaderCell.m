//
//  CCropDetailHeaderCell.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/23.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CCropDetailHeaderCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "CField.h"
#import "CCropDetail.h"
#import "CSubStage.h"

@interface CCropDetailHeaderCell()
@property (weak, nonatomic) IBOutlet UIImageView *cropImageView;
@property (weak, nonatomic) IBOutlet UILabel *cropNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UIButton *stageButton;

@end

@implementation CCropDetailHeaderCell
- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.stageButton.layer.cornerRadius = 20.0f;
}

- (void)setupWithModel:(id)model {
    if ([model isKindOfClass:[CField class]]) {
        CField *field = (CField*)model;
        [self.cropImageView sd_setImageWithURL:[NSURL URLWithString:field.crop.iconUrl]];
        self.cropNameLabel.text = field.crop.cropName;
        self.areaLabel.text = [NSString stringWithFormat:@"%.1f亩", (double)field.area];
        CSubStage *subStage = field.stagelist[field.currentStageId];
        [self.stageButton setTitle:[NSString stringWithFormat:@"%@ >",subStage.subStageName] forState:UIControlStateNormal];
    }
    else if ([model isKindOfClass:[CCropDetail class]]){
        CCropDetail *cropDetail = (CCropDetail *)model;
        [self.cropImageView sd_setImageWithURL:[NSURL URLWithString:cropDetail.crop.iconUrl]];
        self.cropNameLabel.text = cropDetail.crop.cropName;
        self.areaLabel.text = @"";
        
        CSubStage *subStage = cropDetail.substagews[cropDetail.subStageId];
        [self.stageButton setTitle:[NSString stringWithFormat:@"%@ >",subStage.subStageName] forState:UIControlStateNormal];
        
    }
    else {
        self.cropNameLabel.text = @"";
        self.areaLabel.text = @"";
        [self.stageButton setTitle:@"" forState:UIControlStateNormal];
    }
}
@end
