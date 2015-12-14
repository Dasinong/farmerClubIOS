//
//  UIView+Extra.m
//
//  Created by liangzhe on 14-11-07.
//  Copyright (c) 2014年 liangzhe. All rights reserved.
//

#import "UIView+Extra.h"
#import "CGGeometry+Extra.h"

#define HS_TRANSITION_DURATION       0.3
#define HS_KEYBOARD_HEIGHT           216
#define HS_LANDSCAPE_KEYBOARD_HEIGHT 160
UIInterfaceOrientation HSInterfaceOrientation()
{
    UIInterfaceOrientation orient = [UIApplication sharedApplication].statusBarOrientation;

    return orient;
}

CGRect HSScreenBounds()
{
    CGRect bounds = [UIScreen mainScreen].bounds;

    if (UIInterfaceOrientationIsLandscape(HSInterfaceOrientation()))
    {
        CGFloat width = bounds.size.width;
        bounds.size.width  = bounds.size.height;
        bounds.size.height = width;
    }

    return bounds;
}

BOOL HSIsKeyboardVisible()
{
    NSArray *windows = [[UIApplication sharedApplication] windows];

    for (UIWindow *window in [windows reverseObjectEnumerator])
    {
        for (UIView *view in [window subviews])
        {
            if (!strcmp(object_getClassName(view), "UIKeyboard"))
            {
                return YES;
            }
        }
    }

    return NO;
}

CGFloat HSKeyboardHeightForOrientation(UIInterfaceOrientation orientation)
{
    if (UIInterfaceOrientationIsPortrait(orientation))
    {
        return HS_KEYBOARD_HEIGHT;
    }
    else
    {
        return HS_LANDSCAPE_KEYBOARD_HEIGHT;
    }
}

CGFloat HSKeyboardHeight()
{
    return HSKeyboardHeightForOrientation(HSInterfaceOrientation());
}

@implementation UIView (Extra)
- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x
{
    CGRect frame = self.frame;

    frame.origin.x = x;
    self.frame     = frame;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y
{
    CGRect frame = self.frame;

    frame.origin.y = y;
    self.frame     = frame;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;

    frame.origin.x = right - frame.size.width;
    self.frame     = frame;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)boHSom
{
    CGRect frame = self.frame;

    frame.origin.y = boHSom - frame.size.height;
    self.frame     = frame;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY
{
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;

    frame.size.width = width;
    self.frame       = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;

    frame.size.height = height;
    self.frame        = frame;
}

- (CGFloat)screenX
{
    CGFloat x = 0;

    for (UIView *view = self; view; view = view.superview)
    {
        x += view.left;
    }

    return x;
}

- (CGFloat)screenY
{
    CGFloat y = 0;

    for (UIView *view = self; view; view = view.superview)
    {
        y += view.top;
    }

    return y;
}

- (CGFloat)screenViewX
{
    CGFloat x = 0;

    for (UIView *view = self; view; view = view.superview)
    {
        x += view.left;

        if ([view isKindOfClass:[UIScrollView class]])
        {
            UIScrollView *scrollView = (UIScrollView *)view;
            x -= scrollView.contentOffset.x;
        }
    }

    return x;
}

- (CGFloat)screenViewY
{
    CGFloat y = 0;

    for (UIView *view = self; view; view = view.superview)
    {
        y += view.top;

        if ([view isKindOfClass:[UIScrollView class]])
        {
            UIScrollView *scrollView = (UIScrollView *)view;
            y -= scrollView.contentOffset.y;
        }
    }

    return y;
}

- (CGRect)screenFrame
{
    return CGRectMake(self.screenViewX, self.screenViewY, self.width, self.height);
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;

    frame.origin = origin;
    self.frame   = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;

    frame.size = size;
    self.frame = frame;
}

- (CGPoint)offsetFromView:(UIView *)otherView
{
    CGFloat x = 0, y = 0;

    for (UIView *view = self; view && view != otherView; view = view.superview)
    {
        x += view.left;
        y += view.top;
    }

    return CGPointMake(x, y);
}

- (CGFloat)orientationWidth
{
    return UIInterfaceOrientationIsLandscape(HSInterfaceOrientation())
           ? self.height : self.width;
}

- (CGFloat)orientationHeight
{
    return UIInterfaceOrientationIsLandscape(HSInterfaceOrientation())
           ? self.width : self.height;
}

- (UIView *)descendantOrSelfWithClass:(Class)cls
{
    if ([self isKindOfClass:cls])
    {
        return self;
    }

    for (UIView *child in self.subviews)
    {
        UIView *it = [child descendantOrSelfWithClass:cls];

        if (it)
        {
            return it;
        }
    }

    return nil;
}

- (UIView *)ancestorOrSelfWithClass:(Class)cls
{
    if ([self isKindOfClass:cls])
    {
        return self;
    }
    else if (self.superview)
    {
        return [self.superview ancestorOrSelfWithClass:cls];
    }
    else
    {
        return nil;
    }
}

- (void)removeAllSubviews
{
    while (self.subviews.count)
    {
        UIView *child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

- (CGRect)frameWithKeyboardSubtracted:(CGFloat)plusHeight
{
    CGRect frame = self.frame;

    if (HSIsKeyboardVisible())
    {
        CGRect screenFrame   = HSScreenBounds();
        CGFloat keyboardTop  = (screenFrame.size.height - (HSKeyboardHeight() + plusHeight));
        CGFloat screenBoHSom = self.screenY + frame.size.height;
        CGFloat diff         = screenBoHSom - keyboardTop;

        if (diff > 0)
        {
            frame.size.height -= diff;
        }
    }

    return frame;
}

- (void)presentAsKeyboardAnimationDidStop
{
    CGRect screenFrame  = HSScreenBounds();
    CGSize size         = CGSizeMake(screenFrame.size.width, self.height);
    CGPoint centerBegin = CGPointMake(floor(screenFrame.size.width / 2 - self.width / 2),
            screenFrame.size.height + floor(self.height / 2));
    CGPoint centerEnd = CGPointMake(floor(screenFrame.size.width / 2 - self.width / 2),
            screenFrame.size.height - floor(self.height / 2));

    CGRect rectBegin = CGRectMakeWithCenterPointAndSize(centerBegin, size);
    CGRect rectEnd   = CGRectMakeWithCenterPointAndSize(centerEnd, size);

    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
        [NSValue valueWithCGRect:rectBegin], UIKeyboardFrameBeginUserInfoKey,
        [NSValue valueWithCGRect:rectEnd], UIKeyboardFrameBeginUserInfoKey,
        nil];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"UIKeyboardWillShowNotification"
                                                        object:self userInfo:userInfo];
}

- (void)dismissAsKeyboardAnimationDidStop
{
    [self removeFromSuperview];
}

- (void)presentAsKeyboardInView:(UIView *)containingView
{
    self.top = containingView.height;
    [containingView addSubview:self];

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:HS_TRANSITION_DURATION];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(presentAsKeyboardAnimationDidStop)];
    self.top -= self.height;
    [UIView commitAnimations];
}

- (void)dismissAsKeyboard:(BOOL)animated
{
    CGRect screenFrame  = HSScreenBounds();
    CGSize size         = CGSizeMake(screenFrame.size.width, self.height);
    CGPoint centerBegin = CGPointMake(floor(screenFrame.size.width / 2 - self.width / 2),
            screenFrame.size.height - floor(self.height / 2));
    CGPoint centerEnd = CGPointMake(floor(screenFrame.size.width / 2 - self.width / 2),
            screenFrame.size.height + floor(self.height / 2));

    CGRect rectBegin = CGRectMakeWithCenterPointAndSize(centerBegin, size);
    CGRect rectEnd   = CGRectMakeWithCenterPointAndSize(centerEnd, size);

    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
        [NSValue valueWithCGRect:rectBegin], UIKeyboardFrameBeginUserInfoKey,
        [NSValue valueWithCGRect:rectEnd], UIKeyboardFrameBeginUserInfoKey,
        nil];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"UIKeyboardWillHideNotification"
                                                        object:self userInfo:userInfo];

    if (animated)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:HS_TRANSITION_DURATION];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(dismissAsKeyboardAnimationDidStop)];
    }

    self.top += self.height;

    if (animated)
    {
        [UIView commitAnimations];
    }
    else
    {
        [self dismissAsKeyboardAnimationDidStop];
    }
}

- (UIViewController *)viewController
{
    for (UIView *next = [self superview]; next; next = next.superview)
    {
        UIResponder *nextResponder = [next nextResponder];

        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)nextResponder;
        }
    }

    return nil;
}

- (void)frameAnimationWithValues:(NSArray *)values
                       durations:(NSArray *)durations
                           delay:(CGFloat)delay
                       stepIndex:(NSUInteger)index
                      completion:(void (^)(BOOL finished))completion
                            step:(void (^)())step
{
    CGFloat duration = [[durations objectAtIndex:index] floatValue];
    id value         = [values objectAtIndex:index];

    [UIView animateWithDuration:duration delay:delay options:0 animations:^{
        self.frame = [value CGRectValue];
    } completion:^(BOOL finished) {
        if (index < values.count - 1)
        {
            if (step)
            {
                step();
            }

            [self frameAnimationWithValues:values
                                 durations:durations
                                     delay:0
                                 stepIndex:index + 1
                                completion:completion
                                      step:step];
        }
        else
        {
			// all finished
            if (completion)
            {
                completion(finished);
            }
        }
    }];
}

@end
