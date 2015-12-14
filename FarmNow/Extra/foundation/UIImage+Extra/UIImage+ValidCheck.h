//
// UIImage+ValidCheck.h
// SnapCoverFlow
//
// Created by liangzhe on 13-10-13.
// Copyright (c) 2013年 liangzhe. All rights reserved.
//

#import <UIKit/UIKit.h>

#if DEBUG == 1
void ValidImage( UIImage *image, NSString *path );
#else
#define ValidImage( image, path ) \
    if (image == nil || image.size.width == 0 || image.size.height == 0) \
    { \
        Warning(@"image at <%@> invalid", path); \
    }
#endif


@interface UIImage (SAFE)
+ (UIImage*)image_s:(NSString*)nameOrPath;
+ (UIImage*)resizableImage_s:(NSString*)nameOrPath insets:(UIEdgeInsets)insets;
@end


#define IMAGE(name_) [UIImage image_s : (name_)]

/**
 *  可以缩放的图片
 */
#define RESIZABLE_IMAGE(name_, insets_) [UIImage resizableImage_s : (name_) insets : (insets_)]
