//
//  CIngredientDetailObject.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/29.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CIngredientDetailObject.h"

@implementation CIngredientDetailObject
+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"description":@"desc"}];
}

- (NSArray *)pictures {
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *pic in _pictures) {
        [array addObject:[kServer stringByAppendingString:pic]];
    }
    
    return array;
}
@end
