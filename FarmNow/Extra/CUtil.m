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

@implementation CUtil
+ (void)processQR:(NSString *)result inVC:(UIViewController *)viewController {
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
