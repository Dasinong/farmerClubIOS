//
//  UIDevice+Extra.h
//  VNews
//
//  Created by liangzhe on 周二 2013-12-31.
//  Copyright (c) 2013年 liangzhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Extra)
+ (CGFloat)statusBarHeight;

+ (BOOL)iOSDevice;

+ (BOOL)iOS7Above;
+ (BOOL)iOS7Below;
+ (BOOL)iOS6Above;

/**
 *  检测设备是否是640x1136的4英寸设备
 *
 *  @return yes|no
 */
+ (BOOL)isNewDevice;
@end
