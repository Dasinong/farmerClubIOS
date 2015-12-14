//
// NSLog+Extra.h
// http_pitch
//
// Created by liangzhe on 13-6-1.
// Copyright (c) 2013年 liangzhe. All rights reserved.
//

#ifndef http_pitch_NSLog_Extra_h
    #define http_pitch_NSLog_Extra_h

#import <Foundation/Foundation.h>
#import <libgen.h>
    //
    // LogUtility.h
    // VmagX2
    //
    // Created by wang on 11-8-20.
    // Copyright 2011 __MyCompanyName__. All rights reserved.
    //

#ifdef NSLog
  #undef NSLog
#endif   //

// 控制log的缩进层次
#ifndef DEBUG
        #define DEBUG 0
#endif

#if DEBUG == 1

  #ifdef __cplusplus
            extern "C" {
  #endif
        extern void logIndent();

        extern void logUnIndent();

        NSString* indentSpaces();

  #ifdef __cplusplus
            }
  #endif

  #ifdef TFLog
    #import "TestFlight.h"
            #define NSLog                   TFLog
  #endif
        #define USE_FUNTION_AS_IDENTIFIER 1
        #define __FILE_NAME__             basename( (char*)__FILE__ )
        #define NSLogIndent()   logIndent()
        #define NSLogUnIndent() logUnIndent();

  #if USE_FUNTION_AS_IDENTIFIER == 1
            #define kLogIdentifier [NSString stringWithFormat:@"%@%s.%d ", indentSpaces(), __func__, __LINE__]
  #else
            #define kLogIdentifier [NSString stringWithFormat:@"%@%s.%d ", indentSpaces(), (char*)__FILE_NAME__, __LINE__]
  #endif   // USE_FUNTION_AS_IDENTIFIER

#else /* if DEBUG == 1 */

        #define NSLogIndent()
        #define NSLogUnIndent()

        #define kLogIdentifier [NSString stringWithFormat:@"%s.%d ", __func__, __LINE__]
#endif  // DEBUG==1

    #define XCODE_COLORS_PREFIX @"\033["
    #define XCODE_COLORS_RESET_FG XCODE_COLORS_PREFIX @"fg;"
    #define XCODE_COLORS_RESET_BG XCODE_COLORS_PREFIX @"bg;"
    #define XCODE_COLORS_RESET_ALL XCODE_COLORS_PREFIX @";"

    #define XCODE_COLORS_ERROR XCODE_COLORS_PREFIX @"fg255,0,0;"     // @"ERROR"
    #define XCODE_COLORS_WARNING XCODE_COLORS_PREFIX @"fg255,0,255;" // @"WARNING"
    #define XCODE_COLORS_INFO  XCODE_COLORS_PREFIX @"fg128,128,128;" // @"I"

// #import <cdebug/debug.h>
#ifdef dlog
        #define TRACE(type, fmt, ...)                dlog(DEBUG_LOGLEVEL, @"%@:%@ " fmt XCODE_COLORS_RESET_ALL, type, kLogIdentifier,##__VA_ARGS__)
#else
        #define TRACE(type, fmt, ...)                NSLog(@"%@:%@ " fmt XCODE_COLORS_RESET_ALL, type, kLogIdentifier,##__VA_ARGS__)
#endif

#if DEBUG == 1
        #define Info(fmt, ...)                     TRACE(XCODE_COLORS_INFO, fmt,##__VA_ARGS__)
#else
        #define Info(fmt, ...)              // NSLog( @"info:%s.%d "fmt, __FUNCTION__, __LINE__, ##__VA_ARGS__)
#endif
// Log错误信息
    #define Error(fmt, ...)                      TRACE(XCODE_COLORS_ERROR, fmt,##__VA_ARGS__)
// Log异常信息
    #define Warning(fmt, ...)                    TRACE(XCODE_COLORS_WARNING, fmt,##__VA_ARGS__)

    #define NSLogProfile(fmt, ...)               NSLog(@"p: %4d %@" fmt, __LINE__, kLogIdentifier,##__VA_ARGS__)

    #define NSLogUnexpectedObject(_obj)          Warning(@"unexpected object:%@", _obj);
    #define NSLogUnexpectedValue(_value)         Warning(@"unexpected object:%d", (int)_value);

    #define NSLogTrace()                         Info(@"")

    #define NSLogRect(_rect)                     Info( @"%@", NSStringFromCGRect(_rect) )
    #define NSLogSize(_size)                     Info( @"%@", NSStringFromCGSize(_size) )
    #define NSLogPoint(_point)                   Info( @"%@", NSStringFromCGPoint(_point) )

    #define NSLogObject(_text, _object)          Info(@ _text ":%@", _object)

    #define NSLogAssert(_check_, fmt, ...)       if ( !(_check_) ) {Info(fmt,##__VA_ARGS__); } NSAssert( (_check_), fmt,##__VA_ARGS__ );

    #define NSLogValidIndexInArray(index, array) NSLogAssert( (index) < (array).count, @"%d of out bounds : [0...%d)", (index), (array).count );

#ifndef USE_FUNTION_AS_IDENTIFIER
        #define USE_FUNTION_AS_IDENTIFIER 0
#endif

#if USE_FUNTION_AS_IDENTIFIER == 1
        #define NSTraceFunc()                      Info(@" trace");
#else
        #define NSTraceFunc()                      Info( @"[%@ %@]", NSStringFromClass([self class]), NSStringFromSelector(_cmd) );
#endif  // USE_FUNTION_AS_IDENTIFIER


    #define NSLogCreateURLFailed(string) \
        Error( @"can not create NSURL from string:%@", (string) );

    #define NSLogCreateRequestFailed(url) \
        Error( @"can not create NSURL from url:%@", (url) );
#endif  // http_pitch_NSLog_Extra_h
