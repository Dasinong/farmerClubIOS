//
//  CSearchWordModel.m
//  FarmNow
//
//  Created by zheliang on 15/10/27.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CSearchWordModel.h"

@implementation CSearchAllWordParams

+ (NSString *)path
{
	return @"searchWord";
}
@end

@implementation CSearchAllWordModel

+ (JSONKeyMapper *)keyMapper
{
	return [[JSONKeyMapper alloc] initWithDictionary:@{@"data.cpproduct":@"cpproduct",
													  @"data.disease":@"disease",
													  @"data.pest":@"pest",
													  @"data.variety":@"variety"}];
}

@end

@implementation CSearchSingleWordParams

+ (NSString *)path
{
	return @"searchWord";
}

@end

@implementation CSearchSingleWordModel


@end
