//
//  CRemoteControModel.m
//  FarmNow
//
//  Created by zheliang on 15/12/15.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CRemoteControModel.h"

@implementation CRemoteControParams

+ (NSString *)path
{
	return @"gatekeepers";
}

@end

@implementation CRemoteControModel
- (instancetype)init
{
	if (self = [super init]) {
		self.qqLogin = NO;
		self.weixinLogin = NO;
	}
	return self;
}


//+ (BOOL)propertyIsOptional:(NSString *)propertyName
//{
//	if ([propertyName isEqualToString:@"qqLogin"] || [propertyName isEqualToString:@"weixinLogin"]) {
//		return YES;
//	}
//	return NO;
//}

@end
