//
// CGGeometry+Extra.m
// SnapCoverFlow
//
// Created by liangzhe on 13-9-14.
// Copyright (c) 2013年 liangzhe. All rights reserved.
//

#import "CGGeometry+Extra.h"
#import "Defines.h"

#import "NSLog+Extra.h"
#import "NSString+Extra.h"
#import "NSArray+Extra.h"


CGRect CGRectInsetWithInsets( CGRect rect, CGFloat left, CGFloat top, CGFloat right, CGFloat bottom)
{
    rect.origin.x    += left;
    rect.origin.y    += top;

    rect.size.width  -= left + right;
    rect.size.height -= top + bottom;

    return rect;
}

CGRect CGRectCenterWithSize( CGRect rect, CGSize size )
{
    rect.origin.x   += (rect.size.width - size.width) / 2;
    rect.origin.y   += (rect.size.height - size.height) / 2;
    rect.size.width  = size.width;
    rect.size.height = size.height;

    return rect;
}

CGPoint CGRectGetCenterPoint( CGRect rect )
{
    return CGPointMake( CGRectGetMidX(rect), CGRectGetMidY(rect) );
}

CGRect CGRectMakeWithCenterPointAndSize( CGPoint cPoint, CGSize size )
{
    return CGRectMake(cPoint.x - size.width / 2, cPoint.y - size.height / 2, size.width, size.height);
}

CGRect CGRectMakeWithRectCenterPointAndSize( CGRect rect, CGSize size )
{
    return CGRectMake(CGRectGetMidX(rect) - size.width / 2, CGRectGetMidY(rect) - size.height / 2, size.width, size.height);
}

CGRect CGRectFrameToBounds( CGRect frame )
{
    frame.origin.x = 0;
    frame.origin.y = 0;

    return frame;
}

CGRect CGRectByAjustHeight( CGRect rect, CGFloat height )
{
    rect.size.height += height;

    return rect;
}

CGRect CGRectByAjustWidth( CGRect rect, CGFloat width )
{
    rect.size.width += width;

    return rect;
}

CGRect CGRectBySetHeight( CGRect rect, CGFloat newHeight )
{
    rect.size.height = newHeight;

    return rect;
}

CGRect CGRectBySetWidth( CGRect rect, CGFloat newWidth )
{
    rect.size.width = newWidth;

    return rect;
}

// 00
// 01
// 10
// 11

CGRect CGRectForCornerLT( CGRect rect, CGFloat width, CGFloat height )
{
    rect.size.width  = width;
    rect.size.height = height;

    return rect;
}

CGRect CGRectForCornerRT( CGRect rect, CGFloat width, CGFloat height )
{
    rect.origin.x    = CGRectGetMaxX(rect) - width;
    rect.size.width  = width;
    rect.size.height = height;

    return rect;
}

CGRect CGRectForCornerLB( CGRect rect, CGFloat width, CGFloat height )
{
    rect.origin.y    = CGRectGetMaxY(rect) - height;
    rect.size.width  = width;
    rect.size.height = height;

    return rect;
}

CGRect CGRectForCornerRB( CGRect rect, CGFloat width, CGFloat height )
{
    rect.origin.x    = CGRectGetMaxX(rect) - width;
    rect.origin.y    = CGRectGetMaxY(rect) - height;
    rect.size.width  = width;
    rect.size.height = height;

    return rect;
}

CGRect CGRectBottomAlign( CGRect rect, CGRect alignTo )
{
    rect.origin.y = CGRectGetMaxY(alignTo) - CGRectGetHeight(rect);

    return rect;
}

CGRect CGRectTopAlign( CGRect rect, CGRect alignTo )
{
    rect.origin.y = CGRectGetMinY(alignTo);

    return rect;
}

CGRect CGRectLeftAlign( CGRect rect, CGRect alignTo )
{
    rect.origin.x = CGRectGetMidX(alignTo);

    return rect;
}

CGRect CGRectRightAlign( CGRect rect, CGRect alignTo )
{
    rect.origin.x = CGRectGetMaxX(alignTo) - CGRectGetWidth(rect);

    return rect;
}

CGRect CGRectCenterInContainer( CGRect rect, CGRect container, BOOL horizontal, BOOL vertical )
{
    if (horizontal)
    {
        rect.origin.x = CGRectGetMidX(container) - CGRectGetWidth(rect) / 2;
    }

    if (vertical)
    {
        rect.origin.y = CGRectGetMidY(container) - CGRectGetHeight(rect) / 2;
    }

    return rect;
}     /* CGRectCenterInContainer */

CGSize CGSizeExpand( CGSize size, CGFloat xInset, CGFloat yInset )
{
    size.width  += xInset;
    size.height += yInset;

    return size;
}

#if 1
    const static struct _PMB    PMBZero = {0, 0, 0, 0};
    struct _PMB PMBMake( CGFloat left, CGFloat top, CGFloat right, CGFloat bottom )
    {
        struct _PMB    result = {left, top, right, bottom};

        return result;
    }

    NSString* PMBStringfy( struct _PMB pmb )
    {
        return str_fmt(@"%d, %d, %d, %d", (int)pmb.left, (int)pmb.top, (int)pmb.right, (int)pmb.bottom);
    }

    struct _PMB PMBParse( NSString *value )
    {
        if(!value)
        {
            return PMBZero;
        }

        NSArray   *values = [value split:@","];
        if(values.count == 1)
        {
            CGFloat    valueAll = [[values at:0] intValue];

            return PMBMake( valueAll, valueAll, valueAll, valueAll);
        }
        else if(values.count == 2)
        {
            CGFloat    valueHor = [[values at:0] intValue];
            CGFloat    valueVec = [[values at:1] intValue];

            return PMBMake( valueHor, valueVec, valueHor, valueVec);
        }
        else if(values.count == 4)
        {
            CGFloat    valueLeft   = [[values at:0] intValue];
            CGFloat    valueTop    = [[values at:1] intValue];
            CGFloat    valueRight  = [[values at:2] intValue];
            CGFloat    valueBottom = [[values at:3] intValue];

            return PMBMake( valueLeft, valueTop, valueRight, valueBottom);
        }
        else
        {
            return PMBZero;
            Error(@"unspport format:%@", value);
        }
    } /* PMBParse */

    BOOL isEmptyPMB(struct _PMB pmb)
    {
        return (pmb.left == 0 && pmb.top == 0 && pmb.right == 0 && pmb.bottom == 0);
    }

    CGFloat PMBWidth( struct _PMB pmb )
    {
        return (pmb.left + pmb.right);
    }

    CGFloat PMBHeight( struct _PMB pmb )
    {
        return (pmb.bottom + pmb.top);
    }

    CGRect CGRectByRemovePMB( CGRect rect, struct _PMB pmb )
    {
        rect.origin.x    += pmb.left;
        rect.origin.y    += pmb.top;
        rect.size.width  -= (pmb.left + pmb.right);
        rect.size.height -= (pmb.bottom + pmb.top);

        return rect;
    }

    CGPadding CGPaddingMake1( CGFloat width )
    {
        return PMBMake( width, width, width, width);
    }

    CGPadding CGPaddingMake2( CGFloat width, CGFloat height )
    {
        return PMBMake( width, height, width, height);
    }

    CGPadding CGPaddingMake( CGFloat left, CGFloat top, CGFloat right, CGFloat bottom )
    {
        return PMBMake( left, top, right, bottom);
    }

    CGMargin CGMarginMake1( CGFloat width )
    {
        return PMBMake( width, width, width, width);
    }

    CGMargin CGMarginMake2( CGFloat width, CGFloat height )
    {
        return PMBMake( width, height, width, height);
    }

    CGMargin CGMarginMake( CGFloat left, CGFloat top, CGFloat right, CGFloat bottom )
    {
        return PMBMake( left, top, right, bottom);
    }

    CGBorder CGBorderMake1( CGFloat width )
    {
        return PMBMake( width, width, width, width);
    }

    CGBorder CGBorderMake2( CGFloat width, CGFloat height )
    {
        return PMBMake( width, height, width, height);
    }

    CGBorder CGBorderMake3( CGFloat left, CGFloat top, CGFloat right, CGFloat bottom )
    {
        return PMBMake( left, top, right, bottom);
    }

#endif /* if 0 */
#if 0
    @implementation CGPointObject
    + (id)point:(CGPoint)value
    {
        return [[self class] pointWithX:value.x y:value.y];
    }

    + (id)pointWithX:(CGFloat)x y:(CGFloat)y
    {
        CGPointObject   *instance = [[self class] alloc];

        instance.x = x;
        instance.y = y;

        return instance;
    }

    - (BOOL)isEqual:(CGPointObject*)object
    {
        return CGPointEqualToPoint(self.value, object.value);
    }

    - (CGPoint)value
    {
        return POINT(self.x, self.y);
    }

    - (void)setValue:(CGPoint)value
    {
        self.x = value.x;
        self.y = value.y;
    }

    - (CGPointObject*)offset:(CGSize)size
    {
        self.x += size.width;
        self.y += size.height;

        return self;
    }

    @end

    @implementation CGSizeObject

    + (id)size:(CGSize)size
    {
        return [[self class] sizeWithWidth:size.width height:size.height];
    }

    + (id)sizeWithWidth:(CGFloat)width height:(CGFloat)height
    {
        CGSizeObject   *instance = [[self class] alloc];

        instance.width  = width;
        instance.height = height;

        return instance;
    }

    - (NSUInteger)hash
    {
        return ( (int)self.height << 16 ) | ( (int)self.width & 0xffff );
    }

    - (BOOL)isEqual:(CGSizeObject*)object
    {
        return CGSizeEqualToSize(self.value, object.value);
    }

    - (BOOL)empty
    {
        return self.width == 0 || self.height == 0;
    }

    - (CGSize)value
    {
        return SIZE(self.width, self.height);
    }

    - (void)setValue:(CGSize)value
    {
        self.width  = value.width;
        self.height = value.height;
    }

    - (CGSizeObject*)expand:(CGSize)size
    {
        self.width  += size.width;
        self.height += size.height;

        return self;
    }

    - (CGSizeObject*)shrink:(CGSize)size
    {
        self.width  -= size.width;
        self.height -= size.height;

        return self;
    }

    @end

    @implementation CGRectObject

    + (id)rect:(CGRect)rect
    {
        return [[self class] rectWithX:rect.origin.x
                                     y:rect.origin.y
                                 width:rect.size.width
                                height:rect.size.height];
    }

    + (id)rectWithOrigin:(CGPoint)origin size:(CGSize)size
    {
        return [[self class] rectWithX:origin.x
                                     y:origin.y
                                 width:size.width
                                height:size.height];
    }

    + (id)rectWithX:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height
    {
        CGRectObject   *instance = [[CGRectObject alloc] init];

        instance.x      = x;
        instance.y      = y;
        instance.width  = width;
        instance.height = height;

        return instance;
    }

    - (BOOL)empty
    {
        return self.width == 0 || self.height == 0;
    }

    - (NSUInteger)hash
    {
        return ( (int)self.height << 16 ) | ( (int)self.width & 0xffff );
    }

    - (CGRect)RECT
    {
        return RECT(self.x, self.y, self.width, self.height);
    }

    - (void)setRECT:(CGRect)value
    {
        self.x      = value.origin.x;
        self.y      = value.origin.y;
        self.width  = value.size.width;
        self.height = value.size.height;
    }

    - (CGSize)SIZE // DIMENSION
    {
        return SIZE(self.width, self.height);
    }

    - (void)setSIZE:(CGSize)SIZE
    {
        self.width  = SIZE.width;
        self.height = SIZE.height;
    }

    - (CGPoint)ORIGIN
    {
        return POINT(self.x, self.y);
    }

    - (void)setORIGIN:(CGPoint)ORIGIN
    {
        self.x = ORIGIN.x;
        self.y = ORIGIN.y;
    }

    - (CGRectObject*)expand:(CGSize)size
    {
        // self.RECT = CGRectInset(self.RECT, size.width, size.height);
        self.x      -= size.width;
        self.y      -= size.height;
        self.width  += size.width + size.width;
        self.height += size.height + size.height;

        return self;
    }

    - (CGRectObject*)shrink:(CGSize)size
    {
        // self.RECT = CGRectInset(self.RECT, -size.width, -size.height);
        self.x      += size.width;
        self.y      += size.height;
        self.width  -= size.width + size.width;
        self.height -= size.height + size.height;

        return self;
    }

    - (CGPointObject*)origin
    {
        return [CGPointObject pointWithX:self.x y:self.y];
    }

    - (void)setOrigin:(CGPointObject*)origin
    {
        self.x = origin.x;
        self.y = origin.y;
    }

    - (CGSizeObject*)size
    {
        return [CGSizeObject sizeWithWidth:self.width height:self.height];
    }

    - (void)setSize:(CGSizeObject*)size
    {
        self.width  = size.width;
        self.height = size.height;
    }

    - (CGPointObject*)center
    {
        return [CGPointObject pointWithX:self.x + self.width / 2 y:self.y + self.height / 2];
    }

    - (void)setCenter:(CGPointObject*)center
    {
        self.x = center.x - self.width / 2;
        self.y = center.y - self.height / 2;
    }

    - (CGPointObject*)leftTop
    {
        return [CGPointObject pointWithX:self.x y:self.y];
    }

    - (void)setLeftTop:(CGPointObject*)leftTop
    {
        self.x = leftTop.x;
        self.y = leftTop.y;
    }

    - (CGPointObject*)rightTop
    {
        return [CGPointObject pointWithX:self.x + self.width y:self.y];
    }

    - (void)setRightTop:(CGPointObject*)rightTop
    {
        self.x = rightTop.x - self.width;
        self.y = rightTop.y;
    }

    - (CGPointObject*)leftBottom
    {
        return [CGPointObject pointWithX:self.x y:self.y + self.height];
    }

    - (void)setLeftBottom:(CGPointObject*)rightTop
    {
        self.x = rightTop.x;
        self.y = rightTop.y - self.height;
    }

    - (CGPointObject*)rightBottom
    {
        return [CGPointObject pointWithX:self.x + self.width y:self.y + self.height];
    }

    - (void)setRightBottom:(CGPointObject*)rightBottom
    {
        self.x = rightBottom.x - self.width;
        self.y = rightBottom.y - self.height;
    }

    - (BOOL)isEqual:(CGRectObject*)object
    {
        return CGRectEqualToRect(self.RECT, object.RECT);
    }

    @end
#endif /* if 0 */
