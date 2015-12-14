//
// NSObject+AssociatedObject.h
// AutoLayoutVsScrollView
//
// Created by pre-team on 14-5-6.
// Copyright (c) 2014年 pre-team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (AssociatedObject)
@property (nonatomic, strong) id    accessory;

- (void)addAccessoryObserver;
- (void)removeAccessoryObserver;
@end
