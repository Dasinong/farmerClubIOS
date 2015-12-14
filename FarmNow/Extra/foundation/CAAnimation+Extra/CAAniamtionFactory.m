//
//  FAKEAniamtionEngine.m
//  Paper
//
//  Created by pre-team on 14-2-24.
//  Copyright (c) 2014年 pre-team. All rights reserved.
//

#import "CAAniamtionFactory.h"
#import "CAAnimationGroup+Extra.h"

@implementation CAAniamtionFactory

+ (CAAnimation*) animationWithProperties:(NSArray*)properties
                               frameRate:(CGFloat)frameRate
                                   layer:(CALayer*)layer

{
    [properties makeObjectsPerformSelector:@selector(updateLayerProperty:) withObject:layer];
    
    if (properties.count == 1)
    {
        AEAnimationProperty* property = [properties objectAtIndex:0];
        CAKeyframeAnimation* animation = [property animationWithFrameRate:frameRate];
        return animation;
    }
    else
    {
        NSMutableArray* animations = [NSMutableArray array];
        for (AEAnimationProperty* other in properties)
        {
            [animations addObject:[other animationWithFrameRate:frameRate]];
        }
        
        CAAnimationGroup* groupAnimation = [ CAAnimationGroup animation];
        
        groupAnimation.animations = animations;
        groupAnimation.removedOnCompletion = NO;
        groupAnimation.fillMode = kCAFillModeForwards;
        [groupAnimation updateDurationWithMaxValue];
        
        [layer addAnimation:groupAnimation forKey:@"group"];
        
        return groupAnimation;
    }
}

+ (CAAnimation*)animationWithFrameRate:(CGFloat)frameRate
                                 layer:(CALayer*)layer
                            properties:(id)protertyName,...
{
    va_list ap;
    va_start(ap, protertyName);
    id value = protertyName;
    
    
    AEAnimationProperty* property = nil;
    NSMutableArray* propertiyes = [NSMutableArray array];
    
    while (value)
    {
        if ([value isKindOfClass:[NSString class]])
        {
            property = [AEAnimationProperty propertyWithName:value
                                                      frames:[NSMutableArray array]];
            [propertiyes addObject:property];
        }
        else if( [value isKindOfClass:[AEAnimationFrame class]])
        {
            if (!property)
            {
                NSLog(@"Error:argument format:property-1-name property-1-frame-1  property-1-frame-2, .... property-2-name property-2-frame-1  property-2-frame-2, .... ");
                break;
            }
            [property.frames addObject:value];
        }
        else
        {
            NSLog(@"Error:unexcept object. <%@>", value);
        }
        value = va_arg(ap, id);
    }
    
    return [self animationWithProperties:propertiyes frameRate:frameRate layer:layer];
}
@end

@implementation AEAnimationProperty
+ (id) propertyWithName:(NSString*)property frames:(NSMutableArray*)frames
{
    AEAnimationProperty* instance = [[AEAnimationProperty alloc] init];
    instance.property = property;
    instance.frames = frames;
    return instance;
}

- (CAKeyframeAnimation*) animationWithFrameRate:(CGFloat)frameRate
{
    NSMutableArray* values = [NSMutableArray array];
    NSMutableArray* keyTimes = [NSMutableArray array];
    
    for (AEAnimationFrame* frame in self.frames)
    {
        [keyTimes addObject:[NSNumber numberWithFloat:frame.duration]];
        [values addObject:frame.value];
    }
    return [CAKeyframeAnimation animationWithKey:self.property
                                       frameRate:frameRate
                                          values:values
                                        keyTimes:keyTimes];
}

- (void) updateLayerProperty:(CALayer *)layer
{
    if (self.frames.count == 0)
    {
        return;
    }
    
    AEAnimationFrame* frame = [self.frames objectAtIndex:0];
    
    if ([self.property isEqualToString: @"bounds"])
    {
        layer.bounds = [frame.value CGRectValue];
    }
    else if( [self.property isEqualToString:@"position"])
    {
        layer.position = [frame.value CGPointValue];
    }
    else if( [self.property isEqualToString:@"backgroundColor"] )
    {
        layer.backgroundColor = (__bridge CGColorRef)frame.value;
    }
    else if( [self.property isEqualToString:@"path"] )
    {
        [(CAShapeLayer*)layer  setPath:(CGPathRef)frame.value];
    }
    else if( [self.property isEqualToString:@"opacity"])
    {
        layer.opacity = [frame.value floatValue];
    }
    else
    {
        NSLog(@"Warning:unhandle property:%@",self.property);
    }
}
@end

@implementation AEAnimationFrame

+(id) frameWithDuration:(CGFloat)duration
                  value:(id)value
{
    AEAnimationFrame* frame = [[AEAnimationFrame alloc] init];
    frame.duration = duration;
    frame.value = value;
    return frame;
}

@end