//
//  CCouponTableViewCell.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/14.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCoupon.h"

@protocol CCouponTableViewCellDelegate <NSObject>
- (void)claim:(CCoupon*)coupon;
@end

@interface CCouponTableViewCell : UITableViewCell
@property (nonatomic, weak) id<CCouponTableViewCellDelegate> delegate;

- (void)setupWithModel:(id)model;
@end
