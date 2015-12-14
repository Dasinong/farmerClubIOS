//
// UIColor+HexColor.h
// BuildeTower
//
// Created by liangzhe on 13-6-26.
// Copyright (c) 2013年 liangzhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexColor)
+ (UIColor*)colorWithHex:(NSUInteger)hexValue;
+ (UIColor*)colorWithHex:(NSUInteger)hexValue alpha:(CGFloat)alpha;
+ (UIColor*)randomColor;
+ (UIColor*)randomDeepColor;
+ (UIColor*)randomDeepColorWithAlpha:(CGFloat)alpha;

+ (UIColor*)randomFlatColor;
+ (UIColor*)randomDarkFlatColor;
+ (UIColor*)randomLightFlatColor;


- (NSUInteger)hexValue;

/*对当前颜色取反*/
- (UIColor*)colorByNegtive;

/*产生和当前颜色对比,易于区分的颜色*/
- (UIColor*)colorForForeground;
- (UIColor*)colorForForeground2;


@end

#define COLOR(hexValue)                 [UIColor colorWithHex : (hexValue)]
#define COLOR_RANDOM()                  [UIColor randomColor]
#define COLOR_RANDOM_DEEP()                  [UIColor randomDeepColor]
#define COLOR_RANDOM_WITH_APLHA(alpha)  [UIColor randomDeepColorWithAlpha : alpha]
#define COLORA(hexValue, alphaValue)    [UIColor colorWithHex : (hexValue) alpha : alphaValue]

#define CLEAR_COLOR()                   [UIColor clearColor]

#define CGCOLOR(hexValue)               [UIColor colorWithHex : (hexValue)].CGColor
#define CGCOLOR_RANDOM()             [UIColor randomColor].CGColor

#define COLOR_RED  [UIColor redColor]
#define COLOR_BLUE [UIColor blueColor]
#define COLOR_GREEN [UIColor greenColor]
#define COLOR_CLEAR [UIColor clearColor]
#define COLOR_BLACK [UIColor blackColor]
#define COLOR_WHITE [UIColor whiteColor]
