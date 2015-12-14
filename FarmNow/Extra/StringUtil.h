//
//  StringUtil.h
//  VIVA
//
//  Created by vivame on 12-12-20.
//
//

#import <Foundation/Foundation.h>

@interface  NSString(LocalCompare)

- (NSComparisonResult)chineseCompare:(NSString*)aString;
- (NSString *)stringByAddingPercentEscapesUsingUTF8StringEncoding;

//NSString:7464532--->7,464,532
+ (NSString*)changeString:(NSString*)sender;

//根据URL后缀判断杂志类型
+ (NSInteger)judgeMagzineTypeForDownloadUrl:(NSString *)url;

@end
