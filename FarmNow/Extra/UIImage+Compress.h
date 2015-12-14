//
//  UIImage+Compress.h
//  Laundry System
//
//  Created by zheliang on 14/10/23.
//  Copyright (c) 2014年 liangzhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Compress)
+(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;
@end
