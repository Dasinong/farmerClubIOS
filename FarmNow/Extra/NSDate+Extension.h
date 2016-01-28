//
//  NSDate+Extension.h
//  Spoon
//
//  Created by 曦炽 朱 on 14/12/15.
//  Copyright (c) 2014年 mirroon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)
+ (NSDate*)dateFromShaoziServer:(NSString*)dateString;
+ (NSString*)composeLongHistoryTimestamp:(NSDate*)historyDate;
+ (NSString*)composeShortHistoryTimestamp:(NSDate*)historyDate;
@end
