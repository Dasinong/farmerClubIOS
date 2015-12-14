//
//  CAAnimationGroup+Extra.m
//  AnimationEngine
//
//  Created by pre-team on 14-2-17.
//  Copyright (c) 2014年 pre-team. All rights reserved.
//

#import "CAAnimationGroup+Extra.h"

@implementation CAAnimationGroup (Extra)
+ (CAAnimationGroup*) forwardsAnimationWithDuration:(NSTimeInterval)duration
                                         animations:(NSArray*)animations
{
    CAAnimationGroup* group = [CAAnimationGroup animation];
    group.animations = animations;
    group.duration = duration;
    group.fillMode = kCAFillModeForwards;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];

    return group;
}

- (void) updateDurationWithMaxValue
{
    CGFloat max = 0.0;
    
    for (CAAnimation* animation in self.animations)
    {
        if (max < animation.duration )
        {
            max = animation.duration;
        }
    }
    
    self.duration = max;
}


@end
