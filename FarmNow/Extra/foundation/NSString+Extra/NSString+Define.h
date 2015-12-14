//
//  NSString+Define.h
//  Tourist
//
//  Created by liangzhe on 周三 2014-02-26.
//  Copyright (c) 2014年 liangzhe. All rights reserved.
//

#import <Foundation/Foundation.h>

#define RECT_Str(rect)              NSStringFromCGRect(rect)
#define RECT_S(rect)                CGRectFromString( rect )

#define POINT_Str(point)            NSStringFromCGPoint(point)
#define POINT_S(point)              CGPointFromString( point )

#define SIZE_Str(size)              NSStringFromCGSize(size)
#define SIZE_S(size)                GSizeFromString(size)

#define CGAffine_Str(transform)     NSStringFromCGAffineTransform(transform)
#define CGAffine_S(transform)       CGAffineTransformFromString(transform)

#define OFFSET_Str(offset)          NSStringFromUIOffset(offset)
#define OFFSET_S(offset)            UIOffsetFromString(offset)

#define INSETS_Str(insets)          NSStringFromUIEdgeInsets(insets)
#define INSETS_S(insets)            UIEdgeInsetsFromString(insets)

#define SELECTOR_Str( selector )    NSStringFromSelector(selector)
#define SELECTOR_S ( selector )     NSSelectorFromString( selector )

#define CLASS_Str(class)            NSStringFromClass(class)
#define CLASS(class)                NSClassFromString(class)

#define PROTOCOL_Str( protocol )    NSStringFromProtocol(protocol)
#define PROTOCOL( protocol )        NSProtocolFromString(protocol)