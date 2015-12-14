//
// Defines.h
//
// Created by liangzhe on 13-6-1.
// Copyright (c) 2013年 liangzhe. All rights reserved.
//

#import <Foundation/Foundation.h>

#define STATUSBARHEIGHT (([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)?20:0)




#ifdef DEBUG
    #define DEBUG 1
#else
    #define DEBUG 0
#endif

#define NavigationbarTintColor COLOR(0x697686)
#define SignImageWidth 233.0
#define notification(key) k##key##Notification
#define noticication_selector(key) notify##key:
#define nc_define_notification(key, value) NSString * const notification(key) = value
#define nc_declare_notification(key) extern NSString * const notification(key)

#define nc_subscribe(name_) \
[[NSNotificationCenter defaultCenter] addObserver : self selector : @selector(noticication_selector(name_)) name : notification(name_) object : nil]
#define nc_unsubscribe(name_) \
[[NSNotificationCenter defaultCenter] removeObserver : self name : notification(name_) object : nil]
#define nc_post(name_, userInfo_) \
[[NSNotificationCenter defaultCenter] postNotificationName : notification(name_) object : nil userInfo : userInfo_]

nc_declare_notification(SessionExpired);
nc_declare_notification(ChangeLocation);

#define _type(_nop)

#define _TYPE(_type, ...)
#define NSMutableArray_(_type, ...)         NSMutableArray
#define NSArray_(_type, ...)                NSArray
#define NSDictionary_(_type, ...)           NSDictionary
#define NSMutableDictionary_(_type, ...)    NSMutableDictionary
#define NSSet_(_type, ...)                  NSSet

#define _C(CONTAINER_TYPE, ITEM1_TYPE, ...) CONTAINER_TYPE

// NSDictionary
#define dict(...)                           [NSDictionary dictionaryWithObjectsAndKeys : __VA_ARGS__, nil]
#define DICT_M(...)                         [NSMutableDictionary dictionaryWithObjectsAndKeys : __VA_ARGS__, nil]
#define dict_mutable(capacity)              [NSMutableDictionary dictionaryWithCapacity : capacity]
#define dict_value(dict, key)               [dict valueForKey : key]
#define dict_update(dict, key, value)       [dict setValue : value forKey : key]
#define dict_flush(dict, path)              [dict writeToFile : path atomically : YES]
#define dict_for(objects_, keys_)           [NSDictionary dictionaryWithObjects : objects_ forKeys : keys_];

// array
#define OBJ_ARRAY(...)                      [NSArray arrayWithObjects : __VA_ARGS__, nil]
#define array(...)                          [NSArray arrayWithObjects : __VA_ARGS__, nil]
#define array_mutable(capacity)             [NSMutableArray arrayWithCapacity : capacity]
#define array_flush(array, path)            [array writeToFile : path atomically : YES]
#define array_value(array, index)           [array objectAtIndex_s : index]

// string
#define str_i(value)                        [NSString stringWithFormat : @"%d", value]

#define str_fmt(fmt, ...)                   [NSString stringWithFormat : fmt,##__VA_ARGS__]
#define STRING(fmt, ...)                    [NSString stringWithFormat : fmt,##__VA_ARGS__]


#define str_rect(rect)                      NSStringFromCGRect(rect)
#define str_size(size)                      NSStringFromCGSize(size)
#define str_point(point)                    NSStringFromCGPoint(point)

#define itos(value)                         [NSString stringWithFormat : @"%d", value]
#define stoi(str)                           [str intValue]
#define ftos(value)                         [NSString stringWithFormat : @"%f", value]
#define stof(str)                           [str floatValue]
// number
#define num_i(value)                        [NSNumber numberWithInt : value]
#define num_f(value)                        [NSNumber numberWithFloat : value]
#define I2Num(value)                        [NSNumber numberWithInteger : value]
// range
#define _range(loc, len)                    NSMakeRange(loc, len)

// thread
#define _at_main(sel, obj, wait)            [self performSelectorOnMainThread : sel withObject : obj waitUntilDone : wait];

#define _dispatch_background(_block) \
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), _block)

// path
#define _bundle(resource)              [[NSBundle mainBundle] pathForResource : resource ofType : nil]
#define path_append(path_, component_) [path_ stringByAppendingPathComponent : component_]

#define path_dir(path)                 [path stringByDeletingLastPathComponent]
#define path_ext(path)

#define path_exist(path)               [[NSFileManager defaultManager] fileExistsAtPath : path]

#define path_mkdir(path)               [[NSFileManager defaultManager] createDirectoryAtPath : path withIntermediateDirectories : YES attributes : nil error : nil]
#define path_rm(path)                  [[NSFileManager defaultManager] removeItemAtPath : path error : nil]

// url
#define _URL(url_)                     [NSURL URLWithString : url_]
#define _url_en(url_)                  [NSURL URLWithString :[url_ stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]

#define SIZE(w, h)                     CGSizeMake(w, h)
#define POINT(x, y)                    CGPointMake(x, y)
#define RECT(x, y, w, h)               CGRectMake(x, y, w, h)
#define RECT_WH(w, h)                  CGRectMake(0, 0, w, h)
#define SIZE2RECT(size)                CGRectMake(0, 0, size.width, size.height)

#define INSETS(left, top, right, bottom) UIEdgeInsetsMake(top, left, bottom, right)
#define INSETS_H(left, right) INSETS(left, 0, right, 0 )
#define INSETS_V(top, bottom) INSETS(0, top, 0, bottom)  // 通知中心




// 简单的计数器

#if DEBUG == 1
    #define counter(_name_)                int _counter##_name_ = 0;
    #define counter_modify(_name_, _value) _counter##_name_    += _value;
    #define counter_out(_name_)            if (_counter##_name_) {Info(@"counter "#_name_ ":%d", _counter##_name_); }
#else
    #define counter(_name_)                // int _name_ = 0;

    #define counter_modify(_name_, _value) // _name_ += _value;
    #define counter_out(_name_)            // Info( @##_name_"%d", _name_ );
#endif

#define counter_plus(_name_)             counter_modify(_name_, 1)

#if DEBUG == 1
    #define ShowBorder(view)               (view).layer.borderWidth = 1;
#else
    #define ShowBorder(view)
#endif

#define AngleToDegree(x) (x) * M_PI / 180.0

// 角度到弧度
#define D2R(degrees)     ( (degrees) * M_PI / 180.0 )
// 弧度到角度
#define R2D(radians)     ( (radians) * 180.0 / M_PI; )

extern BOOL isIPhone5Device();

#define iPhone5       isIPhone5Device()
#define is4InchDevice isIPhone5Device()

#define DEBUG_LAYOUT(_view)                                    \
    (_view).layer.borderColor = [UIColor randomColor].CGColor; \
    (_view).layer.borderWidth = 2; (_view).clipsToBounds = YES;

#define DEBUG_LAYOUT_COLOR_WIDTH(_view, color_, width_) \
    (_view).layer.borderColor = CGCOLOR(color_);        \
    (_view).layer.borderWidth = width_; (_view).clipsToBounds = YES;

#define STATIC_INSTACE_DECL(__shared) + (id)__shared;
#define SHARED_INSTACE_DECL(shared)

#define STATIC_INSTACE_IMPL(__shared)               \
    + (id)__shared                                  \
    {                                               \
        static id    instance = nil;                   \
        if (!instance)                              \
        {                                           \
            instance = [[[self class] alloc] init]; \
        }                                           \
        return instance;                            \
    }

#define SHARED_INSTACE_IMPL()                     STATIC_INSTACE_IMPL(shared)

// 属性定义
#define PROPERTY_DELEGATE(__protocol, __delegate) @property (nonatomic, weak) id <__protocol>    __delegate
#define PROPERTY(__class, __name) \
    @property (nonatomic, strong) __class   *__name

#define PROPERTY_GETTER(__class, __name)        \
    - (__class*)__name                         \
    {                                           \
        if (!_##__name) {                       \
            _##__name = [[__class alloc] init]; \
        }                                       \
        return _##__name;                       \
    }

#define STRING_PROPERTY(__name)                PROPERTY(NSString, __name)

#define IS_KIND_OF(_obj, _class)               ([_obj isKindOfClass:[_class class]])

#define VALUE_BETWEEN_MIN_MAX(value, min, max) MAX( MIN( (value), (max) ), (min) )

#define ARRAY(type_, name_, ...)   \
    type_ name_[] = {__VA_ARGS__}; \
    NSUInteger    name_##Count = sizeof(name_) / sizeof(name_[0]);

// #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
#define SuppressPerformSelectorLeakWarning(Stuff) \
    do { \
        _Pragma("clang diagnostic push") \
        _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
        Stuff; \
        _Pragma("clang diagnostic pop") \
    } while (0)
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )


