//
//  CUtil.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/3/8.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CStockViewController.h"

@interface CUtil : NSObject
+ (void)processQR:(NSString *)result inVC:(UIViewController<CStockViewControllerDelegate> *)viewController;
@end
