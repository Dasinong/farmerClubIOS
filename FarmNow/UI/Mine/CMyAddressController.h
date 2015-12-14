//
//  CMyAddressController.h
//  FarmNow
//
//  Created by zheliang on 15/10/21.
//  Copyright © 2015年 zheliang. All rights reserved.
//

#import "CBaseViewController.h"

@protocol CMyAddressControllerDelegate <NSObject>

- (void)addressSelected:(NSString*)address;

@end

@interface CMyAddressController : CBaseViewController
@property (weak, nonatomic) id<CMyAddressControllerDelegate> delegate;
@end
