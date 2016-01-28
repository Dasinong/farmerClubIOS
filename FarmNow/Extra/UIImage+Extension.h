//
//  UIImage+Extension.h
//  maiqijia
//
//  Created by 曦炽 朱 on 14-8-15.
//  Copyright (c) 2014年 chamago. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize;
- (BOOL)isDarkImage;
@end
