//
// NSObject+TypeCheck.m
// Tourist
//
// Created by liangzhe on 周三 2014-02-26.
// Copyright (c) 2014年 liangzhe. All rights reserved.
//

#import "NSObject+TypeCheck.h"
#define IS_PRIMITIVE_CLASS(class_)                  \
    - (BOOL)is##class_                              \
    {                                               \
        return [self isKindOfClass:[class_ class]]; \
    }

#define IS_CLASS(obj_, class_) ([obj_ isKindOfClass:[class_ class]])

@implementation NSObject (TypeCheck)

IS_PRIMITIVE_CLASS(UIButton)
IS_PRIMITIVE_CLASS(UIView)
IS_PRIMITIVE_CLASS(UITableView)
IS_PRIMITIVE_CLASS(UILabel)
IS_PRIMITIVE_CLASS(UITableViewCell)
IS_PRIMITIVE_CLASS(UISlider)
IS_PRIMITIVE_CLASS(UIImageView)

IS_PRIMITIVE_CLASS(UIImage)

IS_PRIMITIVE_CLASS(NSString)
IS_PRIMITIVE_CLASS(NSMutableString)
IS_PRIMITIVE_CLASS(NSArray)
IS_PRIMITIVE_CLASS(NSMutableArray)
IS_PRIMITIVE_CLASS(NSDictionary)
IS_PRIMITIVE_CLASS(NSMutableDictionary)
IS_PRIMITIVE_CLASS(NSData)
IS_PRIMITIVE_CLASS(NSMutableData)

IS_PRIMITIVE_CLASS(UITapGestureRecognizer);

@end

@implementation NSObject (CAST)

- (id)cast:(Class)classType
{
    if ([self isKindOfClass:classType])
    {
        return self;
    }
    else
    {
        Warning( @"%@ not except type %@", self, NSStringFromClass(classType) );
    }

    return nil;
} /* cast */

+ (id)cast:(id)object
{
    if ([object isKindOfClass:[self class]])
    {
        return object;
    }
    else
    {
        Warning( @"%@ not except type %@", self, NSStringFromClass([self class]) );

        return nil;
    }
} /* cast */

@end
