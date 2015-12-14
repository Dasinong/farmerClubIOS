//
//  UIView+AddSubview.h
//  SnapCoverFlow
//
//  Created by liangzhe on 13-10-3.
//  Copyright (c) 2013年 wangchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WCFStackLayout;

@interface UILabel (Creater)
+ (id)labelWithFontSize:(int)fontSize
          numberOfLines:(int)numberOfLines
         textColorValue:(NSUInteger)hexValue;
+ (id)labelWithFontSize:(int)fontSize
          numberOfLines:(int)numberOfLines
              textColor:(UIColor *)textColor;
- (void)leftAlignText;
- (void)rightAlignText;
- (void)centerAlignText;
@end

@interface UIView (WCFView_)
+ (id)view;
- (UITapGestureRecognizer *)addTapGestureWithTarget:(id)target action:(SEL)action;

- (id)addViewWithClass:(Class)className tapAction:(SEL)selector;

@end

@interface UIView (Auto)
- (void)dump;
- (void)addSubview:(UIView *)view withResizingMask:(UIViewAutoresizing)mask;
- (void)addFillSubview:(UIView *)view;
- (void)addBottomAlignSubview:(UIView *)view height:(CGFloat)height;

- (void)dockToLeft;
- (void)dockToTop;
- (void)dockToRight;
- (void)dockToBottom;
- (void)fillWidth;
- (void)fillHeight;
@end

@interface UIView (Extra_Visable)
- (id)ancestorForClass:(Class)classType;
@end
