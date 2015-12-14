//
//  CAKeyframeAnimation+Extra.m
//  AnimationEngine
//
//  Created by pre-team on 14-2-17.
//  Copyright (c) 2014年 pre-team. All rights reserved.
//

#import "CAKeyframeAnimation+Extra.h"

#import "Defines.h"
#import "NSArray+Extra.h"
#import "UIColor+Extra.h"

@implementation CAKeyframeAnimation (Extra)

+ (id) animationWithKey:(NSString*)key
                                frameRate:(CGFloat)frameRate
                                   values:(NSArray*)values
                                 keyTimes:(NSArray*)keyTimes
{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:key];
    
    animation.values = values;
    animation.keyTimes = [keyTimes keyTimes];
    animation.duration = [keyTimes sum]/frameRate;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    return animation;
}

+ (id) backgroundAnimation:(CGFloat)frameRate
                                      values:(NSArray*)values
                                    keyTimes:(NSArray*)keyTimes
{
    return [[self class]  animationWithKey:@"backgroundColor"
                                 frameRate:frameRate
                                    values:values
                                  keyTimes:keyTimes];
}

+ (id) boundsAnimation:(CGFloat)frameRate
                                  values:(NSArray*)values
                                keyTimes:(NSArray*)keyTimes
{
    return [[self class]  animationWithKey:@"bounds"
                                 frameRate:frameRate
                                    values:values
                                  keyTimes:keyTimes];
}

+ (id) positionAnimation:(CGFloat)frameRate
                                    values:(NSArray*)values
                                  keyTimes:(NSArray*)keyTimes
{
    return [[self class]  animationWithKey:@"position"
                                 frameRate:frameRate
                                    values:values
                                  keyTimes:keyTimes];
}

+ (id) opacityAnimation:(CGFloat)frameRate
                                   values:(NSArray*)values
                                 keyTimes:(NSArray*)keyTimes
{
    return [[self class]  animationWithKey:@"opacity"
                                 frameRate:frameRate
                                    values:values
                                  keyTimes:keyTimes];
}


+ (id) pathAnimation:(CGFloat)frameRate
                                values:(NSArray*)values
                              keyTimes:(NSArray*)keyTimes
{
    return [[self class] animationWithKey:@"path"
                                frameRate:frameRate
                                   values:values
                                 keyTimes:keyTimes];
}


@end


/*
 *
 CA_EXTERN NSString * const kCAMediaTimingFunctionLinear
 __OSX_AVAILABLE_STARTING (__MAC_10_5, __IPHONE_2_0);
 CA_EXTERN NSString * const kCAMediaTimingFunctionEaseIn
 __OSX_AVAILABLE_STARTING (__MAC_10_5, __IPHONE_2_0);
 CA_EXTERN NSString * const kCAMediaTimingFunctionEaseOut
 __OSX_AVAILABLE_STARTING (__MAC_10_5, __IPHONE_2_0);
 CA_EXTERN NSString * const kCAMediaTimingFunctionEaseInEaseOut
 __OSX_AVAILABLE_STARTING (__MAC_10_5, __IPHONE_2_0);
 CA_EXTERN NSString * const kCAMediaTimingFunctionDefault
 __OSX_AVAILABLE_STARTING (__MAC_10_6, __IPHONE_3_0);

 */

@implementation CAKeyframeAnimation (Extra2)
+ (NSString*) timingFunctionWithType:(NSUInteger)index
{
    NSString* kSupportTimingFunctions[] = {
        kCAMediaTimingFunctionLinear,
        kCAMediaTimingFunctionEaseIn,
        kCAMediaTimingFunctionEaseOut,
        kCAMediaTimingFunctionEaseInEaseOut,
        kCAMediaTimingFunctionDefault
    };

    return index < sizeof(kSupportTimingFunctions)? kSupportTimingFunctions[index] : nil;
}

- (void) setTimingFunctionType:(CAAnimationTimingFunctionType)timingFunctionType
{
    NSString* name = [[self class] timingFunctionWithType:timingFunctionType];
    self.timingFunction = [CAMediaTimingFunction functionWithName:name];
}

- (CAAnimationTimingFunctionType)timingFunctionType
{
    return ECAAnimationTimingFunctionLinear;
}

+ (id) rotateWithDuration:(NSTimeInterval)duration
                  radians:(NSArray*)radians
                 keyTimes:(NSArray*)keyTimes
                     axis:(NSString*)axis
{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:str_fmt(@"transform.rotation.%@", axis)];
    animation.values = radians;
    animation.keyTimes = keyTimes;
    animation.duration = duration;
    animation.cumulative = YES;
    animation.removedOnCompletion = NO;
    animation.timingFunction = [ CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    return animation;
}
+ (id) rotateZWithDuration:(NSTimeInterval)duration
                   radians:(NSArray*)radians
                  keyTimes:(NSArray*)keyTimes
{
    return [self rotateWithDuration:duration radians:radians keyTimes:keyTimes axis:@"z"];
}

+ (id) rotateXWithDuration:(NSTimeInterval)duration
                   radians:(NSArray*)radians
                  keyTimes:(NSArray*)keyTimes
{
    return [self rotateWithDuration:duration radians:radians keyTimes:keyTimes axis:@"x"];
}

+ (id) rotateYWithDuration:(NSTimeInterval)duration
                   radians:(NSArray*)radians
                  keyTimes:(NSArray*)keyTimes
{
    return [self rotateWithDuration:duration radians:radians keyTimes:keyTimes axis:@"y"];
}

#define Radian(degree) ((degree)*M_PI/180.0)
+(id) bounceWithDuration:(NSTimeInterval)duration
                   start:(CGPoint)start
                     end:(CGPoint)end
{

    int xOffset = (end.x - start.x)> 0?1:-1;
    int yOffset = (end.y - start.y)> 0?1:-1;
    CGPoint nearPoint = end;
    nearPoint.x -= xOffset;
    nearPoint.y -= yOffset;

    CGPoint farPoint = end;
    farPoint.x += xOffset;
    farPoint.y += yOffset;

    return [self positionWithDuration:duration
                               points:array([NSValue valueWithCGPoint:start],
                                            [NSValue valueWithCGPoint:farPoint],
                                            [NSValue valueWithCGPoint:nearPoint],
                                            [NSValue valueWithCGPoint:end] )
                             keyTimes:nil];
}

+(id) bounceWithDuration:(NSTimeInterval)duration
                   start:(CGPoint)start
                  point1:(CGPoint)point1
                     end:(CGPoint)end
{
    int xOffset = (end.x > start.x) ? 1:-1;
    int yOffset = (end.y > start.y) ? 1:-1;
    CGPoint nearPoint = end;
    nearPoint.x -= xOffset;
    nearPoint.y -= yOffset;

    CGPoint farPoint = end;
    farPoint.x += xOffset;
    farPoint.y += yOffset;

    return [self positionWithDuration:duration
                               points:array([NSValue valueWithCGPoint:start],
                                            [NSValue valueWithCGPoint:point1],
                                            [NSValue valueWithCGPoint:farPoint],
                                            [NSValue valueWithCGPoint:nearPoint],
                                            [NSValue valueWithCGPoint:end] )
                             keyTimes:nil];
}

+(id) positionWithDuration:(NSTimeInterval)duration
                     start:(CGPoint)start
                       end:(CGPoint)end
{
    return [self positionWithDuration:duration
                               points:array([NSValue valueWithCGPoint:start],
                                            [NSValue valueWithCGPoint:end] )
                             keyTimes:nil];
}

+ (id) positionWithDuration:(NSTimeInterval)duration
                     points:(NSArray*)points
                   keyTimes:(NSArray*)keyTimes
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration = duration;

    CGMutablePathRef path = CGPathCreateMutable();

    int index = 0;
    for( NSValue* value in points )
    {
        CGPoint point = [value CGPointValue];
        if (index == 0)
        {
            CGPathMoveToPoint(path, NULL, point.x, point.y);
        }
        else
        {
            CGPathAddLineToPoint(path, NULL, point.x, point.y);
        }
        index++;
    }
    animation.path = path;
    CGPathRelease(path);
    return animation;
}
@end
