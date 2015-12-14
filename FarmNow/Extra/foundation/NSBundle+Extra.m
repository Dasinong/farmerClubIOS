//
//  NSBundle+Xib.m
//  BuildeTower
//
//  Created by liangzhe on 13-6-27.
//  Copyright (c) 2013年 liangzhe. All rights reserved.
//

#import "NSBundle+Extra.h"
#import "NSLog+Extra.h"

@implementation NSBundle (Xib)

+ (id)objectForClass:(Class)className inNib:(NSString*)xib owner:(id)owner
{
    NSArray *object = [[NSBundle mainBundle] loadNibNamed:xib owner:owner options:nil];

    for (UIView*view in object)
    {
        if ([view isKindOfClass:className])
        {
            return view;
        }
    }

    return nil;
} /* objectForClass */

+ (NSString*)applicationSettingForKey:(NSString*)key
{
    NSString *value = [[[NSBundle mainBundle] infoDictionary] valueForKey:key];

    if ( !value || (value.length == 0) )
    {
        Warning(@"<%@> not exist in info.plist", key);
    }

    return value;
}

+ (NSString*)version
{
    return [[self class] applicationSettingForKey:(NSString*)kCFBundleVersionKey];
}

+ (NSString*)testFlightAppToken
{
    return [[self class] applicationSettingForKey:kTestFlightAppToken];
}

+ (NSString*)baiduMapAppToken
{
    return [[self class] applicationSettingForKey:kBaiduMapAppToken];
}

+ (NSString*)UMengAppToken
{
    return [[self class] applicationSettingForKey:kUMengAppToken];
}

+ (NSString*)WechatAppToken
{
    return [[self class] applicationSettingForKey:kWechatAppToken];
}

+ (NSURL*)urlForResource:(NSString*)resource
{
    NSString *path = [[self class] pathForResource:resource];

    if (!path)
    {
        return nil;
    }

    NSURL *url = [NSURL fileURLWithPath:path];

    if (!url)
    {
        Warning(@"url for %@ is nil", resource);
    }

    return url;
} /* urlForResource */

+ (NSString*)pathForResource:(NSString*)resource
{
    NSString *fullPath = [[NSBundle mainBundle] pathForResource:resource ofType:nil];

    if (!fullPath)
    {
        Warning(@"%@ not exist", resource);
    }

    return fullPath;
}

@end
