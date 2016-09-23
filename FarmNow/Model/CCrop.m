//
//  CCrop.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/22.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CCrop.h"

@implementation CCrop

- (NSString *)iconUrl {
    return [NSString stringWithFormat:@"%@%@", kServer, _iconUrl];
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
	return YES;
}
@end
