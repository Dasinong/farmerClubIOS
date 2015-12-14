//
//  NSLog+Extra.m
//  BuildeTower
//
//  Created by liangzhe on 13-6-16.
//  Copyright (c) 2013年 liangzhe. All rights reserved.
//

#import "NSLog+Extra.h"

#if DEBUG == 1
  #ifdef __cplusplus
        extern "C" {
  #endif

  #define kNSLogIndentMaxLevel 20

    static NSString *_NSLogIndentMaxSpaces = @"----------------                                                             ";

    static NSInteger _NSLogIndentLevel  = 0;
    static NSString *_NSLogIndentSpaces = nil;

    void updateIndentSpaces()
    {
        _NSLogIndentSpaces = [_NSLogIndentMaxSpaces substringToIndex:1 + _NSLogIndentLevel * 2];
    }

    void logIndent()
    {
        if (_NSLogIndentLevel < kNSLogIndentMaxLevel - 1)
        {
            _NSLogIndentLevel++;
            updateIndentSpaces();
        }
    }

    void logUnIndent()
    {
        if (_NSLogIndentLevel > 0)
        {
            _NSLogIndentLevel--;
            updateIndentSpaces();
        }
    }

    NSString *indentSpaces()
    {
        if (!_NSLogIndentSpaces)
        {
            updateIndentSpaces();
        }

        return _NSLogIndentSpaces;
    }

  #ifdef __cplusplus
        }
  #endif
#endif	// DEBUG==1
