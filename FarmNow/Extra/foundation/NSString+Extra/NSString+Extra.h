//
// NSString+Extra.h
// KuowoBeam
//
// Created by liangzhe on 周三 2013-11-20.
// Copyright (c) 2013年 liangzhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Path.h"
#import "NSString+MD5HexDigest.h"
#import "NSString+UrlEncode.h"
#import "NSString+Define.h"
#import "NSString+Valid.h"

@interface NSString (Extra)
+ (NSString*)stringFromUTF8File:(NSString*)path;
+ (NSString*)stringWithUTF8Data:(NSData*)data;
- (void)writeToUTF8File:(NSString*)path;

- (NSRange)rangeOfString:(NSString*)text fromPosition:(NSUInteger)position;
- (NSRange)rangeBetweenTag1:(NSString*)startTag tag2:(NSString*)endTag;
- (NSRange)rangeContaineTag1:(NSString*)startTag tag2:(NSString*)endTag;
- (NSString*)replace:(NSString*)toRepleace with:(NSString*)replace;
- (NSString*)replace:(NSString*)target, ...;

- (NSArray*)split:(NSString*)separator;
- (NSArray*)splitByCharacters:(NSString*)characters;

- (NSString*)trimAll;
+(NSString*)subFirstLetter:(NSString *)theString;

@end

@interface NSString (Format)
+ (NSString*)stringFromDate:(NSDate*)date;
@end
