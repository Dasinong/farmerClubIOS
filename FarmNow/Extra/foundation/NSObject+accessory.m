//
// NSObject+AssociatedObject.m
// AutoLayoutVsScrollView
//
// Created by pre-team on 14-5-6.
// Copyright (c) 2014年 pre-team. All rights reserved.
//

#import "NSObject+accessory.h"
#import <objc/runtime.h>

@implementation NSObject (AssociatedObject)

- (void)setAccessory:(id)object
{
    objc_setAssociatedObject(self, @selector(accessory), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    [self accessoryChanged:object];
}

- (id)accessory
{
    return objc_getAssociatedObject( self, @selector(accessory) );
}

- (void)accessoryChanged:(id)newValue
{
}

- (void)addAccessoryObserver
{
    [self addObserver:self forKeyPath:@"accessory" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

- (void)removeAccessoryObserver
{
    [self removeObserver:self forKeyPath:@"accessory"];
}

@end
