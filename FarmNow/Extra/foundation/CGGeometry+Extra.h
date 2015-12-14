//
// CGGeometry+Extra.h
// SnapCoverFlow
//
// Created by liangzhe on 13-9-14.
// Copyright (c) 2013年 liangzhe. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "CGRect+Extra.h"

CGRect CGRectInsetWithInsets(CGRect rect,
                             CGFloat left, CGFloat top,
                             CGFloat right, CGFloat bottom);

CGRect CGRectCenterWithSize(CGRect rect, CGSize size);

CGPoint CGRectGetCenterPoint(CGRect rect);

CGRect CGRectMakeWithCenterPointAndSize(CGPoint cPoint, CGSize size);

CGRect CGRectMakeWithRectCenterPointAndSize(CGRect rect, CGSize size);

// just set origin to (0,0)
CGRect CGRectFrameToBounds(CGRect frame);

CGRect CGRectByAjustHeight(CGRect rect, CGFloat height);

CGRect CGRectByAjustWidth(CGRect rect, CGFloat width);

CGRect CGRectBySetHeight(CGRect rect, CGFloat newHeight);

CGRect CGRectBySetWidth(CGRect rect, CGFloat newWidth);

// 生成顶点对齐的矩形
CGRect CGRectForCornerLT(CGRect rect, CGFloat width, CGFloat height);

CGRect CGRectForCornerRT(CGRect rect, CGFloat width, CGFloat height);

CGRect CGRectForCornerRB(CGRect rect, CGFloat width, CGFloat height);

CGRect CGRectForCornerLB(CGRect rect, CGFloat width, CGFloat height);

// 对齐两个矩形
CGRect CGRectLeftAlign(CGRect rect, CGRect alignTo);

CGRect CGRectRightAlign(CGRect rect, CGRect alignTo);

CGRect CGRectTopAlign(CGRect rect, CGRect alignTo);

CGRect CGRectBottomAlign(CGRect rect, CGRect alignTo);

CGSize CGSizeExpand(CGSize size, CGFloat xInset, CGFloat yInsert);

// 设置矩形位置
// _scroller.showsVerticalScrollIndicator = NO;
// _scroller.showsHorizontalScrollIndicator = NO;
CGRect CGRectCenterInContainer(CGRect rect, CGRect container, BOOL horizontal, BOOL vertical);

#if 1
typedef struct _PMB
{
    CGFloat    left, top, right, bottom;
} CGPadding, CGMargin, CGBorder;

CGRect CGRectByRemovePMB(CGRect rect, struct _PMB pmb);

struct _PMB PMBMake(CGFloat left, CGFloat top, CGFloat right, CGFloat bottom);

/*
 * 使用字符串的方式构建PMB对象
 * 格式:
 *    left, top, right, bottom  ==> 1,2,3,4  ==> {left:1, top:2, right:3, bottom:4}
 *    hor, vec                  ==> 1,2      ==> {left:1, top:2, right:1, bottom:2}
 *    all                       ==> 1        ==> {left:1, top:1, right:1, bottom:1}
 */
struct _PMB PMBParse(NSString *value);

NSString* PMBStringfy(struct _PMB pmb);

CGFloat PMBWidth(struct _PMB pmb);

CGFloat PMBHeight(struct _PMB pmb);

BOOL isEmptyPMB(struct _PMB pmb);

CGPadding CGPaddingMake1(CGFloat width);

CGPadding CGPaddingMake2(CGFloat width, CGFloat height);

CGPadding CGPaddingMake(CGFloat left, CGFloat top, CGFloat right, CGFloat bottom);

#define PADDING_FLEXIBLE_VALUE (-1)
#define PADDING(left, top, right, bottom) \
    CGPaddingMake(left, top, right, bottom)

#define PADDING1(width) \
    CGPaddingMake1(width)

#define PADDING2(width, height) \
    CGPaddingMake2(width, height)

CGMargin CGMarginMake1(CGFloat width);

CGMargin CGMarginMake2(CGFloat width, CGFloat height);

CGMargin CGMarginMake(CGFloat left, CGFloat top, CGFloat right, CGFloat bottom);

CGBorder CGBorderMake1(CGFloat width);

CGBorder CGBorderMake2(CGFloat width, CGFloat height);

CGBorder CGBorderMake(CGFloat left, CGFloat top, CGFloat right, CGFloat bottom);
#endif 
#if 0
    @interface CGPointObject : NSObject

    @property (nonatomic, assign) CGPoint    value;
    @property (nonatomic, assign) CGFloat    x;
    @property (nonatomic, assign) CGFloat    y;

    + (id)point:(CGPoint)value;
    + (id)pointWithX:(CGFloat)x y:(CGFloat)y;
    - (CGPointObject*)offset:(CGSize)size;
    @end

    @interface CGSizeObject : NSObject

    @property (nonatomic, assign) CGSize     value;
    @property (nonatomic, assign) CGFloat    width;
    @property (nonatomic, assign) CGFloat    height;

    @property (nonatomic, readonly) BOOL    empty;

    + (id)size:(CGSize)value;
    + (id)sizeWithWidth:(CGFloat)width height:(CGFloat)height;

    - (CGSizeObject*)expand:(CGSize)size;
    - (CGSizeObject*)shrink:(CGSize)size;
    @end

    @interface CGRectObject : NSObject
    @property (nonatomic, assign) CGRect    RECT;

    @property (nonatomic, assign) CGPoint    ORIGIN;
    @property (nonatomic, assign) CGSize     SIZE; // DIMENSION;

    @property (nonatomic, assign) CGFloat    x;
    @property (nonatomic, assign) CGFloat    y;
    @property (nonatomic, assign) CGFloat    width;
    @property (nonatomic, assign) CGFloat    height;

    @property (nonatomic, weak) CGPointObject   *origin, *center;
    @property (nonatomic, weak) CGSizeObject    *size;

    @property (nonatomic, weak) CGPointObject   *leftTop, *rightTop, *leftBottom, *rightBottom;

    @property (nonatomic, readonly) BOOL    empty;

    + (id)rect:(CGRect)rect;
    + (id)rectWithOrigin:(CGPoint)origin size:(CGSize)size;
    + (id)rectWithX:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height;

    - (CGRectObject*)expand:(CGSize)size;
    - (CGRectObject*)shrink:(CGSize)size;
    @end
#endif /* if 0 */

#define SIZE_Width(size)  size.width
#define SIZE_Height(size) size.height
