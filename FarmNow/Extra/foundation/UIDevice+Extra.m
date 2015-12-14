//
// UIDevice+Extra.m
// VNews
//
// Created by liangzhe on 周二 2013-12-31.
// Copyright (c) 2013年 liangzhe. All rights reserved.
//

#import "UIDevice+Extra.h"

@implementation UIDevice (Extra)
+ (BOOL)iOS7Higher
{
    return NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1;
}

+ (BOOL)iOS7Lower
{
    return NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_6_1;
}

+ (BOOL)iOS6Above
{
    return NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_6_0;

    // return [[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0;
}

+ (BOOL)iOS7Above
{
    return [[self class] iOS7Higher];
    // return [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0;
}

+ (BOOL)iOS7Below
{
    return [[self class] iOS7Lower];
    // return [[[UIDevice currentDevice] systemVersion] floatValue] < 7.0;
}

+ (CGFloat)statusBarHeight
{
    if ([[self class] iOS7Above])
    {
        return 20;
    }

    return 0;
}

+ (BOOL)iOSDevice
{
    return [[UIDevice currentDevice].systemName hasPrefix:@"iOS"];
}

+ (BOOL)isNewDevice
{
    static dispatch_once_t    predicate;
    static bool               result = NO;

    dispatch_once(&predicate, ^{
        if ([UIScreen instancesRespondToSelector:@selector(currentMode)])
        {
            CGSize size = [[UIScreen mainScreen] currentMode].size;
            result = CGSizeEqualToSize(CGSizeMake(640, 1136), size);
        }
    });

    return result;
} /* isNewDevice */

@end
