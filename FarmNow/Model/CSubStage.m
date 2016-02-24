//
//  CSubStage.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/2/23.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CSubStage.h"

@implementation CSubStage

- (NSString *)stageDisplayName {
    if ([self.stageName isEqualToString:self.subStageName]) {
        return self.stageName;
    }
    else {
        return [NSString stringWithFormat:@"%@-%@", self.stageName, self.subStageName];
    }
}
@end
