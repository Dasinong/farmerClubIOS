//
//  CCpproductDetailController.h
//  FarmNow
//
//  Created by 朱曦炽 on 16/3/1.
//  Copyright © 2016年 zheliang. All rights reserved.
//

#import "CBaseViewController.h"
#import "CIngredientDetailObject.h"

@interface CCpproductDetailController : CBaseViewController
@property (nonatomic, weak) UIViewController *popToViewController;
@property (nonatomic, strong) CIngredientDetailObject *detailObject;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, strong) NSString *type;
@end
