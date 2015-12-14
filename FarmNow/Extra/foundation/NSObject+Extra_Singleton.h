//
//  NSSingletonObject.h
//  KuowoBeam
//
//  Created by liangzhe on 周三 2013-11-20.
//  Copyright (c) 2013年 liangzhe. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DEFINE_SHAERD_METHOD()                        \
    + (instancetype)shared                            \
    {                                                 \
        static dispatch_once_t once;                  \
        static id shared = nil;                       \
        dispatch_once(&once, ^{                       \
                shared = [[[self class] alloc] init]; \
            });                                       \
        return shared;                                \
    }

@interface NSObject (Extra_Singleton)

/**
 *    避免和系统的shared方法冲突
 *
 *    @return 单实例对象
 */
+ (instancetype)shared_;

+ (instancetype)default_;
+ (instancetype)any;
@end
