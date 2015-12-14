//
//  UIImage+Extra.h
//  IntelligentHome
//
//  Created by liangzhe on 周二 2013-11-12.
//  Copyright (c) 2013年 liangzhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extra_Operation)
- (UIImage*) flipImage;
-(UIImage*)scaleToSize:(CGSize)size;
@end
