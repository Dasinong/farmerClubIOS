//
// NSObject+TypeCheck.h
// Tourist
//
// Created by liangzhe on 周三 2014-02-26.
// Copyright (c) 2014年 liangzhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#define IS_PRIMITIVE_CLASS_DECLARE(class_) \
    - (BOOL)is##class_
@interface NSObject (TypeCheck)

IS_PRIMITIVE_CLASS_DECLARE(UIButton);
IS_PRIMITIVE_CLASS_DECLARE(UIView);
IS_PRIMITIVE_CLASS_DECLARE(UITableView);
IS_PRIMITIVE_CLASS_DECLARE(UILabel);
IS_PRIMITIVE_CLASS_DECLARE(UITableViewCell);
IS_PRIMITIVE_CLASS_DECLARE(UISlider);
IS_PRIMITIVE_CLASS_DECLARE(UIImageView);

IS_PRIMITIVE_CLASS_DECLARE(UIImage);

IS_PRIMITIVE_CLASS_DECLARE(NSString);
IS_PRIMITIVE_CLASS_DECLARE(NSMutableString);
IS_PRIMITIVE_CLASS_DECLARE(NSArray);
IS_PRIMITIVE_CLASS_DECLARE(NSMutableArray);
IS_PRIMITIVE_CLASS_DECLARE(NSDictionary);
IS_PRIMITIVE_CLASS_DECLARE(NSMutableDictionary);
IS_PRIMITIVE_CLASS_DECLARE(NSData);
IS_PRIMITIVE_CLASS_DECLARE(NSMutableData);

IS_PRIMITIVE_CLASS_DECLARE(UITapGestureRecognizer);

@end

@interface NSObject (CAST)
+ (id)cast:(id)object;
- (id)cast:(Class)classType;
@end

#define CAST(type, obj) [obj cast :[type class]]
