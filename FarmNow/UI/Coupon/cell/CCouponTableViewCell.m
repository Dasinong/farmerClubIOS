//
//  CCouponTableViewCell.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/14.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CCouponTableViewCell.h"

@interface CCouponTableViewCell ()
@property (nonatomic,strong) CCoupon *coupon;
@end

@implementation CCouponTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setupWithModel:(id)model {
    self.coupon = model;
}

- (IBAction)claim:(id)sender {
    if (self.coupon && [self.delegate respondsToSelector:@selector(claim:)]) {
        [self.delegate claim:self.coupon];
    }
}
@end
