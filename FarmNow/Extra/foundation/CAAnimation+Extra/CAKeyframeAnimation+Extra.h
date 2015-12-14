//
//  CAKeyframeAnimation+Extra.h
//  AnimationEngine
//
//  Created by pre-team on 14-2-17.
//  Copyright (c) 2014年 pre-team. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "CAAnimation+Extra.h"

@interface CAKeyframeAnimation (Extra)
+ (id) animationWithKey:(NSString*)key
                                frameRate:(CGFloat)frameRate
                                   values:(NSArray*)values
                                 keyTimes:(NSArray*)keyTimes;

+ (id) backgroundAnimation:(CGFloat)frameRate
                                      values:(NSArray*)values
                                    keyTimes:(NSArray*)keyTimes;
+ (id) boundsAnimation:(CGFloat)frameRate
                                  values:(NSArray*)values
                                keyTimes:(NSArray*)keyTimes;
+ (id) positionAnimation:(CGFloat)frameRate
                                    values:(NSArray*)values
                                  keyTimes:(NSArray*)keyTimes;
+ (id) opacityAnimation:(CGFloat)frameRate
                                   values:(NSArray*)values
                                 keyTimes:(NSArray*)keyTimes;
+ (id) pathAnimation:(CGFloat)frameRate
                                values:(NSArray*)rectArray
                              keyTimes:(NSArray*)keyTimes;
@end


typedef enum
{
    ECAAnimationTimingFunctionLinear,
    ECAAnimationTimingFunctionEaseIn,
    ECAAnimationTimingFunctionEaseOut,
    ECAAnimationTimingFunctionEaseInEaseOut,
    ECAAnimationTimingFunctionDefault,
}CAAnimationTimingFunctionType;

@interface CAKeyframeAnimation (Extra2)
@property( nonatomic, assign ) CAAnimationTimingFunctionType timingFunctionType;

/*
 * axis
 *  旋转的轴, x,y,z
 */
+ (id) rotateWithDuration:(NSTimeInterval)duration
                  radians:(NSArray*)radians
                 keyTimes:(NSArray*)keyTimes
                     axis:(NSString*)axis;

+ (id) rotateZWithDuration:(NSTimeInterval)duration
                   radians:(NSArray*)radians//弧度
                  keyTimes:(NSArray*)keyTimes;
+ (id) rotateXWithDuration:(NSTimeInterval)duration
                   radians:(NSArray*)radians
                  keyTimes:(NSArray*)keyTimes;
+ (id) rotateYWithDuration:(NSTimeInterval)duration
                   radians:(NSArray*)radians
                  keyTimes:(NSArray*)keyTimes;

+(id) bounceWithDuration:(NSTimeInterval)duration
                   start:(CGPoint)start
                     end:(CGPoint)end;

+(id) bounceWithDuration:(NSTimeInterval)duration
                   start:(CGPoint)start
                  point1:(CGPoint)point1
                     end:(CGPoint)end;

+(id) positionWithDuration:(NSTimeInterval)duration
                     start:(CGPoint)start
                       end:(CGPoint)end;

+ (id) positionWithDuration:(NSTimeInterval)duration
                     points:(NSArray*)points//弧度
                   keyTimes:(NSArray*)keyTimes;
@end
