
#import "UIColor+hexColor.h"

@implementation UIColor (hexColor)

+ (UIColor *)colorwithHexString:(NSString *)hexString alpha:(float)alpha
{
    return [[self colorwithHexString:hexString] colorWithAlphaComponent:alpha];
}

+ (UIColor *)colorwithHexString:(NSString *)hexString
{
    if (hexString == nil || (id)hexString == [NSNull null]) {
        return nil;
    }
    UIColor *col;
    if (![hexString hasPrefix:@"#"]) {
        hexString = [NSString stringWithFormat:@"#%@", hexString];
    }
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#"
                                                     withString:@"0x"];
    uint hexValue;
    if ([[NSScanner scannerWithString:hexString] scanHexInt:&hexValue]) {
        col = [UIColor
               colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
               green:((float)((hexValue & 0xFF00) >> 8))/255.0
               blue:((float)(hexValue & 0xFF))/255.0
               alpha:1.0f];
    } else {
        col = [UIColor clearColor];
    }
    return col;
}

@end
