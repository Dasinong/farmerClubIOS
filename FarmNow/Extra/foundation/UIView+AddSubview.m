//
//  UIView+AddSubview.m
//  SnapCoverFlow
//
//  Created by liangzhe on 13-10-3.
//  Copyright (c) 2013年 wangchao. All rights reserved.
//

#import "UIView+AddSubview.h"
#import "UIColor+Extra.h"
#import "NSLog+Extra.h"
#import "CGGeometry+Extra.h"

@implementation UILabel (Creater)
+ (id)labelWithFontSize:(int)fontSize
          numberOfLines:(int)numberOfLines
         textColorValue:(NSUInteger)hexValue
{
    return [self labelWithFontSize:fontSize
                     numberOfLines:numberOfLines
                         textColor:[UIColor colorWithHex:hexValue]];
}

+ (id)labelWithFontSize:(int)fontSize
          numberOfLines:(int)numberOfLines
              textColor:(UIColor *)textColor
{
    UILabel *label = [[[self class] alloc] init];

    label.font            = [UIFont systemFontOfSize:fontSize];
    label.numberOfLines   = numberOfLines;
    label.textColor       = textColor;
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment   = NSTextAlignmentCenter;
    return label;
}

- (void)leftAlignText
{
    self.textAlignment = NSTextAlignmentLeft;
}

- (void)rightAlignText
{
    self.textAlignment = NSTextAlignmentRight;
}

- (void)centerAlignText
{
    self.textAlignment = NSTextAlignmentCenter;
}

@end

@implementation UIView (WCFView_)

+ (id)view
{
    return [[[self class] alloc] initWithFrame:CGRectZero];
}

- (UITapGestureRecognizer *)addTapGestureWithTarget:(id)target action:(SEL)action
{
    if (!action)
    {
        return nil;
    }

    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:gesture];

    return gesture;
}

- (id)addViewWithClass:(Class)className tapAction:(SEL)selector
{
    UIView *view = [[className alloc] init];

    [self addSubview:view];

    [view addTapGestureWithTarget:self action:selector];

    return view;
}

@end

@implementation UIView (Auto)

- (void)dump
{
    Info(@"%@", self);

    for (UIView *subView in self.subviews)
    {
        NSLogIndent();
        [subView dump];
        NSLogUnIndent();
    }

    //Info(@"%@ end", self);
}

- (void)addFillSubview:(UIView *)view
{
    view.frame            = self.bounds;
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:view];
}

- (void)addBottomAlignSubview:(UIView *)view height:(CGFloat)height
{
    view.frame            = CGRectBottomAlign(CGRectBySetHeight(self.frame, height), self.frame);
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self addSubview:view];
}

- (void)addSubview:(UIView *)view withResizingMask:(UIViewAutoresizing)mask
{
    view.autoresizingMask = mask;
    [self addSubview:view];
}

- (void)dockToLeft
{
    self.autoresizingMask |= UIViewAutoresizingFlexibleRightMargin;
}

- (void)dockToTop
{
    self.autoresizingMask |= UIViewAutoresizingFlexibleBottomMargin;
}

- (void)dockToRight
{
    self.autoresizingMask |= UIViewAutoresizingFlexibleLeftMargin;
}

- (void)dockToBottom
{
    self.autoresizingMask |= UIViewAutoresizingFlexibleTopMargin;
}

- (void)fillWidth
{
    self.autoresizingMask |= UIViewAutoresizingFlexibleWidth;
}

- (void)fillHeight
{
    self.autoresizingMask |= UIViewAutoresizingFlexibleHeight;
}

@end

@implementation UIGestureRecognizer (Extra)

- (id)ancestorForClass:(Class)classType
{
    if ([self.view isKindOfClass:classType])
    {
        return self.view;
    }

    return [self.view ancestorForClass:classType];
}

@end

@implementation UIView (Extra_Visable)
- (BOOL)visiable
{
    return !self.hidden;
}

- (id)ancestorForClass:(Class)classType
{
    id supper = [self superview];

    while (supper)
    {
        if ([supper isKindOfClass:classType])
        {
            return supper;
        }

        supper = [supper superview];
    }

    return nil;
}

@end
