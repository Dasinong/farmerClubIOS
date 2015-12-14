//
// NSString+Extra.m
// KuowoBeam
//
// Created by liangzhe on 周三 2013-11-20.
// Copyright (c) 2013年 liangzhe. All rights reserved.
//

#import "NSString+Extra.h"
#import "NSLog+Extra.h"
#import "CSpinyinHelper.h"

@implementation NSString (Extra)

/*
 *英文 截取第一个字母
 *汉字 截取首汉字的首字母
 *其余字符返回 #
 */
+(NSString*)subFirstLetter:(NSString *)theString{
	NSString* key = @"#";
	
	if (theString == nil || [theString length] == 0) {
		return key;
	}
	
	if ([[theString substringToIndex:1] canBeConvertedToEncoding:NSASCIIStringEncoding]) {
		key = [[theString substringToIndex:1] uppercaseString];
		char letter = 0;
		if(key.length > 0){
			letter = [key characterAtIndex:0];
		}
		if (letter < 65 || letter > 90) {
			key = @"#";
		}
	}else{
		key = [[NSString stringWithFormat:@"%c",pinyinFirstLetter([theString characterAtIndex:0])] uppercaseString];
	}
	return key;
	
}
+ (NSString*)stringFromUTF8File:(NSString*)path
{
    NSError    *error  = nil;
    NSString   *result = [[self class] stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];

    if (error)
    {
        Error(@"read content form file:%@ faield. %@", path, [error localizedDescription]);
    }

    return result;
} /* stringFromUTF8File */

+ (NSString*)stringWithUTF8Data:(NSData*)data
{
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (void)writeToUTF8File:(NSString*)path
{
    NSError   *error = nil;

    [self writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error];

    if (error)
    {
        Error(@"%@", [error localizedDescription]);
    }
}

- (NSRange)rangeOfString:(NSString*)text fromPosition:(NSUInteger)begin
{
    return [self rangeOfString:text
                       options:NSCaseInsensitiveSearch
                         range:NSMakeRange(begin, self.length - begin)];
}

// 返回包含两个指定标签的范围
- (NSRange)rangeContaineTag1:(NSString*)startTag tag2:(NSString*)endTag
{
    NSRange    result = {0, 0};
    NSRange    begin  = [self rangeOfString:startTag];

    if (begin.length > 0)
    {
        NSUInteger    beginMax = NSMaxRange(begin);
        NSRange       end      = [self rangeOfString:endTag fromPosition:beginMax];

        result.location = begin.location;

        if (end.length > 0)
        {
            result.length = NSMaxRange(end) - begin.location;
        }
    }

    return result;
} /* rangeContaineTag1 */

// 返回两个指定标签之间的范围
- (NSRange)rangeBetweenTag1:(NSString*)startTag tag2:(NSString*)endTag
{
    NSRange    result = {0, 0};
    NSRange    begin  = [self rangeOfString:startTag];

    if (begin.length > 0)
    {
        NSUInteger    beginMax = NSMaxRange(begin);
        NSRange       end      = [self rangeOfString:endTag fromPosition:beginMax];

        result.location = beginMax;

        if (end.length > 0)
        {
            result.length = end.location - beginMax;
        }
    }

    return result;
} /* rangeBetweenTag1 */

- (NSString*)replace:(NSString*)target with:(NSString*)replacement
{
    return [self stringByReplacingOccurrencesOfString:target withString:replacement];
}

- (NSString*)replace:(NSString*)target, ...
{
    va_list    vp;
    va_start(vp, target);
    NSString   *replacement = va_arg(vp, NSString*);
    va_end(vp);

    return [self stringByReplacingOccurrencesOfString:target withString:replacement];
}

- (NSString*)replaceIn:(NSString*)target, ...
{
    va_list    vp;
    va_start(vp, target);
    NSString   *replacement = va_arg(vp, NSString*);
    va_end(vp);

    return [self stringByReplacingOccurrencesOfString:target withString:replacement];
}

- (NSArray*)split:(NSString*)separator
{
    NSArray   *components = [self componentsSeparatedByString:separator];

    return components;
}

- (NSArray*)splitByCharacters:(NSString*)characters
{
    NSArray   *components = [self componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:characters]];

    return components;
}

- (NSString*)trimAll
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end



@implementation NSString (Format)

+ (NSString*)stringFromDate:(NSDate*)date
{
    static dispatch_once_t    onceToken = 0;
    static NSDateFormatter   *formatter = nil;

    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    });

    return [formatter stringFromDate:date];
} /* stringFromDate */

@end
