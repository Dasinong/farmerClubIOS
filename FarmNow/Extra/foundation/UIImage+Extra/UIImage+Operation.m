//
// UIImage+operation.m
// HomeService
//
// Created by liangzhe on 14-8-4.
// Copyright (c) 2014年 pre-team. All rights reserved.
//

#import "UIImage+Operation.h"

@implementation UIImage (Operation)

// 等比例缩放
- (UIImage*)scaleToSize:(CGSize)size
{
    CGFloat    width  = CGImageGetWidth(self.CGImage);
    CGFloat    height = CGImageGetHeight(self.CGImage);

    if (width < size.width || height < size.height)
    {
        return self;
    }

    float    verticalRadio   = size.height * 1.0 / height;
    float    horizontalRadio = size.width * 1.0 / width;

    float    radio           = 1;
    if(verticalRadio > 1 && horizontalRadio > 1)
    {
        radio = verticalRadio > horizontalRadio ? horizontalRadio : verticalRadio;
    }
    else
    {
        radio = verticalRadio < horizontalRadio ? verticalRadio : horizontalRadio;
    }

    width  = width * radio;
    height = height * radio;

    UIGraphicsBeginImageContext( CGSizeMake(width, height) );

    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, width, height)];

    // 从当前context中创建一个改变大小后的图片
    UIImage   *scaledImage = UIGraphicsGetImageFromCurrentImageContext();

    // 使当前的context出堆栈
    UIGraphicsEndImageContext();

    // 返回新的改变大小后的图片
    return scaledImage;
} /* scaleToSize */

- (UIImage*)rotate180
{
    UIImage   *image = nil;

    switch (self.imageOrientation)
    {
        case UIImageOrientationUp:
            {
                image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationDown];
                break;
            }

        case UIImageOrientationDown:
            {
                image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationUp];
                break;
            }

        case UIImageOrientationLeft:
            {
                image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationRight];
                break;
            }

        case UIImageOrientationRight:
            {
                image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationLeft];
                break;
            }

        case UIImageOrientationUpMirrored:
            {
                image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationDownMirrored];
                break;
            }

        case UIImageOrientationDownMirrored:
            {
                image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationUpMirrored];
                break;
            }

        case UIImageOrientationLeftMirrored:
            {
                image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationRightMirrored];
                break;
            }

        case UIImageOrientationRightMirrored:
            {
                image = [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationLeftMirrored];
                break;
            }

        default:
            {
            }
            break;
    } /* switch */

    return image;
}     /* rotate180 */

- (UIImage*)flipImage
{
    return [UIImage imageWithCGImage:self.CGImage scale:1 orientation:UIImageOrientationDownMirrored];

//    CGFloat    width        = CGImageGetWidth(self.CGImage);
//    CGFloat    height       = CGImageGetHeight(self.CGImage);
//
//    UIGraphicsBeginImageContext( CGSizeMake(width, height) );
//
//    CGContextRef    context = UIGraphicsGetCurrentContext();
//    CGContextScaleCTM(context, 1, 1);
//
//    // 绘制改变大小的图片
//    [self drawInRect:CGRectMake(0, 0, width, height)];
//
//    // 从当前context中创建一个改变大小后的图片
//    UIImage   *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
//
//    // 使当前的context出堆栈
//    UIGraphicsEndImageContext();
//
//    // 返回新的改变大小后的图片
//    return scaledImage;
} /* flipImage */

@end
