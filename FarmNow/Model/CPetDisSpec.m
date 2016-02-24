//
//  CPetDisSpec.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/23.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CPetDisSpec.h"

@implementation CPetDisSpec
+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

- (NSArray *)imagesPath {
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSString *imagePath in _imagesPath) {
        [array addObject:[NSString stringWithFormat:@"%@/pic/%@", kServer, imagePath]];
    }
    
    return array;
}
@end
