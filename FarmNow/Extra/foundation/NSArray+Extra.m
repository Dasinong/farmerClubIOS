//
// NSArray+Extra.m
// IntelligentHome
//
// Created by liangzhe on 周日 2013-11-10.
// Copyright (c) 2013年 liangzhe. All rights reserved.
//

#import "NSArray+Extra.h"
#import "Defines.h"

@implementation NSArray (Extra)
- (id)at:(NSInteger)index
{
    NSUInteger    realIndex = index;

    if (index < 0)
    {
        realIndex = self.count + index;
    }
    return [self objectAtIndex_s:realIndex];
}

- (id)head
{
    return [self at:0];
}

- (id)tail
{
    return [self lastObject];
}

- (id)objectAtIndex_s:(NSUInteger)index
{
    if (index < self.count)
    {
        return [self objectAtIndex:index];
    }

    return nil;
}

- (id)randomObject
{
    return [self objectAtIndex_s:arc4random_uniform( (u_int32_t)self.count - 1 )];
}

- (NSString*)join:(NSString*)separator
{
    return [self componentsJoinedByString:separator];
}

- (void)foreachPerformSelector:(SEL)selector
{
    [self makeObjectsPerformSelector:selector];
}

- (instancetype)foreach:( void (^)(NSUInteger index, id object, id array, BOOL*continuous) )processor
{
    if (!processor)
    {
        return self;
    }

    NSUInteger    count = self.count;

    for (int index = 0; index < count; index++)
    {
        BOOL    continuous = YES;
        processor(index, [self objectAtIndex:index], self, &continuous);

        if (!continuous)
        {
            break;
        }
    }

    return self;
} /* foreach */

- (instancetype)foreach_s:( void (^)(id object, BOOL*continuous) )processor
{
    if (!processor)
    {
        return self;
    }

    NSUInteger    count = self.count;

    for (int index = 0; index < count; index++)
    {
        BOOL    continuous = YES;
        processor([self objectAtIndex:index], &continuous);

        if (!continuous)
        {
            break;
        }
    }

    return self;
} /* foreach */

- (NSArray*)filter:( BOOL (^)(NSUInteger index, id element, NSArray*array) )processor
{
    if (!processor)
    {
        return nil;
    }

    NSMutableArray   *temp  = array_mutable(self.count / 2);
    NSUInteger        count = self.count;

    for (int index = 0; index < count; index++)
    {
        id      object   = [self objectAtIndex:index];
        BOOL    selected = processor(index, object, self);

        if (selected)
        {
            [temp addObject:object];
        }
    }

    return temp;
} /* filter */

- (NSArray*)filter_s:( BOOL (^)(id element) )processor
{
    if (!processor)
    {
        return nil;
    }

    NSMutableArray   *temp  = array_mutable(self.count / 2);
    NSUInteger        count = self.count;

    for (int index = 0; index < count; index++)
    {
        id      object   = [self objectAtIndex:index];
        BOOL    selected = processor(object);

        if (selected)
        {
            [temp addObject:object];
        }
    }

    return temp;
} /* filter_s */

- (NSArray*)collect_s:( id (^)(id element) )processor
{
    if (!processor)
    {
        return nil;
    }

    NSMutableArray   *temp  = array_mutable(self.count / 2);
    NSUInteger        count = self.count;

    for (int index = 0; index < count; index++)
    {
        id    object = [self objectAtIndex:index];
        id    result = processor(object);

        if (result)
        {
            [temp addObject:result];
        }
    }

    return temp;
} /* collect_s */

- (NSArray*)collect:( id (^)(NSUInteger index, id element, NSArray*array) )processor
{
    if (!processor)
    {
        return nil;
    }

    NSMutableArray   *temp  = array_mutable(self.count / 2);
    NSUInteger        count = self.count;

    for (int index = 0; index < count; index++)
    {
        id    object = [self objectAtIndex:index];
        id    result = processor(index, object, self);

        if (result)
        {
            [temp addObject:result];
        }
    }

    return temp;
} /* collect */

@end

/*
 * 可变参数检测哨兵
 */
const CGRect       RECT_GUARD = {
    {CGFLOAT_MAX, CGFLOAT_MAX}, {CGFLOAT_MAX, CGFLOAT_MAX}
};
const CGPoint      POINT_GUARD = {CGFLOAT_MAX, CGFLOAT_MAX};
const CGSize       SIZE_GUARD = {CGFLOAT_MAX, CGFLOAT_MAX};
const CGFloat      FLOAT_GUARD    = CGFLOAT_MAX;
const NSInteger    INTEGER_GUARD  = NSIntegerMax;
const NSInteger    UINTEGER_GUARD = NSUIntegerMax;

@implementation NSArray (VAArguemnts)
+ (NSArray*)arrayWithRects:(NSInteger)numberOfItems, ...
{
    NSMutableArray   *result = array_mutable(numberOfItems);

    va_list    arguments;
    va_start(arguments, numberOfItems);

    while (numberOfItems-- > 0)
    {
        CGRect    value = va_arg(arguments, CGRect);
        [result addObject:[NSValue valueWithCGRect:value]];
    }

    va_end(arguments);

    return result;
}

+ (NSArray*)arrayWithPoints:(NSInteger)numberOfItems, ...
{
    NSMutableArray   *result = array_mutable(numberOfItems);

    va_list    arguments;
    va_start(arguments, numberOfItems);

    while (numberOfItems-- > 0)
    {
        CGPoint    value = va_arg(arguments, CGPoint);
        [result addObject:[NSValue valueWithCGPoint:value]];
    }

    va_end(arguments);

    return result;
}

+ (NSArray*)arrayWithSizes:(NSInteger)numberOfItems, ...
{
    NSMutableArray   *result = array_mutable(numberOfItems);

    va_list    arguments;
    va_start(arguments, numberOfItems);

    while (numberOfItems-- > 0)
    {
        CGSize    value = va_arg(arguments, CGSize);
        [result addObject:[NSValue valueWithCGSize:value]];
    }

    va_end(arguments);

    return result;
}

+ (NSArray*)arrayWithFloats:(NSInteger)numberOfItems, ...
{
    NSMutableArray   *result = array_mutable(numberOfItems);

    va_list    arguments;
    va_start(arguments, numberOfItems);

    while (numberOfItems-- > 0)
    {
        double    value = va_arg(arguments, double);
        [result addObject:[NSNumber numberWithFloat:value]];
    }

    va_end(arguments);

    return result;
}

+ (NSArray*)arrayWithDegrees:(NSInteger)numberOfItems, ...
{
    NSMutableArray   *result = array_mutable(numberOfItems);

    va_list    arguments;
    va_start(arguments, numberOfItems);

    while (numberOfItems-- > 0)
    {
        double    value = va_arg(arguments, double);
        [result addObject:[NSNumber numberWithFloat:(value * M_PI / 180.0)]];
    }

    va_end(arguments);

    return result;
}

+ (NSArray*)arrayWithIntegers:(NSInteger)numberOfItems, ...
{
    NSMutableArray   *result = array_mutable(numberOfItems);

    va_list    arguments;
    va_start(arguments, numberOfItems);

    while (numberOfItems-- > 0)
    {
        NSInteger    value = va_arg(arguments, NSInteger);
        [result addObject:[NSNumber numberWithInteger:value]];
    }

    va_end(arguments);

    return result;
}

+ (NSArray*)arrayWithUIntegers:(NSUInteger)numberOfItems, ...
{
    NSMutableArray   *result = array_mutable(numberOfItems);

    va_list    arguments;
    va_start(arguments, numberOfItems);

    while (numberOfItems-- > 0)
    {
        NSUInteger    value = va_arg(arguments, NSUInteger);
        [result addObject:[NSNumber numberWithUnsignedInteger:value]];
    }

    va_end(arguments);

    return result;
}

@end

@implementation NSMutableArray (Extra)

- (void)random
{
    NSMutableArray   *array         = self;
    NSUInteger        numberOfItems = array.count;

    NSUInteger    idx               = numberOfItems - 1;

    while (idx)
    {
        [array exchangeObjectAtIndex:idx withObjectAtIndex:arc4random_uniform( (u_int32_t)idx )];
        idx--;
    }
} /* random */

- (void)moveItemAt:(NSUInteger)sourceIndex toIndex:(NSUInteger)targetIndex
{
    id    object = [self objectAtIndex:sourceIndex];

    [self removeObjectAtIndex:sourceIndex];
    [self insertObject:object atIndex:targetIndex];
}

- (void)addObject_s:(id)object
{
    if (object)
    {
        [self addObject:object];
    }
}

- (void)push:(id)object
{
    [self addObject_s:object];
}

- (id)pop
{
    id    object = [self lastObject];

    [self removeLastObject];

    return object;
}

@end

@implementation NSArray (CAKeyframeAnimation)
- (CGFloat)sum
{
    NSArray   *keyTimes = self;
    CGFloat    total    = 0.0f;

    for (NSNumber*time in keyTimes)
    {
        total += [time floatValue];
    }

    return total;
} /* sum */

/*
 * calculate keytimes from durations
 * exp:
 *    duration: 0  1   2  3
 *    keyTimes: 0 .16 .50 1
 */
- (NSArray*)keyTimes
{
    CGFloat    total           = [self sum];

    NSArray          *keyTimes = self;
    NSMutableArray   *result   = [NSMutableArray array];
    CGFloat           sum      = 0;

    for (int i = 0; i < keyTimes.count; i++)
    {
        sum += [[keyTimes objectAtIndex:i] floatValue];
        [result addObject:[NSNumber numberWithFloat:sum / total]];
    }

    return result;
} /* keyTimes */

@end
