//
//  NSAttributedString+Extra.m
//  WORDSECRECTS
//
//  Created by liangzhe on 周二 2014-01-21.
//  Copyright (c) 2014年 liangzhe. All rights reserved.
//

#import "NSAttributedString+Extra.h"

#import "Defines.h"
#import "UIDevice+Extra.h"

@implementation NSAttributedString (Extra)

@end



@interface NSTextAttributes()
@property( nonatomic, strong ) NSMutableDictionary* attributes_;
@end

#define SET_ATTRIBUTE(key, value) [self.attributes_ setValue:value forKey:key];
@implementation NSTextAttributes
PROPERTY_GETTER(NSMutableDictionary, attributes_);

+ (id) attributes
{
    return [[NSTextAttributes alloc] init];
}

- (NSDictionary*)attributes
{
    return self.attributes_;
}

- (void) setFontName:(UIFont*) font
{
    if ([UIDevice iOS6Above])
        SET_ATTRIBUTE(NSFontAttributeName, font);
}

- (void) setParagraphStyle:(NSParagraphStyle*)style
{
    if ([UIDevice iOS6Above])
        SET_ATTRIBUTE(NSParagraphStyleAttributeName, style);
}

- (void) setForegroundColor:(UIColor*) foregroundColor
{
    if ([UIDevice iOS6Above])
        SET_ATTRIBUTE(NSForegroundColorAttributeName, foregroundColor);
}

- (void) setBackgroundColor:(UIColor*) backgroundColor
{
    if ([UIDevice iOS6Above])
        SET_ATTRIBUTE(NSBackgroundColorAttributeName, backgroundColor);
}

/*
 * 0: no ligature
 * 1: default ligature -- default
 * 2: all ligature
 */
- (void) setLigature:(NSInteger)ligature
{
    if ([UIDevice iOS6Above])
        SET_ATTRIBUTE(NSLigatureAttributeName, I2Num(ligature));
}

/*
 *  字距
 *   0 : disable kern -- default
 */
- (void) setKern:(CGFloat)kern
{
    if ([UIDevice iOS6Above])
        SET_ATTRIBUTE(NSKernAttributeName, [NSNumber numberWithFloat:kern]);
}

/*
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
- (void) setStrikethrough:(NSInteger)strikethrough
{
    if ([UIDevice iOS6Above])
        SET_ATTRIBUTE(NSStrikethroughStyleAttributeName, I2Num(strikethrough));
}

- (void) setUnderline:(NSInteger)underline
{
    if ([UIDevice iOS6Above])
        SET_ATTRIBUTE(NSUnderlineStyleAttributeName, I2Num(underline));
}

/*
 * 设置描边颜色
 */
- (void) setStrokeColor:(UIColor*)strokeColor
{
    if ([UIDevice iOS6Above])
        SET_ATTRIBUTE(NSStrokeColorAttributeName, strokeColor);
}

/*
 * 设置描边宽度
 *  0~100,字体的百分比
 *  0 :表示不作改变
 * >0 :仅改变描边宽度
 * <0 :同时改变描边宽度和填充宽度
 */
- (void) setStrokeWidth:(CGFloat)width
{
    if ([UIDevice iOS6Above])
        SET_ATTRIBUTE(NSStrokeWidthAttributeName, num_f(width));
}

- (void) setShadowWithOffset:(CGSize) offset
                  blurRadius:(CGFloat) radius
                       color:(UIColor*) color
{
    NSShadow* shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = offset;
    shadow.shadowBlurRadius = radius;
    shadow.shadowColor = (id)color;

    [self setShadow:shadow];
}

- (void) setShadow:(NSShadow*)shadow
{
    if ([UIDevice iOS6Above])
        SET_ATTRIBUTE(NSShadowAttributeName, shadow);
}

/*
 * effect 文字效果
 *      NSTextEffectLetterpressStyle
 */
- (void) setTextEffect:(NSString*)effect
{
    if ([UIDevice iOS7Above])
        SET_ATTRIBUTE(NSTextEffectAttributeName, effect);
}

- (void) setAttachment:(NSTextAttachment*)attachment
{
    if ([UIDevice iOS7Above])
        SET_ATTRIBUTE(NSAttachmentAttributeName, attachment);
}

- (void) setLink:(NSString*)linkURL
{
    if ([UIDevice iOS7Above])
        SET_ATTRIBUTE(NSLinkAttributeName, [NSURL URLWithString:linkURL]);
}

- (void) setBaselineOffset:(CGFloat)offset
{
    if ([UIDevice iOS7Above])
        SET_ATTRIBUTE(NSBaselineOffsetAttributeName, num_f(offset));
}

- (void) setUnderlineColor:(UIColor*) color
{
    if ([UIDevice iOS7Above])
        SET_ATTRIBUTE(NSUnderlineColorAttributeName, color);
}

- (void) setStrikethoughCOlor:(UIColor*) color
{
    if ([UIDevice iOS7Above])
        SET_ATTRIBUTE(NSStrikethroughColorAttributeName, color);
}

/*
 * 设置斜度
 */
- (void) setObliqueness:(CGFloat)obliqueness
{
    if ([UIDevice iOS7Above])
        SET_ATTRIBUTE(NSObliquenessAttributeName, num_f(obliqueness*M_PI/180.0));
}

/*
 * 膨胀系数
 */
- (void) setExpansion:(CGFloat) expansion
{
    if ([UIDevice iOS7Above])
        SET_ATTRIBUTE(NSExpansionAttributeName, num_f(expansion));
}

/*
 * 从外向内设置书写方向
 * array为NSNumber数组, NSNumber的值为下面4个数值之一
 *  0 LRE  从左向右书写 嵌入文字书写方向
 *  1 RLE  从右向左书写 嵌入文字书写方向
 *  2 LRO  从左向右书写 覆盖文字书写方向
 *  3 RLO  从右向左书写 覆盖文字书写方向
 */
- (void) setWritingDirection:(NSArray*) array
{
    if ([UIDevice iOS7Above])
    {
        SET_ATTRIBUTE(NSWritingDirectionAttributeName, array);
    }
}

/*
 * 设置字符的方向
 */
- (void) setVerticleGlyphForm:(BOOL)vertical
{
    if ([UIDevice iOS6Above])
    {
        SET_ATTRIBUTE(NSVerticalGlyphFormAttributeName, I2Num(vertical?1:0));
    }
}
@end


