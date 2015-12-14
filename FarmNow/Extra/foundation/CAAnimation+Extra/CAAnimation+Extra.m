//
//  CAKeyframeAnimation+Extra.m
//  VNews
//
//  Created by liangzhe on 周二 2013-12-31.
//  Copyright (c) 2013年 liangzhe. All rights reserved.
//

#import "CAAnimation+Extra.h"
#import "Defines.h"
#import "NSLog+Extra.h"
#import "NSArray+Extra.h"

@implementation CAAnimation (Extra)
- (void) setContext:(id)context
{
    [self setValue:context forKey:@"context"];
}

- (id) context
{
    return [self valueForKey:@"context"];
}
@end


@implementation CAAnimationSequence
{
    NSTimer* _timer;
    BOOL _isAnimating;
    BOOL _cancel;
    NSUInteger _numberOfExecuted, _numberOfAnimationFinished;
}

+(id)sequenceWithName:(NSString*)name
delayBetweenAnimation:(NSTimeInterval)delay
                views:(NSArray*)views
           animations:(NSArray*)animations
           completion:(void(^)(NSString* name, BOOL finished)) completion
{
    if (!views.count || !animations.count )
    {
        Error(@"invalid views or animations");
        return nil;
    }

    if ( views.count != animations.count )
    {
        Error(@"views and animations must match");
        return nil;
    }

    CAAnimationSequence* instance = [[CAAnimationSequence alloc] init];
    instance.delayBetweenAnimation = (delay < 1/24.0)? 1/24.0:delay;
    instance.name = name;
    instance.views = views;
    instance.animations = animations;
    instance.completion = completion;
    return instance;
}

- (void) start
{
    if (_isAnimating)
    {
        Info(@"%@",@"need cancel previous animation");
        return;
    }

    _isAnimating = YES;
    _numberOfExecuted = 0;
    _numberOfAnimationFinished = 0;
    _cancel = NO;
    _timer = [NSTimer timerWithTimeInterval:self.delayBetweenAnimation target:self selector:@selector(execute:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];

}

- (void) cancel
{
    if (_isAnimating)
    {
        _cancel = YES;

        if (_numberOfExecuted == _numberOfAnimationFinished)
        {
            // 所有已经处理的动画均以完成,但是队列中还有未处理的动画,此时直接停止_timer,并通知结束
            [_timer invalidate];
            _timer = nil;

            _isAnimating = NO;
            // all animation finished
            if (self.completion)
            {
                self.completion( self.name, NO);
            }
        }
        else
        {
            Info(@"%@", @"wait animation finished");
        }
    }
}

- (void) execute:(id)sender
{
    if (_cancel || _numberOfExecuted == self.animations.count)
    {
        [_timer invalidate];
        _timer = nil;
        return;
    }

    //Info(@"");
    CAAnimation* animation = [self.animations objectAtIndex_s:_numberOfExecuted];
    UIView* view = [self.views objectAtIndex_s:_numberOfExecuted];

    animation.delegate = self;
    [animation setValue:str_fmt(@"%@:%lu", self.name, (unsigned long)_numberOfExecuted) forKey:@"id"];
    [view.layer addAnimation:animation forKey:str_fmt(@"squence-animation:<%@#%lu>", self.name, (unsigned long)_numberOfExecuted)];

    _numberOfExecuted++;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //NSString* animationIdentify = [anim valueForKey:@"id"];
    //Info(@"animation:%@ finsihed:%@", animationIdentify, flag?@"YES":@"NO");

    _numberOfAnimationFinished++;

    if (_numberOfAnimationFinished == self.animations.count)
    {
        _isAnimating = NO;
        // all animation finished
        if (self.completion)
        {
            self.completion( self.name, YES);
        }
    }
    else
    {
        if (_cancel)
        {
            if (self.completion)
            {
                self.completion( self.name, NO);
            }
        }
    }
}
@end