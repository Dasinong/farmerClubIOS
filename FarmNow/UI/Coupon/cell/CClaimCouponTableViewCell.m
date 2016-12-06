//
//  CClaimCouponTableViewCell.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/15.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CClaimCouponTableViewCell.h"

@interface CClaimCouponTableViewCell ()

@end

@implementation CClaimCouponTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    
}

- (IBAction)editingDidEnd:(id)sender {
    if ([self.delegate respondsToSelector:@selector(textFieldEndEditing:)]) {
        [self.delegate textFieldEndEditing:sender];
    }
}

@end
