//
//  CUserObject.m
//  FarmNow
//
//  Created by zheliang on 15/10/25.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CUserObject.h"

@implementation CUserObject
- (BOOL)isBASF {
    return [self.institutionId integerValue] == 3;
}
@end
