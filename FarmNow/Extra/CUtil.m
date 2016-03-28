//
//  CUtil.m
//  FarmNow
//
//  Created by 朱曦炽 on 16/3/8.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CUtil.h"
#import "CWebViewController.h"
#import "MBProgressHUD+Express.h"
#import "CRedeemCouponModel.h"
#import "CScannedCouponDetailViewController.h"
#import "CSetRefModel.h"

@implementation CUtil
+ (void)processQR:(NSString *)result inVC:(UIViewController<CStockViewControllerDelegate> *)viewController {
    if ([result containsString:@"couponId="] && [result containsString:@"userId="]) {
        NSArray *urlComponents = [result componentsSeparatedByString:@"&"];
        
        NSInteger userId = 0;
        NSInteger couponId = 0;
        
        for (NSString *keyValuePair in urlComponents)
        {
            NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
            NSString *key = [[pairComponents firstObject] stringByRemovingPercentEncoding];
            NSString *value = [[pairComponents lastObject] stringByRemovingPercentEncoding];
            
            if ([key isEqualToString:@"couponId"]) {
                couponId = [value integerValue];
            }
            else if ([key isEqualToString:@"userId"]) {
                userId = [value integerValue];
            }
        }
        
        [MBProgressHUD showHUDAddedTo:viewController.view animated:YES];
        CRedeemCouponParam *params = [CRedeemCouponParam new];
        params.userId = userId;
        params.couponId = couponId;
        
        [CRedeemCouponModel requestWithParams:POST params:params completion:^(CRedeemCouponModel *model, JSONModelError *err) {
            [MBProgressHUD hideHUDForView:viewController.view animated:NO];
            if (model) {
                CScannedCouponDetailViewController *controller = [viewController.storyboard instantiateViewControllerWithIdentifier:@"CScannedCouponDetailViewController"];
                controller.hidesBottomBarWhenPushed = YES;
                CCouponCampaign *campaign = [[CCouponCampaign alloc] init];
                campaign.id = model.coupon.campaignId;
                controller.couponCampaign = campaign;
                [viewController.navigationController pushViewController:controller animated:YES];
            }
            else {
                //[MBProgressHUD alert:@"没有权限"];
            }
        }];
    }
    else if ([result containsString:@"function=refcode"] && [result containsString:@"code="]) {
        NSArray *urlComponents = [result componentsSeparatedByString:@"&"];
        
        NSString *code;
        
        for (NSString *keyValuePair in urlComponents)
        {
            NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
            NSString *key = [[pairComponents firstObject] stringByRemovingPercentEncoding];
            NSString *value = [[pairComponents lastObject] stringByRemovingPercentEncoding];
            
            if ([key isEqualToString:@"code"]) {
                code = value;
            }
        }
        
        if (code) {
            CSetRefParams* params = [CSetRefParams new];
            params.refcode = code;
            [CSetRefModel requestWithParams:POST params:params completion:^(CSetRefModel *model, JSONModelError *err) {
                if (model && err== nil) {
                    [MBProgressHUD alert:model.message];
                }
            }];
        }
        else {
             [MBProgressHUD alert:@"非法的二维码"];
        }
    }
    else if ([result hasPrefix:@"http://winsafe.cn/?b="] || (result.length == 25 && [result containsString:@"##"])) {
        
        NSString *boxcode;
        
        if ([result hasPrefix:@"http://winsafe.cn/?b="]) {
            boxcode = [result substringFromIndex:[@"http://winsafe.cn/?b=" length]];
        }
        else {
            boxcode = result;
        }
        
        CStockViewController *controller = [viewController.storyboard controllerWithID:@"CStockViewController"];
        controller.delegate = viewController;
        controller.boxcode = boxcode;
        [viewController presentViewController:controller animated:YES completion:nil];
    }
    else {
        CWebViewController* webController  = [viewController.storyboard controllerWithID:@"CWebViewController"];
        //		webController.title                     = data;
        webController.address = result;
        webController.hideToolbar = NO;
        webController.hidesBottomBarWhenPushed = YES;
        [viewController.navigationController pushViewController:webController animated:YES];
    }
}

@end
