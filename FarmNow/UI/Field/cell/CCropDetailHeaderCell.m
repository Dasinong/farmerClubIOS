//
//  CCropDetailHeaderCell.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/23.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CCropDetailHeaderCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

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

- (void)setupWithModel:(CField *)field {
    [self.cropImageView sd_setImageWithURL:[NSURL URLWithString:field.crop.iconUrl]];
    if (field == nil) {
        self.cropNameLabel.text = @"";
        self.areaLabel.text = @"";
    }
    else {
        self.cropNameLabel.text = field.crop.cropName;
        self.areaLabel.text = [NSString stringWithFormat:@"%.1f亩", (double)field.area];
    }
}
@end
