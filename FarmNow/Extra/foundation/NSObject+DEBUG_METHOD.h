//
//  NSObject+DEBUG_METHOD.h
//  HomeService
//
//  Created by pre-team on 14-5-15.
//  Copyright (c) 2014年 pre-team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DEBUG_METHOD)
+ (void)replaceOrginSEL:(SEL)originSEL
             withNewSEL:(SEL)newSEL
            backupToSEL:(SEL)backupSEL;
@end
