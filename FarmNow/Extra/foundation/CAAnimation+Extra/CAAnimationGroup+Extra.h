//
//  CAAnimationGroup+Extra.h
//  AnimationEngine
//
//  Created by pre-team on 14-2-17.
//  Copyright (c) 2014年 pre-team. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "CAAnimation+Extra.h"

@interface CAAnimationGroup (Extra)
+ (CAAnimationGroup*) forwardsAnimationWithDuration:(NSTimeInterval)duration
                                         animations:(NSArray*)animations;
- (void) updateDurationWithMaxValue;

@end

