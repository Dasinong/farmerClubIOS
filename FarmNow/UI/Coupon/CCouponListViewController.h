//
//  CCouponListViewController.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/17.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLPagerTabStripViewController.h"

typedef NS_ENUM(NSInteger, CouponType) {
    CouponTypeMyUnused,
    CouponTypeMyExpired,
    CouponTypeStore
};

@interface CCouponListViewController : UIViewController<XLPagerTabStripChildItem>
@property (nonatomic) CouponType type;
@end
