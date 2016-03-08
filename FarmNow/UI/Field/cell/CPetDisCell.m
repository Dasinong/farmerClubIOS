//
//  CPetDisCell.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/24.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CPetDisCell.h"

@interface CPetDisCell ()
@property (weak, nonatomic) IBOutlet UILabel *petDisNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *petDisDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *indicator;
@property (weak, nonatomic) CPetDisSpec *petDisSpec;
@end

@implementation CPetDisCell

- (void)awakeFromNib {
    // Initialization code
    self.indicator.layer.cornerRadius = 6;
    self.indicator.layer.masksToBounds = YES;
}

- (void)setupWithModel:(id)model {
    CPetDisSpec *petDis = (CPetDisSpec *)model;
    self.petDisSpec = petDis;
    
    self.petDisNameLabel.text = petDis.petDisSpecName;
    self.petDisDescriptionLabel.text = petDis.sympton;
}

- (IBAction)petDisClicked:(id)sender {
    if ([self.delegate respondsToSelector:@selector(petSolutionClicked:)]) {
        [self.delegate petSolutionClicked:self.petDisSpec];
    }
}
@end
