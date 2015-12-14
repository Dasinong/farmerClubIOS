//
//  MBProgressHUD+Express.h
//
//  Created by liangzhe on 14-6-17.
//  Copyright (c) 2014年 pre-team. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Express)

/**
 *  显示一个消息框
 *
 *  @param message 显示的消息
 *  @param view    消息框所在的view
 *  @param block   消息框消失后执行的回调
 *  @param duration 动画时间,默认是3s
 *  @return 消息框
 *
 *  @since 1.0
 */
+ (MBProgressHUD* )alertMessage:(NSString*)message
                         inView:(UIView*)view
                       duration:(NSTimeInterval)duration
                  finishedBlock:(MBProgressHUDCompletionBlock)block;
+ (MBProgressHUD* )alertMessage:(NSString*)message inView:(UIView*)view;


+ (MBProgressHUD* )alert:(NSString*)message;


+ (MBProgressHUD* )processing:(NSString*)message
                       inView:(UIView*)view
                finishedBlock:(MBProgressHUDCompletionBlock)block;

+ (MBProgressHUD* )processing:(NSString*)message
                finishedBlock:(MBProgressHUDCompletionBlock)block;

+ (MBProgressHUD* )processing:(NSString*)message;
@end
