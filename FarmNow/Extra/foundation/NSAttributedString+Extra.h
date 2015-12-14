//
//  NSAttributedString+Extra.h
//  WORDSECRECTS
//
//  Created by liangzhe on 周二 2014-01-21.
//  Copyright (c) 2014年 liangzhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (Extra)

@end

@interface NSTextAttributes:NSObject
@property( nonatomic, readonly ) NSDictionary* attributes;
+ (id) attributes;

- (void) setFontName:(UIFont*) font;
- (void) setParagraphStyle:(NSParagraphStyle*)style;

- (void) setForegroundColor:(UIColor*) foregroundColor;
- (void) setBackgroundColor:(UIColor*) backgroundColor;
/*
 * 0: no ligature
 * 1: default ligature -- default
 * 2: all ligature
 */
- (void) setLigature:(NSInteger)ligature;
/*
 *  字距
 *   0 : disable kern -- default
 */
- (void) setKern:(CGFloat)kern;


/* 
 * 删除线和下划线样式
 *   NSUnderlineStyleNone = 0x00,
 *   NSUnderlineStyleSingle = 0x01,
 *   NSUnderlineStyleThick = 0x02,
 *   NSUnderlineStyleDouble = 0x09,
 *
 *   NSUnderlinePatternSolid = 0x0000,
 *   NSUnderlinePatternDot = 0x0100,
 *   NSUnderlinePatternDash = 0x0200,
 *   NSUnderlinePatternDashDot = 0x0300,
 *   NSUnderlinePatternDashDotDot = 0x0400,
 *   NSUnderlineByWord = 0x8000
 */

/*
 * 删除线
 * 默认为:NSUnderlineStyleNone
 */
- (void) setStrikethrough:(NSInteger)strikethrough;
- (void) setUnderline:(NSInteger)underline;
/*
 * 设置描边颜色
 */
- (void) setStrokeColor:(UIColor*)strokeColor;
/*
 * 设置描边宽度
 *  0~100,字体的百分比
 *  0 :表示不作改变
 * >0 :仅改变描边宽度
 * <0 :同时改变描边宽度和填充宽度
 */
- (void) setStrokeWidth:(CGFloat)width;
- (void) setShadowWithOffset:(CGSize) offset
                  blurRadius:(CGFloat) radius
                       color:(UIColor*) color;
- (void) setShadow:(NSShadow*)shadow;
/*
 * effect 文字效果
 *      NSTextEffectLetterpressStyle
 */
- (void) setTextEffect:(NSString*)effect;
- (void) setAttachment:(NSTextAttachment*)attachment;
- (void) setLink:(NSString*)linkURL;
- (void) setBaselineOffset:(CGFloat)offset;
- (void) setUnderlineColor:(UIColor*) color;
- (void) setStrikethoughCOlor:(UIColor*) color;
/*
 * 设置斜度
 */
- (void) setObliqueness:(CGFloat)obliqueness;
/*
 * 膨胀系数
 */
- (void) setExpansion:(CGFloat) expansion;
/*
 * 从外向内设置书写方向
 * array为NSNumber数组, NSNumber的值为下面4个数值之一
 *  0 LRE  从左向右书写 嵌入文字书写方向
 *  1 RLE  从右向左书写 嵌入文字书写方向
 *  2 LRO  从左向右书写 覆盖文字书写方向
 *  3 RLO  从右向左书写 覆盖文字书写方向
 */
- (void) setWritingDirection:(NSArray*) array;/*
 * 设置字符的方向
 */
- (void) setVerticleGlyphForm:(BOOL)vertical;
@end

