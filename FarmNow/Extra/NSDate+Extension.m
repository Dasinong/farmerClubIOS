//
//  NSDate+Extension.m
//  Spoon
//
//  Created by 曦炽 朱 on 14/12/15.
//  Copyright (c) 2014年 mirroon. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)
+ (NSDate*)dateFromShaoziServer:(NSString*)dateString {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    return [dateFormat dateFromString:dateString];
}

+ (NSString*)composeLongHistoryTimestamp:(NSDate *)historyDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSString *formattedDateString = @"";
    if ([[NSCalendar currentCalendar] isDateInToday:historyDate]) {
        [dateFormatter setDateFormat:@"aaaa HH:mm"];
        formattedDateString = [dateFormatter stringFromDate:historyDate];
        
    }
    else if ([[NSCalendar currentCalendar] isDateInYesterday:historyDate])
    {
        [dateFormatter setDateFormat:@"aaaa HH:mm"];
        formattedDateString = [@"昨天 " stringByAppendingString:[dateFormatter stringFromDate:historyDate]];
    }
    else if ([[NSCalendar currentCalendar] isDateInWeekend:historyDate])
    {
        [dateFormatter setDateFormat:@"EEEE HH:mm"];
        formattedDateString = [dateFormatter stringFromDate:historyDate];
    }
    else
    {
        [dateFormatter setDateFormat:@"MM/dd/yyyy aaaa HH:mm"];
        formattedDateString = [dateFormatter stringFromDate:historyDate];
    }
    
    return formattedDateString;
}

+ (NSString*)composeShortHistoryTimestamp:(NSDate *)historyDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSString *formattedDateString = @"";
    if ([[NSCalendar currentCalendar] isDateInToday:historyDate]) {
        [dateFormatter setDateFormat:@"aaaa HH:mm"];
        formattedDateString = [dateFormatter stringFromDate:historyDate];
    }
    else if ([[NSCalendar currentCalendar] isDateInYesterday:historyDate])
    {
        formattedDateString = @"昨天";
    }
    else if ([[NSCalendar currentCalendar] isDateInWeekend:historyDate])
    {
        [dateFormatter setDateFormat:@"EEEE"];
        formattedDateString = [dateFormatter stringFromDate:historyDate];
    }
    else
    {
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
        formattedDateString = [dateFormatter stringFromDate:historyDate];
    }

    return formattedDateString;
}

@end
