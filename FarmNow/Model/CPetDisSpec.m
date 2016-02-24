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

- (NSString *)imageForIndex:(NSInteger)index {
    NSString *imagePath = self.imagesPath[index];
    return [NSString stringWithFormat:@"%@/pic/%@", kServer, imagePath];
}
@end
