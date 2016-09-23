//
//  CTaskStep.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/23.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CTaskStep.h"

@implementation CTaskStep
- (NSString *)picture {
    
    NSArray *pics = [_picture componentsSeparatedByString:@","];
    return [NSString stringWithFormat:@"%@/nongshi/%@.jpg", kServer, pics[0]];
}

- (NSString *)thumbnailPicture {
    
    if (_thumbnailPicture.length > 0) {
        NSArray *pics = [_thumbnailPicture componentsSeparatedByString:@","];
        return [NSString stringWithFormat:@"%@/nongshi/%@.jpg", kServer,pics[0]];
    }
    else {
        return self.picture;
    }
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"description":@"desc"}];
    
}
@end
