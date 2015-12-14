//
//  Defines.m
//
//  Created by liangzhe on 13-6-1.
//  Copyright (c) 2013年 liangzhe. All rights reserved.
//

#import "Defines.h"
#import "NSLog+Extra.h"

BOOL isIPhone5Device()
{
    static BOOL gIPhon5DeviceChecked = NO;
    static BOOL gIPhon5Device = NO;

    if (!gIPhon5DeviceChecked)
    {
        gIPhon5DeviceChecked = YES;
        Info(@"screen size:%@", NSStringFromCGSize([[UIScreen mainScreen] currentMode].size));
        gIPhon5Device = ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO);
    }

    return gIPhon5Device;
}
nc_define_notification(SessionExpired, @"SessionExpired");
nc_define_notification(ChangeLocation, @"ChangeLocation");
