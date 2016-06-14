//
//  CCoupon.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/14.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CCoupon.h"

@implementation CCoupon
- (BOOL)expired {
    return ![self.displayStatus isEqualToString:@"NOT_USED"];
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    if ([propertyName isEqualToString: @"scannerId"]) return YES;
    if ([propertyName isEqualToString: @"claimedAt"]) return YES;
    if ([propertyName isEqualToString: @"redeemedAt"]) return YES;
    if ([propertyName isEqualToString: @"campaignId"]) return YES;
    if ([propertyName isEqualToString: @"comment"]) return YES;
    
    return NO;
}

- (BOOL)isInsurance {
    return [[self.type uppercaseString] isEqualToString:@"INSURANCE"];
}
@end
