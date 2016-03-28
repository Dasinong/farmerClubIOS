//
//  CStockViewController.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/3/28.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CBaseViewController.h"

@protocol CStockViewControllerDelegate <NSObject>
- (void)continueScan;
@end

@interface CStockViewController : CBaseViewController
@property (nonatomic, weak) id<CStockViewControllerDelegate> delegate;
@property (nonatomic, strong) NSString *boxcode;
@end
