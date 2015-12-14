//
// UIImage+ValidCheck.m
// SnapCoverFlow
//
// Created by liangzhe on 13-10-13.
// Copyright (c) 2013年 liangzhe. All rights reserved.
//

#import "UIImage+ValidCheck.h"
#import "NSLog+Extra.h"

#if DEBUG == 1
    void ValidImage( UIImage *image, NSString *path )
    {
        if (image.size.width == 0 || image.size.height == 0)
        {
            Warning(@"image at <%@> invalid", path);
        }
    }

#endif

@implementation UIImage (SAFE)

+ (UIImage*)image_s:(NSString*)nameOrPath
{
    if (!nameOrPath || nameOrPath.length == 0)
    {
        Warning(@"image at <%@> invalid", nameOrPath);

        return nil;
    }

    UIImage   *image = nil;
    if ([nameOrPath hasPrefix:@"/"])
    {
        image = [UIImage imageWithContentsOfFile:nameOrPath];
    }
    else
    {
        image = [UIImage imageNamed:nameOrPath];
    }

    ValidImage(image, nameOrPath);

    return image;
} /* image_s */

+ (UIImage*)resizableImage_s:(NSString*)nameOrPath insets:(UIEdgeInsets)insets
{
    UIImage   *image = [UIImage image_s:nameOrPath];

    if (image)
    {
        image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeTile];
    }

    return image;
}

@end
