//
//  NSSingletonObject.m
//  KuowoBeam
//
//  Created by liangzhe on 周三 2013-11-20.
//  Copyright (c) 2013年 liangzhe. All rights reserved.
//

#import "NSObject+Extra_Singleton.h"

NSMutableDictionary* ObjectTable()
{
    static dispatch_once_t once;
    static id shared = nil;

    dispatch_once(&once, ^{
            shared = [NSMutableDictionary dictionary];
        });

    return shared;
}

#define OBJ_TABLE ObjectTable()
@implementation NSObject (Extra_Singleton)

+ (instancetype)shared_
{
    NSString *key = NSStringFromClass([self class]);
    id instance   = [OBJ_TABLE valueForKey:key];

    if (!instance)
    {
        instance = [[self alloc] init];
        [OBJ_TABLE setValue:instance forKey:key];
    }

    return instance;
} /* shared_ */

+ (instancetype)default_
{
    return [[[self class] alloc] init];
}

+ (instancetype)any
{
    return [[[self class] alloc] init];
}

@end
