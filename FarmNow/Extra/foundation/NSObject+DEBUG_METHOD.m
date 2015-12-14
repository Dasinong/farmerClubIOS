//
// NSObject+DEBUG_METHOD.m
// HomeService
//
// Created by pre-team on 14-5-15.
// Copyright (c) 2014年 pre-team. All rights reserved.
//

#import "NSObject+DEBUG_METHOD.h"
#import <objc/runtime.h>

@implementation NSObject (DEBUG_METHOD)

/**
 *    用新的方法取代原有方法
 *
 *    @param originSEL 需要被取代的selector
 *    @param newSEL    用来取代的selector
 *    @param backupSEL 用来保存原有方法的实现的selector
 *    @comment
 *      用newSetText:取代ULabel的setText方法, 并在newSetText:中调用setText原来的实现,已达到调试的目的
 *      @implementation UILabel (DEBUG_)
 *
 *      + (void)load
 *      {
 *          static dispatch_once_t onceToken;
 *
 *          dispatch_once(&onceToken, ^{
 *              [self replaceOrginSEL:@selector(setText:)
 *                         withNewSEL:@selector(newSetText:)
 *                        backupToSEL:@selector(backingSetText:)];
 *          });
 *      }
 *
 *      - (void)backingSetText:(NSString *)text
 *      {
 *          NSLog(@"you will never see me <%@>", NSStringFromSelector(_cmd));
 *      }
 *
 *      - (void)newSetText:(NSString *)text
 *      {
 *          // addition code here
 *
 *          // 调用原始方法
 *          [self backingSetText:text];
 *      }
 *
 *      @end
 */

#if 1 // DEBUG == 1
    + (void)replaceOrginSEL:(SEL)originSEL
                 withNewSEL:(SEL)newSEL
                backupToSEL:(SEL)backupSEL
    {
        Class    class             = [self class];

        // 备份原始方法

        Method        originMethod = class_getInstanceMethod(class, originSEL);
        IMP           originIMP    = method_getImplementation(originMethod);
        const char   *types        = method_getTypeEncoding(originMethod);

        class_replaceMethod(class, backupSEL, originIMP, types);

        // 替换 setText的实现
        Method    newMethod = class_getInstanceMethod(class, newSEL);
        IMP       newIMP    = method_getImplementation(newMethod);
        class_replaceMethod(class, originSEL, newIMP, types);
    } /* replaceOrginSEL */

#else /* if 1 */
    + (void)replaceOrginSEL:(SEL)originSEL
                 withNewSEL:(SEL)newSEL
                backupToSEL:(SEL)backupSEL
    {
        NSLog(@"you should not use this method in you release version");
    }

#endif  /* if DEBUG == 1 */
@end
