//
//  CAKeyframeAnimation+Extra.h
//  VNews
//
//  Created by liangzhe on 周二 2013-12-31.
//  Copyright (c) 2013年 liangzhe. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CAAnimation (Extra)
@property ( nonatomic, weak ) id context;
@end

/**
 *  为所有的views依次执行animations中的动画
 */
@interface CAAnimationSequence : NSObject
@property( nonatomic, readonly ) NSString* name;
+(id)sequenceWithName:(NSString*)name
delayBetweenAnimation:(NSTimeInterval)delay
                views:(NSArray*)views
           animations:(NSArray*)animations
           completion:(void(^)(NSString* name, BOOL finished)) completion;
- (void) start;
- (void) cancel;

@end

@interface CAAnimationSequence()
@property( nonatomic, strong ) NSString* name;
@property( nonatomic, assign ) NSTimeInterval delayBetweenAnimation;
@property( nonatomic, strong ) NSArray* views, *animations;
@property( nonatomic, strong ) void (^completion)(NSString* name, BOOL finished);
@end

