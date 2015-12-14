//
//  NSString+Helper.m
//  ShareTest
//
//  Created by cai lei on 12-9-26.
//
//

#import "NSString+UrlEncode.h"

@implementation NSString (URLEncode)
- (NSString *)URLEncodedString
{
    NSString *result = (NSString *)CFBridgingRelease(
        CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
        (CFStringRef)self,
        NULL,
        CFSTR("!*'();:@&=+$,/?%#[]"),
        kCFStringEncodingUTF8));

    return result;
}

- (NSString *)stringByUTF8Escape
{
    return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)stringByUTF8Unescape
{
    return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (BOOL)isURL
{
    return [self hasPrefix:@"http://"];
}

- (NSURL *)url
{
    return [NSURL URLWithString:self];
}

- (NSURL *)url_s
{
    return [NSURL URLWithString:[self stringByUTF8Escape]];
}

@end
