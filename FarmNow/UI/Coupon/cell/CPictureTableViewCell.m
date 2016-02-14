//
//  CPictureTableViewCell.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/14.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CPictureTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface CPictureTableViewCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeightConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@end

@implementation CPictureTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupWithImage:(UIImage*)image {
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    
    CGFloat trueHeight = SCREEN_WIDTH / width * height;
    
    self.imageHeightConstraint.constant = trueHeight;
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
    [self.pictureView setImage:image];
}

@end
