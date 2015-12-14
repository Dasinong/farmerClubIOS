//
//  StringUtil.m
//  VIVA
//
//  Created by Zhel on 12-12-20.
//
//

#import "StringUtil.h"

@implementation NSString(LocalCompare)

- (NSComparisonResult)chineseCompare:(NSString*)aString;
{
	NSComparisonResult ret = NSOrderedAscending;
	if ([self length] > 0 && [aString length] > 0)
	{
		int len = [self length] > [aString length]? [aString length]:[self length];
		NSLocale *local = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_hans"];
		ret = [self compare:aString options:NSCaseInsensitiveSearch range:NSMakeRange(0, len) locale:local];
	}
	else
	{
		if ([self length] == 0)
		{
			ret = -1;
		}
		else
		{
			ret = 1;
		}
	}
    
	return ret;
}

- (NSString *)stringByAddingPercentEscapesUsingUTF8StringEncoding
{
    NSString *tmpString =[self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if (tmpString == nil)
    {
        tmpString = [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    else
    {
        tmpString = [tmpString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    return tmpString;
}


+ (NSString*)changeString:(NSString*)sender{
    NSMutableString* myMutableString = [[NSMutableString alloc]initWithString:sender];
    NSMutableArray* myMutableArray = [[NSMutableArray alloc]initWithCapacity:0];
    NSInteger len = [sender length];
    if (len%3 == 1) {
        [myMutableArray addObject:[myMutableString substringToIndex:1]];
        NSInteger record = len/3;
        for (NSInteger i = 0; i < record; i ++) {
            [myMutableArray addObject:[myMutableString substringWithRange:NSMakeRange(i*3 + 1, 3)]];
        }
    }else if (len%3 == 2){
        [myMutableArray addObject:[myMutableString substringToIndex:2]];
        NSInteger record = len/3;
        for (NSInteger i = 0; i < record; i ++) {
            [myMutableArray addObject:[myMutableString substringWithRange:NSMakeRange(i*3 + 2, 3)]];
        }
    }else{
        NSInteger record = len/3;
        for (NSInteger i = 0; i < record; i ++) {
            [myMutableArray addObject:[myMutableString substringWithRange:NSMakeRange(i*3, 3)]];
        }
    }
    
    return [myMutableArray componentsJoinedByString:@","];
}

+ (NSInteger)judgeMagzineTypeForDownloadUrl:(NSString *)url
{
    NSArray *array = [url componentsSeparatedByString:@"."];
    if ([array count] > 0) {
        NSString *suffixString = [array lastObject];
        BOOL result = [suffixString compare:@"vmag"
                       
                                    options:NSCaseInsensitiveSearch];
        if (result == NSOrderedSame) {
            return 0;//vmag
        }
        result = [suffixString compare:@"vx2" options:NSCaseInsensitiveSearch];
        if (result == NSOrderedSame) {
            return 1;//vx2
        }
        result = [suffixString compare:@"zip" options:NSCaseInsensitiveSearch];
        if (result == NSOrderedSame) {
            return 2;//xuankan
        }
    }
    return -1;
}
@end
