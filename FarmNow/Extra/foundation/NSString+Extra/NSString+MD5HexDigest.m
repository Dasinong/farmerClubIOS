//
//  NSString+MD5HexDigest.m
//  VIVA
//
//  Created by liangzhe on 13-5-13.
//
//

#import "NSString+MD5HexDigest.h"
@implementation NSString (md5)

- (NSString *)md5HexDigest
{
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];

    CC_MD5(original_str, (int)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];

    for (int i = 0; i < 16; i++)
    {
        [hash appendFormat:@"%02X", result[i]];
    }

    return [hash lowercaseString];
}

@end

@implementation NSData (md5)

- (NSString *)md5HexDigest
{
    const char *original_str = [self bytes];
    unsigned char result[CC_MD5_DIGEST_LENGTH];

    CC_MD5(original_str, (int)self.length, result);

    NSMutableString *hash = [NSMutableString string];

    for (int i = 0; i < 16; i++)
    {
        [hash appendFormat:@"%02X", result[i]];
    }

    return [hash lowercaseString];
}

@end
