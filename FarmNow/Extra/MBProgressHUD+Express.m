//
// MBProgressHUD+Express.m
//
// Created by liangzhe on 14-6-17.
// Copyright (c) 2014年 pre-team. All rights reserved.
//

#import "MBProgressHUD+Express.h"

@implementation MBProgressHUD (Express)
+ (MBProgressHUD* )alertMessage:(NSString*)message
                         inView:(UIView*)view
                       duration:(NSTimeInterval)duration
                  finishedBlock:(MBProgressHUDCompletionBlock)block
{
    if (!view)
    {
        view = [[UIApplication sharedApplication] keyWindow];
    }

    MBProgressHUD   *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];

    hud.mode             = MBProgressHUDModeText;
    hud.labelText        = @"";
    hud.detailsLabelText = message;
    hud.completionBlock  = block;

    [hud hide:YES afterDelay:duration];

    return hud;
} /* alertMessage */

+ (MBProgressHUD* )alertMessage:(NSString*)message inView:(UIView*)view
{
    return [MBProgressHUD alertMessage:message inView:view duration:3 finishedBlock:nil];
}

+ (MBProgressHUD* )alert:(NSString*)message
{
    return [MBProgressHUD alertMessage:message inView:nil duration:3  finishedBlock:nil];
}

+ (MBProgressHUD* )info:(NSString*)message
{
    return [MBProgressHUD alertMessage:message inView:nil duration:0.8  finishedBlock:nil];
}

+ (MBProgressHUD*)alert:(NSString*)message finishedBlock:(MBProgressHUDCompletionBlock)block
{
    return [MBProgressHUD alert:message finishedBlock:block];
}

+ (MBProgressHUD* )processing:(NSString*)message
                       inView:(UIView*)view
                finishedBlock:(MBProgressHUDCompletionBlock)block
{
    if (!view)
    {
        view = [[UIApplication sharedApplication] keyWindow];
    }

    MBProgressHUD   *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];

    hud.mode             = MBProgressHUDModeIndeterminate;
    hud.labelText        = @"";
    hud.detailsLabelText = message;
    hud.completionBlock  = block;

    return hud;
} /* processing */

+ (MBProgressHUD* )processing:(NSString*)message
                finishedBlock:(MBProgressHUDCompletionBlock)block
{
    return [MBProgressHUD processing:message inView:nil finishedBlock:block];
}

+ (MBProgressHUD* )processing:(NSString*)message
{
    return [MBProgressHUD processing:message inView:nil finishedBlock:nil];
}

@end
