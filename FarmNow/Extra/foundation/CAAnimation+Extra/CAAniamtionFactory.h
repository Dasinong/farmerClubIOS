//
//  FAKEAniamtionEngine.h
//  Paper
//
//  Created by pre-team on 14-2-24.
//  Copyright (c) 2014年 pre-team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CAKeyframeAnimation+Extra.h"

#define ANIMATION_PROPERTY(name_, frames_)                     [AEAnimationProperty propertyWithName : (name_)frames : (frames_)]

#define ANIMATION_FRAME_WITH_OBJECT(duration_, value_)         [AEAnimationFrame frameWithDuration : (duration_)value : (value_)]

#define ANIMATION_FRAME_WITH_RECT(duration_, rect_)            [AEAnimationFrame frameWithDuration : (duration_)value :[NSValue valueWithCGRect:(rect_)]]

#define ANIMATION_FRAME_WITH_POINT(duration_, point_)          [AEAnimationFrame frameWithDuration : (duration_)value :[NSValue valueWithCGPoint:(point_)]]

#define ANIMATION_FRAME_WITH_FLOAT(duration_, value_)          [AEAnimationFrame frameWithDuration : (duration_)value :[NSNumber numberWithFloat:(value_)]]

#define ANIMATION_FRAME_WITH_COLOR(duration_, rrggbb_, alpha_) [AEAnimationFrame frameWithDuration : (duration_)value : (id)CGCOLOR_ALPHA(rrggbb_, alpha_)]

#define ANIMATION_FRAME_WITH_MASK_RECT(duration_, rect_)       [AEAnimationFrame frameWithDuration : (duration_)value : (id)MASK_PATH(rect_)]

@interface AEAnimationProperty : NSObject
@property(nonatomic, strong) NSString *property;
@property(nonatomic, strong)_TYPE(AEAnimationFrame *) NSMutableArray * frames;
+ (id)propertyWithName:(NSString *)property frames:(NSMutableArray *)frames;

- (CAKeyframeAnimation *)animationWithFrameRate:(CGFloat)frameRate;
- (void)updateLayerProperty:(CALayer *)layer;
@end

@interface AEAnimationFrame : NSObject
@property(nonatomic, assign) CGFloat duration;
@property(nonatomic, strong) id _TYPE(float, size, rect) value;

+ (id)frameWithDuration:(CGFloat)duration value:(id)value;
@end

@interface CAAniamtionFactory : NSObject
+ (CAAnimation *)animationWithProperties:(_TYPE(AEAnimationProperty *) NSArray *)properties
                               frameRate:(CGFloat)frameRate
                                   layer:(CALayer *)layer;

+ (CAAnimation *)animationWithFrameRate:(CGFloat)frameRate
                                  layer:(CALayer *)layer
                             properties:(id)protertyName, ...;
@end
