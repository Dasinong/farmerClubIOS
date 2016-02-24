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
    return [NSString stringWithFormat:@"%@/nongshi/%@.jpg", kServer, _picture];
}

- (NSString *)thumbnailPicture {
    
    if (_thumbnailPicture.length > 0) {
        return [NSString stringWithFormat:@"%@/nongshi/%@.jpg", kServer, _thumbnailPicture];
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
